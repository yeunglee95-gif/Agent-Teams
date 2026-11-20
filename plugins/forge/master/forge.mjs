#!/usr/bin/env node
// forge.mjs: the one tool behind every project's Forge board. Node 22, no packages.
//
// Why it exists: on 2026-09-19 the Platform Forge drifted because status was typed twice,
// once on the board and once in ROADMAP.md, and the two disagreed. From the Forge template
// on, forge/forge.json is the one source: this script validates it, inlines it into the
// published board, generates the ROADMAP status block from it, and gates the repo on it.
//
// Run from a project repo as `node forge/forge.mjs <command>`; `help` lists the commands.
// Paths come from this file's location: forge/ is its folder, the repo root its parent.
// In the master folder (Agent-Teams plugins/forge/master, recognised by forge.example.json
// beside this file) the repo root is three levels up and the example is the data file.

import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const RENDERER_VERSION = '1.5.1';
const MASTER_FILES = ['forge.html', 'forge.schema.json', 'forge.mjs'];
const PLACEHOLDER = '<script type="application/json" id="forge-data"></script>';
const MARK_START = '<!-- GENERATED:forge from forge/forge.json by forge/forge.mjs. Do not edit by hand. -->';
const MARK_END = '<!-- /GENERATED:forge -->';
const STATES = ['needs-you', 'running', 'queued', 'later', 'parked', 'done']; // renderer's priority order
const PRIO = { now: 0, soon: 1, later: 2 };
const HOUR = 3600000;

// ---------- paths ----------

function makeCtx(forgeDir, repoRoot) {
  const master = fs.existsSync(path.join(forgeDir, 'forge.example.json'));
  return {
    forgeDir, repoRoot, master,
    data: path.join(forgeDir, master ? 'forge.example.json' : 'forge.json'),
    schema: path.join(forgeDir, 'forge.schema.json'),
    html: path.join(forgeDir, 'forge.html'),
    board: path.join(forgeDir, 'board.html'),
    banned: path.join(forgeDir, 'banned.txt'),
    roadmap: path.join(repoRoot, 'ROADMAP.md'),
    memory: path.join(repoRoot, 'MEMORY.md'),
    archive: path.join(repoRoot, 'ARCHIVE.md'), // older decisions move here; a memory_ref may match either
  };
}
const SELF_DIR = path.dirname(fileURLToPath(import.meta.url));
const SELF_IS_MASTER = fs.existsSync(path.join(SELF_DIR, 'forge.example.json'));
const CTX = makeCtx(SELF_DIR, SELF_IS_MASTER ? path.resolve(SELF_DIR, '..', '..') : path.resolve(SELF_DIR, '..'));

const rel = (ctx, p) => path.relative(ctx.repoRoot, p) || p;
const readJson = (p) => JSON.parse(fs.readFileSync(p, 'utf8'));
function refuseInMaster(ctx, cmd) {
  if (!ctx.master) return false;
  console.log(`forge ${cmd}: refused in the master folder; run it from a project repo (master mode only validates and checks the example).`);
  return true;
}

// ---------- small validator for the subset forge.schema.json uses ----------

function isDate(s) {
  const m = /^(\d{4})-(\d{2})-(\d{2})$/.exec(s);
  if (!m) return false;
  const d = new Date(Date.UTC(+m[1], +m[2] - 1, +m[3]));
  return d.getUTCFullYear() === +m[1] && d.getUTCMonth() === +m[2] - 1 && d.getUTCDate() === +m[3];
}
function isDateTime(s) {
  const m = /^(\d{4}-\d{2}-\d{2})T(\d{2}):(\d{2}):(\d{2})(\.\d+)?(Z|[+-](\d{2}):(\d{2}))$/.exec(s);
  if (!m || !isDate(m[1]) || +m[2] > 23 || +m[3] > 59 || +m[4] > 59) return false;
  if (m[7] && (+m[7] > 23 || +m[8] > 59)) return false;
  return !Number.isNaN(Date.parse(s));
}
function isUri(s) { try { new URL(s); return true; } catch { return false; } }
function kindOf(v) { return v === null ? 'null' : Array.isArray(v) ? 'array' : Number.isInteger(v) ? 'integer' : typeof v; }
function typeOk(v, t) {
  if (t === 'integer') return Number.isInteger(v);
  if (t === 'number') return typeof v === 'number' && Number.isFinite(v);
  if (t === 'array') return Array.isArray(v);
  if (t === 'object') return v !== null && typeof v === 'object' && !Array.isArray(v);
  return typeof v === t;
}

function checkNode(node, schema, root, p, errs) {
  if (schema.$ref) schema = root.$defs[schema.$ref.replace('#/$defs/', '')];
  if (schema.type && !typeOk(node, schema.type)) return errs.push(`${p}: expected ${schema.type}, got ${kindOf(node)}`);
  // closed.by gets its own clearer message from the rules below, so the generic enum line is skipped there.
  if (schema.enum && !schema.enum.includes(node) && !/\.closed\.by$/.test(p)) {
    errs.push(`${p}: ${JSON.stringify(node)} is not one of ${schema.enum.join(', ')}`);
  }
  if (typeof node === 'string') {
    if (schema.pattern && !new RegExp(schema.pattern, 'u').test(node)) errs.push(`${p}: ${JSON.stringify(node)} does not match ${schema.pattern}`);
    if (schema.minLength != null && [...node].length < schema.minLength) errs.push(`${p}: shorter than ${schema.minLength} characters`);
    if (schema.format === 'date' && !isDate(node)) errs.push(`${p}: ${JSON.stringify(node)} is not a real date (YYYY-MM-DD)`);
    if (schema.format === 'date-time' && !isDateTime(node)) errs.push(`${p}: ${JSON.stringify(node)} is not an ISO 8601 date-time with offset`);
    if (schema.format === 'uri' && !isUri(node)) errs.push(`${p}: ${JSON.stringify(node)} is not a URL`);
  }
  if (typeof node === 'number') {
    if (schema.minimum != null && node < schema.minimum) errs.push(`${p}: ${node} is below the minimum ${schema.minimum}`);
    if (schema.maximum != null && node > schema.maximum) errs.push(`${p}: ${node} is above the maximum ${schema.maximum}`);
  }
  if (Array.isArray(node)) {
    if (schema.maxItems != null && node.length > schema.maxItems) errs.push(`${p}: ${node.length} items, at most ${schema.maxItems}`);
    if (schema.items) node.forEach((v, i) => checkNode(v, schema.items, root, `${p}[${i}]`, errs));
  }
  if (typeOk(node, 'object')) {
    const props = schema.properties || {};
    for (const k of schema.required || []) if (!(k in node)) errs.push(`${p}: missing required "${k}"`);
    for (const [k, v] of Object.entries(node)) {
      const kp = `${p}.${k}`;
      if (props[k]) { checkNode(v, props[k], root, kp, errs); continue; }
      const base = k.endsWith('_zh') ? props[k.slice(0, -3)] : null;
      const baseType = base && (base.$ref ? root.$defs[base.$ref.replace('#/$defs/', '')].type : base.type);
      if (baseType === 'string') { if (typeof v !== 'string') errs.push(`${kp}: expected string, got ${kindOf(v)}`); continue; }
      if (schema.additionalProperties === false) errs.push(`${kp}: unknown key (the contract does not allow it)`);
      else if (typeOk(schema.additionalProperties, 'object')) checkNode(v, schema.additionalProperties, root, kp, errs);
    }
  }
}

function checkRules(d, errs, now = Date.now()) {
  const asks = Array.isArray(d.asks) ? d.asks : [];
  const work = Array.isArray(d.work) ? d.work : [];
  for (const [name, list] of [['asks', asks], ['work', work]]) {
    const seen = new Map();
    list.forEach((x, i) => {
      if (!x || x.id == null) return;
      if (seen.has(x.id)) errs.push(`$.${name}[${i}].id: duplicate id "${x.id}" (first at $.${name}[${seen.get(x.id)}])`);
      else seen.set(x.id, i);
    });
  }
  const askIds = new Set(asks.map((a) => a && a.id));
  work.forEach((w, i) => {
    if (w && w.ask != null && !askIds.has(w.ask)) errs.push(`$.work[${i}].ask: "${w.ask}" names no ask in $.asks`);
  });
  asks.forEach((a, i) => {
    if (!a || typeof a !== 'object') return;
    if (!a.closed && a.priority === 'now' && !(typeof a.holds_up === 'string' && a.holds_up.trim())) {
      errs.push(`$.asks[${i}].holds_up: open ask with priority "now" must say what it holds up`);
    }
    if (a.closed && typeOk(a.closed, 'object') && !['jase', 'default'].includes(a.closed.by)) {
      errs.push(`$.asks[${i}].closed.by: ${JSON.stringify(a.closed.by)}; only "jase" or "default" may close an ask (an agent never closes its own)`);
    }
    if (a.default && isDate(a.default.fires_on) && isDate(a.opened) && a.default.fires_on < a.opened) {
      errs.push(`$.asks[${i}].default.fires_on: ${a.default.fires_on} is before opened ${a.opened}`);
    }
  });
  // Words we use (1.3), rules in the build spec 5.3a: one entry per term (ignoring case, full-width forms and inner spacing);
  // no empty field; no em dash in English text (a _zh twin may use the Chinese dash ——); the file must say forge "1.3" or later.
  const glossary = Array.isArray(d.glossary) ? d.glossary : [];
  const fv = /^1\.(\d+)$/.exec(String(d.forge || ''));
  if (glossary.length && fv && Number(fv[1]) < 3) errs.push(`$.glossary: needs contract 1.3 or later; set forge to "1.3" (this file says ${JSON.stringify(d.forge)}) and run update for the 1.3 renderer`);
  const terms = new Map();
  glossary.forEach((g, i) => {
    if (!g || typeof g !== 'object') return;
    if (typeof g.term === 'string') {
      const key = g.term.normalize('NFKC').trim().replace(/\s+/g, ' ').toLowerCase();
      if (!key) errs.push(`$.glossary[${i}].term: empty`);
      else if (terms.has(key)) errs.push(`$.glossary[${i}].term: duplicate term ${JSON.stringify(g.term)} (first at $.glossary[${terms.get(key)}]; terms are unique ignoring case)`);
      else terms.set(key, i);
    }
    if (typeof g.means === 'string' && !g.means.trim()) errs.push(`$.glossary[${i}].means: empty; say what the term means`);
    for (const [k, v] of Object.entries(g)) {
      if (typeof v !== 'string') continue;
      if (k !== 'term' && k !== 'means' && !v.trim()) errs.push(`$.glossary[${i}].${k}: empty; drop the field or fill it`);
      if (!k.endsWith('_zh') && v.includes('\u2014')) errs.push(`$.glossary[${i}].${k}: holds an em dash; use a colon, comma or full stop`);
    }
  });
  // Status and usage (1.4), rules in the build spec 5.3b. Dates are checked by the schema's date format; these are the rest.
  const p = d.project && typeof d.project === 'object' ? d.project : {};
  const ms = Array.isArray(d.milestones) ? d.milestones : [];
  const usage = Array.isArray(d.usage) ? d.usage : [];
  const uses14 = ['started', 'finish', 'last_shipped'].filter((k) => k in p).map((k) => `$.project.${k}`)
    .concat(ms.some((m) => m && ['target', 'ships', 'progress'].some((k) => k in m)) ? ['$.milestones[].target/ships/progress'] : [])
    .concat(['usage', 'usage_note'].filter((k) => k in d).map((k) => `$.${k}`));
  if (uses14.length && fv && Number(fv[1]) < 4) errs.push(`${uses14[0]}: a 1.4 field needs contract 1.4 or later; set forge to "1.4" (this file says ${JSON.stringify(d.forge)}) and run update for the 1.4 renderer`);
  const prev = p.finish && Array.isArray(p.finish.previous) ? p.finish.previous : [];
  prev.forEach((x, i) => {
    if (i && x && prev[i - 1] && isDate(x.changed_on) && isDate(prev[i - 1].changed_on) && x.changed_on < prev[i - 1].changed_on) errs.push(`$.project.finish.previous[${i}].changed_on: ${x.changed_on} is before the entry above it; keep previous oldest first`);
    if (x && typeof x.why === 'string' && !x.why.trim()) errs.push(`$.project.finish.previous[${i}].why: empty; say why the target moved`);
  });
  ms.forEach((m, i) => { if (m && typeof m.ships === 'string' && !m.ships.trim()) errs.push(`$.milestones[${i}].ships: empty; drop the field or say what becomes available`); });
  const keys = new Map();
  usage.forEach((u, i) => {
    if (!u || typeof u !== 'object') return;
    if (typeof u.model === 'string' && !u.model.trim()) errs.push(`$.usage[${i}].model: empty; name the model`);
    if (isDate(u.on) && u.on > hkNow().slice(0, 10)) errs.push(`$.usage[${i}].on: ${u.on} is in the future; log tokens on the day they were used`);
    const key = [u.on, u.model, u.role || ''].map((v) => String(v == null ? '' : v).trim().toLowerCase()).join('|');
    if (keys.has(key)) errs.push(`$.usage[${i}]: duplicate day, model and role ${JSON.stringify([u.on, u.model, u.role || ''].join(', '))} (first at $.usage[${keys.get(key)}]; add to that entry instead)`);
    else keys.set(key, i);
  });
  // A malformed updated is already reported by the schema's date-time format.
  if (typeof d.updated === 'string' && isDateTime(d.updated) && Date.parse(d.updated) - now > HOUR) errs.push(`$.updated: ${d.updated} is more than 1 hour in the future`);
}

// Returns { data, text, failures }. data is null when the file cannot be read or parsed.
function validate(ctx) {
  const failures = [];
  let text, data = null;
  try { text = fs.readFileSync(ctx.data, 'utf8'); } catch { return { data, text, failures: [`${rel(ctx, ctx.data)}: not found`] }; }
  try { data = JSON.parse(text); } catch (e) { return { data: null, text, failures: [`${rel(ctx, ctx.data)}: invalid JSON (${e.message})`] }; }
  let schema;
  try { schema = readJson(ctx.schema); } catch (e) { return { data, text, failures: [`${rel(ctx, ctx.schema)}: cannot read schema (${e.message})`] }; }
  checkNode(data, schema, schema, '$', failures);
  checkRules(data, failures);
  return { data, text, failures };
}

// ---------- ROADMAP block ----------

const cell = (v) => (v == null ? '' : String(v)).replace(/\r?\n/g, ' ').replace(/\|/g, '\\|');
const table = (head, rows) => [`| ${head.join(' | ')} |`, `|${head.map(() => '---').join('|')}|`, ...rows.map((r) => `| ${r.map(cell).join(' | ')} |`)];
const byOrder = (a, b) => (a.order == null ? 1e9 : a.order) - (b.order == null ? 1e9 : b.order);
const prioKey = (w) => (w.urgent ? 0 : 1) * 100 + STATES.indexOf(w.state) * 10;

function sortOpenAsks(asks) {
  // Same order as the board (renderer 1.5.1): priority, then id number.
  const num = (a) => { const m = /(\d+)$/.exec(a.id || ''); return m ? +m[1] : 1e9; };
  return asks.filter((a) => !a.closed).sort((a, b) => {
    const pa = PRIO[a.priority] ?? 3, pb = PRIO[b.priority] ?? 3;
    if (pa !== pb) return pa - pb;
    return num(a) - num(b);
  });
}

function roadmapBlock(d) {
  const asks = sortOpenAsks((d.asks || []).slice());
  const work = (d.work || []).filter((w) => w.state !== 'done').sort((a, b) => prioKey(a) - prioKey(b) || byOrder(a, b));
  const none = (rows, msg) => (rows.length ? [] : ['', msg]);
  return [
    MARK_START,
    `_Updated ${d.updated} by ${d.updated_by}._`,
    '',
    '### Milestones',
    '',
    ...table(['Code', 'Name', 'State', 'Label', 'Exit', 'Closed'], (d.milestones || []).map((m) => [m.code, m.name, m.state, m.label, m.exit, m.closed_on])),
    '',
    '### Needs Jase',
    '',
    ...table(['Id', 'Title', 'Kind', 'Priority', 'Holds up', 'Default fires'], asks.map((a) => [a.id, a.title, a.kind, a.priority, a.holds_up, a.default && a.default.fires_on])),
    ...none(asks, '_Nothing open._'),
    '',
    '### Work',
    '',
    ...table(['Id', 'Title', 'State', 'Band', 'Next'], work.map((w) => [w.id, w.title, w.state, w.band, w.next])),
    ...none(work, '_Nothing open._'),
    MARK_END,
  ].join('\n');
}

// Returns { current, start, end } for the block in text, or null when the markers are absent.
function findBlock(text) {
  const start = text.indexOf(MARK_START);
  if (start < 0) return null;
  const endAt = text.indexOf(MARK_END, start);
  if (endAt < 0) return null;
  const end = endAt + MARK_END.length;
  return { current: text.slice(start, end), start, end };
}

function diffLines(cur, exp, label) {
  const a = cur.split('\n'), b = exp.split('\n');
  let i = 0;
  while (i < a.length && i < b.length && a[i] === b[i]) i++;
  const out = [`--- ${label} (current)`, '+++ generated from forge.json', `@@ block line ${i + 1} @@`];
  for (let k = i; k < i + 4 && (k < a.length || k < b.length); k++) {
    if (a[k] === b[k]) { out.push(` ${a[k]}`); continue; }
    if (k < a.length) out.push(`-${a[k]}`);
    if (k < b.length) out.push(`+${b[k]}`);
  }
  return out;
}

// Returns failure lines (empty when the block matches).
function roadmapCheck(ctx, data) {
  if (!fs.existsSync(ctx.roadmap)) return [`${rel(ctx, ctx.roadmap)}: not found`];
  const blk = findBlock(fs.readFileSync(ctx.roadmap, 'utf8'));
  if (!blk) return [`${rel(ctx, ctx.roadmap)}: no generated forge block; run \`node forge/forge.mjs roadmap\``];
  const want = roadmapBlock(data);
  if (blk.current === want) return [];
  return [`${rel(ctx, ctx.roadmap)}: generated block drifted from forge.json`, ...diffLines(blk.current, want, rel(ctx, ctx.roadmap))];
}

// ---------- commands ----------

function cmdValidate(ctx) {
  const { failures } = validate(ctx);
  failures.forEach((f) => console.log(`FAIL ${f}`));
  if (failures.length) { console.log(`forge validate: ${failures.length} failure(s)`); return 1; }
  console.log(`forge validate: OK (${rel(ctx, ctx.data)})`);
  return 0;
}

function build(ctx) {
  const { text, failures } = validate(ctx);
  if (failures.length) {
    failures.forEach((f) => console.log(`FAIL ${f}`));
    console.log(`forge build: refused, validate has ${failures.length} failure(s)`);
    return 1;
  }
  const html = fs.readFileSync(ctx.html, 'utf8');
  if (!html.includes(PLACEHOLDER)) { console.log(`FAIL ${rel(ctx, ctx.html)}: placeholder ${PLACEHOLDER} not found`); return 1; }
  // Inside a script element only these sequences can end or confuse it; both sit inside JSON strings.
  const safe = text.trim().replace(/<\/script/gi, (m) => '<\\/' + m.slice(2)).replace(/<!--/g, '\\u003c!--');
  const out = html.replace(PLACEHOLDER, () => PLACEHOLDER.replace('></script>', `>${safe}</script>`));
  fs.writeFileSync(ctx.board, out);
  console.log(`forge build: wrote ${rel(ctx, ctx.board)} (${Buffer.byteLength(out)} bytes)`);
  return 0;
}

function cmdRoadmap(ctx, args) {
  const checkOnly = args.includes('--check');
  if (!checkOnly && refuseInMaster(ctx, 'roadmap')) return 1;
  const { data, failures } = validate(ctx);
  if (!data) { failures.forEach((f) => console.log(`FAIL ${f}`)); return 1; }
  if (checkOnly) {
    const lines = roadmapCheck(ctx, data);
    lines.forEach((l, i) => console.log(i === 0 ? `FAIL ${l}` : l));
    if (lines.length) return 1;
    console.log(`forge roadmap --check: OK (${rel(ctx, ctx.roadmap)} matches forge.json)`);
    return 0;
  }
  if (failures.length) { failures.forEach((f) => console.log(`FAIL ${f}`)); console.log('forge roadmap: refused, validate failed'); return 1; }
  const text = fs.existsSync(ctx.roadmap) ? fs.readFileSync(ctx.roadmap, 'utf8') : '';
  const blk = findBlock(text);
  const want = roadmapBlock(data);
  let out;
  if (blk) out = text.slice(0, blk.start) + want + text.slice(blk.end);
  else out = (text ? text.replace(/\s*$/, '\n\n') : '') + '## Status (generated from the Forge)\n\n' + want + '\n';
  fs.writeFileSync(ctx.roadmap, out);
  console.log(`forge roadmap: ${blk ? 'rewrote' : 'appended'} the generated block in ${rel(ctx, ctx.roadmap)}`);
  return 0;
}

function readBanned(ctx) {
  if (!fs.existsSync(ctx.banned)) return [];
  return fs.readFileSync(ctx.banned, 'utf8').split(/\r?\n/).map((l) => l.trim()).filter((l) => l && !l.startsWith('#'));
}

// First JSON path whose key or string value matches re, or null.
function findHit(node, re, p = '$') {
  if (typeof node === 'string') return re.test(node) ? p : null;
  if (Array.isArray(node)) { for (let i = 0; i < node.length; i++) { const h = findHit(node[i], re, `${p}[${i}]`); if (h) return h; } return null; }
  if (node && typeof node === 'object') {
    for (const [k, v] of Object.entries(node)) {
      if (re.test(k)) return `${p}.${k} (key)`;
      const h = findHit(v, re, `${p}.${k}`); if (h) return h;
    }
  }
  return null;
}

// Plain asks (renderer 1.5.0, Jase 2026-11-20): Jase reads Needs you as a checklist, so ask text follows
// the caveman voice (toolkit plugin) with the limits in the build spec 5.2. Only the English fields are read.
const ASK_LIMITS = { titleWords: 10, sentenceWords: 20, whySentences: 2 };
// Abbreviations whose stop does not end a sentence, so "e.g. Vercel" stays one sentence.
const ABBR = /\b(e\.g|i\.e|vs|etc|No|Dr|Mr|Ms|Mrs|Inc|Ltd|approx|incl)\.$/i;
function splitAt(t, re) {
  const out = [];
  for (const x of String(t).replace(/`[^`]*`/g, 'X').split(re)) { if (!x.trim()) continue; if (out.length && ABBR.test(out[out.length - 1])) out[out.length - 1] += ' ' + x; else out.push(x); }
  return out;
}
// Sentences end at . ! ? (also before a closing quote, bracket or bold mark) or a line break; clauses also at ;.
function sentences(t) { return splitAt(t, /(?<=[.!?]["')\]*]*)\s+|\n+/); }
function clauses(t) { return splitAt(t, /(?<=[.!?;]["')\]*]*)\s+|\n+/); }
function words(t) { return String(t).replace(/`[^`]*`/g, 'X').split(/\s+/).filter((w) => /[\p{L}\p{N}]/u.test(w)).length; }
function plainAsk(a, i) {
  const out = [], at = `$.asks[${i}] ${a.id}`;
  if (a.title && words(a.title) > ASK_LIMITS.titleWords) out.push(`${at}.title: ${words(a.title)} words; say the one thing to do in ${ASK_LIMITS.titleWords} or fewer`);
  if (a.why && sentences(a.why).length > ASK_LIMITS.whySentences) out.push(`${at}.why: ${sentences(a.why).length} sentences; keep ${ASK_LIMITS.whySentences} and move detail to ref`);
  const texts = [['title', a.title], ['why', a.why], ['holds_up', a.holds_up], ['recommendation', a.recommendation], ['default.action', a.default && a.default.action]];
  (a.options || []).forEach((o, j) => texts.push([`options[${j}].label`, o.label], [`options[${j}].consequence`, o.consequence]));
  (a.reasoning || []).forEach((r, j) => texts.push([`reasoning[${j}]`, r]));
  ((a.guide && a.guide.steps) || []).forEach((st, j) => texts.push([`guide.steps[${j}]`, st.text]));
  for (const [k, t] of texts) {
    if (!t) continue;
    if (/\u2014/.test(t)) out.push(`${at}.${k}: em dash; use a comma, colon or period`);
    const long = clauses(t).find((x) => words(x) > ASK_LIMITS.sentenceWords);
    if (long) out.push(`${at}.${k}: a ${words(long)}-word sentence; split it to ${ASK_LIMITS.sentenceWords} words or fewer`);
  }
  return out;
}

function cmdCheck(ctx) {
  const fails = [], warns = [];
  const { data, text, failures } = validate(ctx);
  fails.push(...failures); // includes the closed.by rule: only jase or default
  if (data) {
    if (ctx.master) warns.push('master folder: roadmap drift and memory_ref checks skipped for the example data');
    else {
      const rl = roadmapCheck(ctx, data);
      if (rl.length) fails.push(rl.join('\n'));
      const logs = [ctx.memory, ctx.archive].filter((p) => fs.existsSync(p)).map((p) => fs.readFileSync(p, 'utf8'));
      const searched = [ctx.memory, ctx.archive].map((p) => rel(ctx, p) + (fs.existsSync(p) ? '' : ' (missing)')).join(' and ');
      if (!logs.length) fails.push(`${searched}: neither found, cannot check decisions[].memory_ref`);
      else (data.decisions || []).forEach((dec, i) => {
        if (dec && typeof dec.memory_ref === 'string' && !logs.some((t) => t.includes(dec.memory_ref))) {
          fails.push(`$.decisions[${i}].memory_ref: not found in ${searched}: ${JSON.stringify(dec.memory_ref)}`);
        }
      });
    }
    for (const line of readBanned(ctx)) {
      const m = /^\/(.+)\/([a-z]*)$/.exec(line);
      let re;
      try { re = m ? new RegExp(m[1], m[2].replace(/g/g, '')) : new RegExp(line); } catch (e) { fails.push(`banned.txt: bad pattern ${line} (${e.message})`); continue; }
      if (re.test(text)) fails.push(`banned pattern ${line} matches at ${findHit(data, re) || '$ (spans JSON structure)'}`);
    }
    // Board hygiene (1.1): warnings, so an old board still passes its gate while the build chat catches up.
    const today = hkNow().slice(0, 10);
    (data.asks || []).forEach((a, i) => {
      if (!a || a.closed) return;
      if (a.default && isDate(a.default.fires_on) && a.default.fires_on < today) {
        warns.push(`$.asks[${i}] ${a.id}: default was due ${a.default.fires_on} and the ask is still open; fire it (close with by "default") or set a new fires_on`);
      }
      if (a.kind === 'action' && !(a.guide && Array.isArray(a.guide.steps) && a.guide.steps.length)) {
        warns.push(`$.asks[${i}] ${a.id}: action ask without guide.steps; add the steps Jase follows under What to do`);
      }
      ((a.guide && a.guide.steps) || []).forEach((st, j) => {
        if (st && st.url && !/^https:\/\//.test(st.url)) warns.push(`$.asks[${i}].guide.steps[${j}].url: not https, the board will not link it`);
      });
      plainAsk(a, i).forEach((w) => warns.push(w));
    });
    // Status panel (1.4), build spec 5.3b: the panel hides what is missing, so these only warn.
    const pj = data.project || {};
    if (!pj.started) warns.push('$.project.started: missing; set it once to the day the build began, so the board shows days building');
    (data.milestones || []).forEach((m, i) => { if (m && m.state !== 'done' && !m.target) warns.push(`$.milestones[${i}] ${m.code}: open milestone without a target date (and a ships line)`); });
    (data.team || []).forEach((t, i) => { if (t && !/^jase\b/i.test(t.person || '') && !(t.person && t.person !== 'AI') && !(t.who && t.who.model)) warns.push(`$.team[${i}] ${t.role}: desk without who.model; the Team room shows "Model not set"`); });
    const days = (Array.isArray(data.usage) ? data.usage : []).map((u) => u && u.on).filter(isDate).sort();
    if (!days.length) warns.push('$.usage: empty; after each agent run add its subagent_tokens to that day\'s entry for the model (build spec 5.3b)');
    else if (Date.parse(today) - Date.parse(days[days.length - 1]) > 7 * 24 * HOUR) warns.push(`$.usage: newest entry is ${days[days.length - 1]}, more than 7 days old; log each agent run's tokens`);
    if (!(Array.isArray(data.glossary) && data.glossary.length)) warns.push('$.glossary: empty; every Forge keeps its project\'s Words we use (build spec 5.3a): add each term the turn it is defined');
    if (!(data.project && data.project.links && data.project.links.chat)) warns.push('$.project.links.chat: missing; the board cannot show Answer in (set it to this build chat\'s claude.ai/code/session_... link)');
    // No age warning: the board moves only for asks, decisions and milestones (Jase, 2026-11-12). It is behind
    // when an open ask's default is overdue, which the asks check above already warns about.
  }
  const html = fs.existsSync(ctx.html) ? fs.readFileSync(ctx.html, 'utf8') : '';
  const v = /<!--\s*forge renderer (\d+)\.(\d+)\.(\d+)/.exec(html);
  if (!v) fails.push(`${rel(ctx, ctx.html)}: missing or without the version comment <!-- forge renderer X.Y.Z -->`);
  else if (v[1] !== RENDERER_VERSION.split('.')[0]) fails.push(`${rel(ctx, ctx.html)}: renderer major ${v[1]}, master major is ${RENDERER_VERSION.split('.')[0]}`);
  else if (`${v[1]}.${v[2]}.${v[3]}` !== RENDERER_VERSION) warns.push(`${rel(ctx, ctx.html)}: renderer ${v[1]}.${v[2]}.${v[3]}, master is ${RENDERER_VERSION}; run update`);
  fails.forEach((f) => console.log(`FAIL ${f}`));
  warns.forEach((w) => console.log(`WARN ${w}`));
  console.log(`forge check: ${fails.length} failures, ${warns.length} warnings`);
  return fails.length ? 1 : 0;
}

function hkNow() { return new Date(Date.now() + 8 * HOUR).toISOString().slice(0, 19) + '+08:00'; }

function cmdTouch(ctx, args) {
  if (refuseInMaster(ctx, 'touch')) return 1;
  let data;
  try { data = readJson(ctx.data); } catch (e) { console.log(`FAIL ${rel(ctx, ctx.data)}: ${e.message}`); return 1; }
  data.updated = hkNow();
  if (args[0]) data.updated_by = args[0];
  fs.writeFileSync(ctx.data, JSON.stringify(data, null, 2) + '\n');
  console.log(`forge touch: updated ${data.updated} by ${data.updated_by}`);
  return 0;
}

function findMaster(ctx) {
  const tried = [];
  for (const p of [process.env.FORGE_MASTER, path.resolve(ctx.repoRoot, '..', 'Agent-Teams', 'plugins', 'forge', 'master')]) {
    if (!p) continue;
    const abs = path.resolve(p);
    tried.push(abs);
    if (MASTER_FILES.every((f) => fs.existsSync(path.join(abs, f)))) return { dir: abs, tried };
  }
  return { dir: null, tried };
}

function copyMaster(masterDir, ctx) {
  fs.mkdirSync(ctx.forgeDir, { recursive: true });
  for (const f of MASTER_FILES) {
    fs.copyFileSync(path.join(masterDir, f), path.join(ctx.forgeDir, f));
    console.log(`copied ${path.join(masterDir, f)} -> ${rel(ctx, path.join(ctx.forgeDir, f))}`);
  }
  // The /forge skill travels with the repo too, so any session on this repo (Jase's or a teammate's)
  // has the procedure without the plugin installed. Master: Agent-Teams plugins/forge/skills/forge/SKILL.md,
  // beside master/; the old Claude OS layout (.claude/skills two levels up) is still read if present.
  const skillSrc = [path.resolve(masterDir, '..', 'skills', 'forge', 'SKILL.md'), path.resolve(masterDir, '..', '..', '.claude', 'skills', 'forge', 'SKILL.md')].find((f) => fs.existsSync(f))
    || path.resolve(masterDir, '..', 'skills', 'forge', 'SKILL.md');
  if (fs.existsSync(skillSrc)) {
    const skillDir = path.join(ctx.repoRoot, '.claude', 'skills', 'forge');
    fs.mkdirSync(skillDir, { recursive: true });
    fs.copyFileSync(skillSrc, path.join(skillDir, 'SKILL.md'));
    console.log(`copied ${skillSrc} -> ${rel(ctx, path.join(skillDir, 'SKILL.md'))}`);
  } else {
    console.log(`warn: no SKILL.md beside the master at ${skillSrc}; the repo keeps its existing copy`);
  }
  const v = /<!--\s*forge renderer (\d+\.\d+\.\d+)/.exec(fs.readFileSync(ctx.html, 'utf8'));
  return v ? v[1] : 'unknown';
}

function cmdUpdate(ctx) {
  if (refuseInMaster(ctx, 'update')) return 1;
  const { dir, tried } = findMaster(ctx);
  if (!dir) { console.log(`FAIL master forge not found; looked in: ${tried.join(', ')} (set FORGE_MASTER)`); return 1; }
  const v = copyMaster(dir, ctx);
  console.log(`forge update: renderer ${v} from ${dir}`);
  return 0;
}

function starterJson(id, name, business, repo) {
  const today = hkNow().slice(0, 10);
  return {
    forge: '1.4',
    project: { id, name, business, repo, branch: 'main', started: today, lede: `Where ${name} is, what it is doing now, what it needs from Jase, and where it ends.`, links: { repo: `https://github.com/${repo}` } }, // add links.chat (the build chat) and links.artifact after the first publish
    updated: hkNow(),
    updated_by: 'forge init',
    headline: { now: { code: 'M0', name: 'Foundation', note: 'The forge is set up; the first milestone starts here.' }, tiles: [] },
    asks: [{ id: 'a-001', title: 'Approve the first milestone', kind: 'decision', priority: 'now', why: 'The first milestone needs a go-ahead before work starts.', holds_up: 'M0', opened: today }],
    milestones: [{ code: 'M0', name: 'Foundation', state: 'running', label: 'Starting', exit: 'The app starts and every check passes.' }],
    glossary: [],
    usage: [],
    work: [{ id: 'w-001', title: 'Set up the repo and its gate', state: 'needs-you', band: 'in flight', area: 'process', ask: 'a-001', next: 'Starts once a-001 is answered.', order: 1 }],
    decisions: [{ date: today, title: 'Use the Forge template', by: 'jase', memory_ref: 'REPLACE with the exact words of a MEMORY.md decision entry' }],
  };
}

function cmdInit(args) {
  const [id, name, business, repo] = args;
  if (!id || !name || !business || !repo) { console.log('usage: forge.mjs init <project-id> "<Project name>" <business> <owner/repo>'); return 1; }
  // From the master, init scaffolds the current directory; from a repo copy, it scaffolds that repo.
  const root = SELF_IS_MASTER ? process.cwd() : CTX.repoRoot;
  const ctx = makeCtx(path.join(root, 'forge'), root);
  if (ctx.master) { console.log(`FAIL ${ctx.forgeDir} is the master folder; run init from the new repo's root`); return 1; }
  if (fs.existsSync(ctx.data)) { console.log(`FAIL ${rel(ctx, ctx.data)} already exists; init refuses to overwrite it`); return 1; }
  let masterDir = SELF_IS_MASTER ? SELF_DIR : null;
  if (!masterDir) {
    const { dir, tried } = findMaster(ctx);
    if (!dir) { console.log(`FAIL master forge not found; looked in: ${tried.join(', ')} (set FORGE_MASTER)`); return 1; }
    masterDir = dir;
  }
  const v = path.resolve(masterDir) === path.resolve(ctx.forgeDir) ? 'in place' : copyMaster(masterDir, ctx);
  fs.writeFileSync(ctx.data, JSON.stringify(starterJson(id, name, business, repo), null, 2) + '\n');
  console.log(`wrote ${rel(ctx, ctx.data)}`);
  fs.writeFileSync(ctx.banned, '# Banned patterns for forge.json: one JavaScript regex per line (or /pattern/flags).\n# `forge.mjs check` fails if any matches. Blank lines and lines starting with # are ignored.\n');
  console.log(`wrote ${rel(ctx, ctx.banned)}`);
  console.log(`forge init: renderer ${v}; next, replace the decision's memory_ref and run roadmap`);
  return build(ctx);
}

const HELP = `forge.mjs: forge/forge.json is the one source for the board and the ROADMAP status block.

  node forge/forge.mjs validate          schema and rules (ids, asks, glossary terms, status and usage); one line per failure with a JSON path
  node forge/forge.mjs build             inline forge.json into forge/board.html (refuses if validate fails)
  node forge/forge.mjs roadmap [--check] rewrite (or diff) the generated block in ROADMAP.md
  node forge/forge.mjs check             validate, roadmap drift, memory_refs (MEMORY.md or ARCHIVE.md), banned.txt, renderer version, staleness,
                                         overdue defaults, action asks without a guide, a missing build-chat link, and the 1.4
                                         status fields (a desk without a model, an open milestone without a target, no started,
                                         a usage log empty or over 7 days old) and ask text that is not plain (build spec 5.2);
                                         all of these warn
  node forge/forge.mjs touch [who]       set updated to now (+08:00) and updated_by
  node forge/forge.mjs update            copy renderer, schema, this script and the /forge skill from the master (FORGE_MASTER)
  node forge/forge.mjs init <id> "<Name>" <business> <owner/repo>   scaffold forge/ in a new repo
  node forge/forge.mjs help              this list`;

function main(argv) {
  const [cmd, ...args] = argv;
  switch (cmd) {
    case 'validate': return cmdValidate(CTX);
    case 'build': return refuseInMaster(CTX, 'build') ? 1 : build(CTX);
    case 'roadmap': return cmdRoadmap(CTX, args);
    case 'check': return cmdCheck(CTX);
    case 'touch': return cmdTouch(CTX, args);
    case 'update': return cmdUpdate(CTX);
    case 'init': return cmdInit(args);
    case 'help': case '--help': case '-h': console.log(HELP); return 0;
    default: if (cmd) console.log(`unknown command "${cmd}"`); console.log(HELP); return 1;
  }
}

process.exitCode = main(process.argv.slice(2));
