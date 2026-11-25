// Tests for the Forge's database store (contract 1.5, renderer 1.6.0): node --test forge.test.mjs
// The sync tests need nothing else; the renderer test needs Playwright and skips without it.
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { createRequire } from 'node:module';
import { boardDocs, assembleBoard, planSync, recordVersions, liveRows, CHUNK_MAX } from './forge.mjs';

const HERE = path.dirname(fileURLToPath(import.meta.url));
const example = () => JSON.parse(fs.readFileSync(path.join(HERE, 'forge.example.json'), 'utf8'));
const many = (n, f) => Array.from({ length: n }, (_, i) => f(i));

test('boardDocs splits the board into a meta doc and chunks cut by the records themselves, and assembleBoard puts it back exactly', () => {
  const d = example();
  d.decisions = many(200, (i) => ({ date: '2026-11-01', title: `d${i}`, detail: 'x', by: 'jase', memory_ref: `d${i}` }));
  const docs = boardDocs(d);
  assert.ok(docs.has('meta'));
  const ids = docs.get('meta').order.decisions;
  assert.ok(ids.length > 2, 'several chunks');
  for (const id of ids) assert.ok(docs.get(id).items.length <= CHUNK_MAX);
  assert.equal(docs.get('meta').data.asks, undefined, 'records live only in chunks');
  assert.deepEqual(assembleBoard([...docs].map(([id, body]) => ({ id, body }))), d);
});

test('adding a record at the top, the bottom or the middle changes only the chunk it lands in', () => {
  const base = example();
  base.decisions = many(200, (i) => ({ date: '2026-11-01', title: `d${i}`, detail: 'x', by: 'jase', memory_ref: `d${i}` }));
  const before = boardDocs(base);
  const changed = (d) => { const after = boardDocs(d); return [...after].filter(([id, b]) => id !== 'meta' && JSON.stringify(before.get(id)) !== JSON.stringify(b)).map(([id]) => id); };
  const add = (at) => { const d = structuredClone(base); d.decisions.splice(at, 0, { date: '2026-11-25', title: `new at ${at}`, detail: 'x', by: 'jase', memory_ref: 'n' }); return d; };
  for (const at of [0, 200, 100]) assert.ok(changed(add(at)).length <= 2, `a record added at ${at} rewrites at most its own chunk (and a new one if it starts one): ${changed(add(at))}`);
});

test('chunks written by the 1.6.0 layout (numbered, no order in meta) still read back in order', () => {
  const d = example();
  const old = [{ id: 'meta', body: { kind: 'meta', data: (({ asks, decisions, work, ...m }) => m)(d) } },
    { id: 'asks-1', body: { kind: 'chunk', section: 'asks', n: 1, items: d.asks.slice(2) } },
    { id: 'asks-0', body: { kind: 'chunk', section: 'asks', n: 0, items: d.asks.slice(0, 2) } },
    { id: 'work-0', body: { kind: 'chunk', section: 'work', n: 0, items: d.work } },
    { id: 'decisions-0', body: { kind: 'chunk', section: 'decisions', n: 0, items: d.decisions } }];
  assert.deepEqual(assembleBoard(old), d);
});

test('an empty section writes no chunk and reads back as an empty list', () => {
  const d = example(); d.decisions = [];
  const docs = boardDocs(d);
  assert.equal([...docs.keys()].some((k) => k.startsWith('decisions-')), false);
  assert.deepEqual(assembleBoard([...docs].map(([id, body]) => ({ id, body }))).decisions, []);
});

test('first sync loads everything, as creates without a version', () => {
  const plan = planSync(boardDocs(example()), { docs: {} });
  assert.ok(plan.writes.length >= 2);
  for (const w of plan.writes) { assert.equal(w.op, 'set'); assert.equal(w.if_version, undefined); }
});

test('a second sync after recording writes nothing; changing one ask writes only its chunk and meta, pinned to their versions', () => {
  const d = example();
  let state = { docs: {} };
  let plan = planSync(boardDocs(d), state);
  state = recordVersions(state, plan, Object.fromEntries(plan.writes.map((w, i) => [w.id, i + 1])));
  assert.equal(planSync(boardDocs(d), state).writes.length, 0);
  d.asks[0].title = 'Changed title';
  plan = planSync(boardDocs(d), state);
  const ids = plan.writes.map((w) => w.id);
  assert.equal(ids.length, 1);
  assert.ok(ids[0].startsWith('asks-'));
  assert.equal(plan.writes[0].if_version, state.docs[ids[0]].version);
});

test('a chunk that disappears is deleted, pinned; recording the delete drops it from the state', () => {
  const d = example();
  d.work = many(120, (i) => ({ id: `w-${900 + i}`, title: 't', state: 'queued' }));
  let state = { docs: {} };
  let plan = planSync(boardDocs(d), state);
  state = recordVersions(state, plan, Object.fromEntries(plan.writes.map((w) => [w.id, 5])));
  d.work = [];
  plan = planSync(boardDocs(d), state);
  const dels = plan.writes.filter((w) => w.op === 'delete');
  assert.ok(dels.length >= 2 && dels.every((w) => w.id.startsWith('work-') && w.if_version === 5));
  state = recordVersions(state, plan, Object.fromEntries(dels.map((w) => [w.id, 'deleted'])));
  assert.ok(!Object.keys(state.docs).some((k) => k.startsWith('work-')));
});

test('a write left unrecorded stays pending, so the next sync repeats it', () => {
  const d = example();
  const plan = planSync(boardDocs(d), { docs: {} });
  const ids = plan.writes.map((w) => w.id);
  const state = recordVersions({ docs: {} }, plan, { [ids[0]]: 1 });
  assert.deepEqual(planSync(boardDocs(d), state).writes.map((w) => w.id), ids.slice(1));
});

test('the renderer joins the database exactly as forge.mjs does, for the new and the 1.6.0 layout', () => {
  const html = fs.readFileSync(path.join(HERE, 'forge.html'), 'utf8');
  const src = html.slice(html.indexOf("var CHUNKED = ['asks'"), html.indexOf('function loadFromDb('));
  const pageAssemble = new Function(src + '; return assembleBoard;')();
  const d = example();
  d.decisions = many(150, (i) => ({ date: '2026-11-01', title: `d${i}`, detail: 'x', by: 'jase', memory_ref: `d${i}` }));
  const docs = [...boardDocs(d)].map(([id, body]) => ({ id, body })).reverse(); // the store returns them in any order
  assert.deepEqual(pageAssemble(docs), JSON.parse(JSON.stringify(assembleBoard(docs))));
  assert.deepEqual(pageAssemble(docs).decisions.map((x) => x.title), d.decisions.map((x) => x.title));
});

test('rows lists every open ask, open milestone and live work row, and nothing closed or done', () => {
  const d = example();
  const rows = liveRows(d);
  assert.equal(rows.filter((r) => r.startsWith('ask ')).length, d.asks.filter((a) => !a.closed).length);
  assert.equal(rows.filter((r) => r.startsWith('work ')).length, d.work.filter((w) => w.state !== 'done').length);
  assert.ok(!rows.some((r) => r.includes('a-000')), 'a closed ask is left out');
});

test('the renderer draws from the database when the board says store db, and from inline data otherwise', async (t) => {
  let chromium;
  try { ({ chromium } = createRequire(import.meta.url)('playwright')); } catch { t.skip('playwright not installed'); return; }
  const html = fs.readFileSync(path.join(HERE, 'forge.html'), 'utf8');
  const PH = '<script type="application/json" id="forge-data"></script>';
  const d = example();
  const docs = [...boardDocs(d)].map(([id, body]) => ({ id, body }));
  const shell = JSON.stringify({ forge: d.forge, project: { name: d.project.name, store: 'db' } });
  const stub = `<script>window.claude = { use: (n) => Promise.resolve(n === 'db' ? { collection: (c) => ({ onSnapshot: (next) => { setTimeout(() => next({ docs: window.__DOCS.map((x) => ({ id: x.id, exists: true, data: () => x.body, metadata: { fromCache: false } })), metadata: { fromCache: false } }), 20); return () => {}; } }) } : null) }; window.__DOCS = ${JSON.stringify(docs)};</script>`;
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'forge-test-'));
  fs.writeFileSync(path.join(dir, 'db.html'), html.replace(PH, stub + PH.replace('></script>', `>${shell}</script>`)));
  fs.writeFileSync(path.join(dir, 'inline.html'), html.replace(PH, PH.replace('></script>', `>${JSON.stringify(d)}</script>`)));
  const b = await chromium.launch();
  try {
    for (const f of ['db.html', 'inline.html']) {
      const p = await b.newPage();
      const errs = []; p.on('pageerror', (e) => errs.push(e.message));
      await p.goto('file://' + path.join(dir, f));
      await p.waitForSelector('#a-001', { timeout: 5000 });
      assert.deepEqual(errs, [], f);
      assert.equal(await p.$$eval('section[aria-labelledby=needs] .ask', (x) => x.length), d.asks.filter((a) => !a.closed).length, f);
      await p.close();
    }
  } finally { await b.close(); }
});
