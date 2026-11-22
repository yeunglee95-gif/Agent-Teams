// Tests for the Forge's database store (contract 1.5, renderer 1.6.0): node --test forge.test.mjs
// The sync tests need nothing else; the renderer test needs Playwright and skips without it.
import test from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
import os from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { createRequire } from 'node:module';
import { boardDocs, assembleBoard, planSync, recordVersions, liveRows, CHUNK } from './forge.mjs';

const HERE = path.dirname(fileURLToPath(import.meta.url));
const example = () => JSON.parse(fs.readFileSync(path.join(HERE, 'forge.example.json'), 'utf8'));
const many = (n, f) => Array.from({ length: n }, (_, i) => f(i));

test('boardDocs splits the board into a meta doc and fixed-size chunks, and assembleBoard puts it back exactly', () => {
  const d = example();
  d.decisions = many(CHUNK * 2 + 3, (i) => ({ date: '2026-11-01', title: `d${i}`, detail: 'x', by: 'jase', memory_ref: `d${i}` }));
  const docs = boardDocs(d);
  assert.ok(docs.has('meta'));
  assert.deepEqual([...docs.keys()].filter((k) => k.startsWith('decisions-')), ['decisions-0', 'decisions-1', 'decisions-2']);
  assert.equal(docs.get('decisions-2').items.length, 3);
  assert.equal(docs.get('meta').data.asks, undefined, 'records live only in chunks');
  assert.deepEqual(assembleBoard([...docs].map(([id, body]) => ({ id, body }))), d);
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

test('a second sync after recording writes nothing; changing one ask writes only its chunk, pinned to its version', () => {
  const d = example();
  let state = { docs: {} };
  let plan = planSync(boardDocs(d), state);
  state = recordVersions(state, plan, Object.fromEntries(plan.writes.map((w, i) => [w.id, i + 1])));
  assert.equal(planSync(boardDocs(d), state).writes.length, 0);
  d.asks[0].title = 'Changed title';
  plan = planSync(boardDocs(d), state);
  assert.deepEqual(plan.writes.map((w) => w.id), ['asks-0']);
  assert.equal(plan.writes[0].if_version, state.docs['asks-0'].version);
});

test('a chunk that disappears is deleted, pinned; recording the delete drops it from the state', () => {
  const d = example();
  d.work = many(CHUNK + 1, (i) => ({ id: `w-${900 + i}`, title: 't', state: 'queued' }));
  let state = { docs: {} };
  let plan = planSync(boardDocs(d), state);
  state = recordVersions(state, plan, Object.fromEntries(plan.writes.map((w) => [w.id, 5])));
  d.work = d.work.slice(0, CHUNK);
  plan = planSync(boardDocs(d), state);
  assert.deepEqual(plan.writes, [{ op: 'delete', id: 'work-1', if_version: 5 }]);
  state = recordVersions(state, plan, { 'work-1': 'deleted' });
  assert.equal(state.docs['work-1'], undefined);
});

test('a write left unrecorded stays pending, so the next sync repeats it', () => {
  const d = example();
  const plan = planSync(boardDocs(d), { docs: {} });
  const ids = plan.writes.map((w) => w.id);
  const state = recordVersions({ docs: {} }, plan, { [ids[0]]: 1 });
  assert.deepEqual(planSync(boardDocs(d), state).writes.map((w) => w.id), ids.slice(1));
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
