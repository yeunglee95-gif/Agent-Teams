# Forge template — build spec

_Claude OS core · written 2026-10-02 from a four-round interview with Jase. Decisions are logged in the root MEMORY.md § Decisions under the same date. Approved by Jase 2026-10-02 after five rounds._

## 1. Abstract

One Forge for every build project: a fixed data contract (`forge/forge.json` in each project repo) and one shared renderer (`forge/forge.html`, master in Claude OS, copied into each repo with a version stamp), laid out like the OS Flow Forge and coloured with the OS Flow app's real design tokens. The three existing forges (OS Flow, Course Forge, Platform Forge) migrate to it in one pass from this session. OS Flow gets a spec and a roadmap row for a native Forge page that reads the same JSON, built when the team can log in. A `/forge` skill, a gate script per repo and a banner that shows when an open ask's default date has passed keep every board current.

## 2. The problem in Jase's words

Each project has its own forge and they all lay out differently, so he relearns the page every time he switches. There is no single place to see where every build stands. The forges are private claude.ai artifacts, so the team cannot see them. Hand-written HTML falls behind; the Platform Forge already needed a drift gate for one table. He reads the OS Flow Forge most easily and wants that layout, one style for all, and the forge visible inside the OS Flow tool so everyone can track each project's build.

## 3. Who it is for

Day one: Jase reads. Agents (cloud sessions) write. Nobody edits inline. The team reads once the native page exists in OS Flow behind its login (M4 adds their accounts). Language: English now; every text field in the contract may carry a Chinese twin (`title_zh`, `why_zh`, ...) that the renderer ignores today and the OS Flow page shows through its 中/EN toggle later.

**Month-one success sentence:** "I open any project's forge and know what needs me in ten seconds."

## 4. Decisions

| Date | Topic | Decision | Rejected and why |
|---|---|---|---|
| 2026-10-02 | Shape | One JSON contract per project plus one shared renderer in the OS Flow Forge's layout | Restyle-only: solves "reads differently" and nothing else |
| 2026-10-02 | Audience | Jase reads, team reads later, no inline editing | Platform Forge's inline editor: needs a shared database per project |
| 2026-10-02 | First project | OS Flow's own forge proves the contract | Course Forge or Platform first; all three at once as the proof |
| 2026-10-02 | In OS Flow | A native Forge page per project reading the JSON from a small store (Cloudflare KV behind one Pages function); spec and roadmap row now, built right after M3b closes and before M3c (Jase, 2026-10-02, pulled forward from M4) | Static hub page (a second surface); link-only (team still cannot see private artifacts); building the page now (team cannot log in before M4) |
| 2026-10-02 | Sections | OS Flow spine plus Course Forge's filterable state table plus Platform Forge's firing-default decisions | Goals with kill condition (project-specific); SVG pipeline graph (OS Flow draws pipelines later) |
| 2026-10-02 | Source | `forge/forge.json` in each repo, committed by its cloud session; OS Flow's store holds a pushed copy | Store as source (no diff, no trail); browser fetching private GitHub (token in client code) |
| 2026-10-02 | Status source | `forge.json` is the source; the status block of `ROADMAP.md` is generated from it between markers, prose around it survives | ROADMAP as source; both by hand with a gate |
| 2026-10-02 | Vocabulary | Six states: done, running, needs-you, queued, later, parked; a free label beside the state | Per-project words (cosmetic unification); four states (too little nuance) |
| 2026-10-02 | Gate PRD | Folds into the Forge page in OS Flow; the Applier is a later Forge feature; the PRD carries a superseded note | Separate Gate tool (two surfaces, one item in both); deciding later |
| 2026-10-02 | Propagation | Renderer master in Claude OS, copied into each repo with a version stamp, refreshed by one command | Renderer only in OS Flow (nothing to read until it ships); hosted renderer reading private JSON |
| 2026-11-12 | Home | The master moves to Agent-Teams as the `forge` plugin, so any project installs it like the other shared tools | Keeping it in Claude OS, which a project session cannot install |
| 2026-11-22 | Records in the page's database (contract 1.5, renderer 1.6.0) | Asks, decisions and work in the published page's own database, written by `sync` as changed chunks only; forge.json stays the source; `rows` for a cheap walk (Jase, 2026-11-20, OS Flow a-237 "b") | Republishing the whole page per move (about 440k tokens on OS Flow); a directory of small pages (a-237 "a") |
| 2026-11-20 | Ask writing and layout (renderer 1.5.0) | Caveman voice with word limits that `check` warns on; steps unfolded under What to do on every ask, ending in a linked reply step; reasoning folds (Jase, 2026-11-20) | Long `why` paragraphs and a guide folded behind a button, which Jase found hard to follow |
| 2026-11-12 | When the board moves | Only for asks, decisions and milestones; live progress goes to the crew-progress status file | Republishing after every completed task |
| 2026-10-02 | Discipline | `/forge` skill, a gate script per repo, a stale banner (24-hour rule replaced 2026-11-12, below) | A CLAUDE.md sentence alone |
| 2026-11-12 | Stale banner (renderer 1.4.2) | The banner shows only while an open ask's default date has passed, naming the asks; `check` drops its 24-hour warning (Jase, 2026-11-12) | The 24-hour banner, which a quiet board now shows every day because the board moves only for asks, decisions and milestones |
| 2026-10-02 | Never | No client, factory, finance or secret data; no shared URL without Jase; no decision only on the forge; no agent closing its own ask | — |
| 2026-10-02 | Migration | This session migrates all three forges in one pass | Each project session migrating its own (recommended for repo ownership; Jase wants one pass and one reviewer) |
| 2026-10-02 | Defaults | Firing defaults on every project, every ask that may carry one, fixed exceptions | Per-project opt-in; per-ask only |
| 2026-10-02 | OS Flow meaning | A Forge page per project inside the app | The forge drawn on the canvas as a graph, now or later |
| 2026-10-02 | Team room | In every forge, filled where the project has roles | OS Flow only; dropping it |
| 2026-10-02 | Roll-up | None until the OS Flow page; three artifacts until then | A Claude OS roll-up page; a Notion page |
| 2026-10-05 | Words we use | Every forge keeps a definitions table (`glossary`, contract 1.3): a term goes in the turn it is defined, and the project's other files link to it rather than restating it (Jase, 2026-10-05) | Terms left in specs and chat, each file restating them |

## 5. Product definition

### 5.1 The contract: `forge/forge.json`

Top level, in reading order:

| Key | Holds | Notes |
|---|---|---|
| `forge` | contract version, `"1.4"` | the renderer refuses a major it does not know |
| `project` | `id`, `name`, `business`, `repo`, `branch`, `lede`, `links{artifact, live, repo}`, and (1.4) `started`, `finish{target, previous[]}`, `last_shipped{what, on}` | `lede` is the one-paragraph "what this page is" under the title; the 1.4 fields feed the status panel, see 5.3b |
| `updated`, `updated_by` | ISO timestamp with offset; the session or role that wrote it | the stamp shows its age; an unreadable value shows the stale banner |
| `headline` | `now{code, name, note, rounds[]}` and up to three `tiles[{label, value, unit, note}]` | `now` heads the status panel, the tiles close it (1.4 retired the full-width strip) |
| `asks[]` | everything needing Jase, see 5.2 | the one list |
| `milestones[]` | `code, name, state, label, exit, closed_on, note`, and (1.4) `target, ships, progress` | rail and detail rows; percent complete and Next up, see 5.3b |
| `work[]` | the state table, see 5.3 | Running now and Queued derive from it |
| `team[]` | `role, person, autonomy, brief, now, state, label, output, shelf[]` | optional; the Team room |
| `goal` | `vision`, `checks[{title, state, label, note}]` | optional; "The end goal" |
| `decisions[]` | `date, title, detail, by, memory_ref` | `memory_ref` is an exact substring that must appear in MEMORY.md |
| `glossary[]` | `term, means, example, not` | optional (1.3); Words we use, see 5.3a |
| `usage[]`, `usage_note` | `on, model, tokens, runs, role` per day | optional (1.4); agent tokens logged, see 5.3b |
| `progress[]` | `label, value, max` | optional; the small bar chart |
| `extensions` | per-project free object | the renderer ignores it; the OS Flow page may use it later |

Every text field accepts a `_zh` twin. IDs are stable strings (`a-012`, `w-045`, `M3a`) and never reused.

### 5.2 Asks (needs-you)

`id, title, kind (decision | action | look), priority (now | soon | later), why, holds_up, options[{label, recommended, consequence}], recommendation, reasoning[], default{action, fires_on}, opened, closed{on, by (jase | default), outcome}`.

Writing (Jase, 2026-11-20): every ask reads as a checklist in the caveman voice (toolkit plugin). `title` is the one thing to do in 10 words or fewer; `why` is at most two sentences; every English sentence in title, why, holds_up, recommendation, options, reasoning and guide steps is 20 words or fewer, with no em dash. Detail beyond that goes in `ref`. `check` warns on each breach. Renderer 1.5.0 shows every open ask's steps unfolded under What to do: a decision's options as step 1, a look's `names` as step 1, the guide's steps next, then a reply step linking `project.links.chat` unless the guide already ends there.

Rules: an ask with a `default` fires on `fires_on` unless Jase vetoes, except kinds the default may never carry (a public URL, an outbound message, money, a client, partner or factory commitment). `closed.by` is only `jase` or `default`; the gate fails on anything else. Open asks group by priority under headings and run in id order inside each group, with a Jump to row of every open id (renderer 1.5.1, Jase 2026-11-20); an overdue default keeps its tag and the banner rather than moving to the top. Closed asks stay in the file for 30 days, then move to `forge/archive/asks-YYYY.json`.

### 5.3 Work rows

`id, title, sub, state, label, area, band, urgent, next, ask, checks[{name, state}], order, closed_on, ref`.

`state` is one of the six. `band` groups rows (live defects, shipped, in flight, pipeline, content, engine, deferred, or a project's own). `checks` carries sub-statuses such as Course Forge's accuracy / teaching / downstream passes. `ask` links a `needs-you` row to its ask id. The renderer derives **Running now** (state running, by order) and **Queued** (state queued, top six by order, or all with `spotlight: true`) from these rows, so there is one list.

### 5.3a Words we use (`glossary`, contract 1.3)

This section is the one home for the glossary rules; the README, the `/forge` skill and the schema point here.

- **Fields.** `term` and `means` required; `example` and `not` (what it is not to be confused with) optional; all strings, each with an optional `_zh` twin. No other keys.
- **One entry per term.** Terms are unique ignoring case, full-width forms and inner spacing (`Team  room` and `team room` are the same term).
- **No empty field.** An optional field is either filled or left out.
- **No em dash** in English text; a `_zh` twin may use the Chinese dash ——.
- **Version.** A file with a glossary says `"forge": "1.3"` or later; bump it and run `update` before adding the first term.
- `validate` fails on any of the above; `check` warns when a board has no glossary, and `init` starts every new board with `glossary: []`.
- **Every Forge keeps one** (Jase, 2026-10-05). A term goes in the turn it is defined, and the project's specs, AGENTS.md and other files link to the Forge for it rather than restating it. Entries keep the author's order.

Contract versions: 1.1 added `who`, ask `guide` and `links.chat`; there is no contract 1.2 (the 1.2.x releases changed the renderer only); 1.3 adds `glossary`; 1.4 adds the status and usage fields (5.3b); 1.5 adds `project.store` (5.3c).

### 5.3b Where the build is (status and usage fields, contract 1.4)

This section is the one home for the status panel's rules (Jase, 2026-10-05); the README, the `/forge` skill and the schema point here. Every field is optional, and the panel hides any row whose data is missing.

- **Fields.** `project.started` (date the build began, set once). `project.finish`: `target` (date) and `previous[{target, changed_on, why}]`, oldest first. `project.last_shipped{what, on}`. On a milestone: `target` (date), `ships` (one short line saying what becomes available, e.g. "Forge page in OS Flow"), `progress` (0 to 100, read only on a running milestone). `usage[{on, model, tokens, runs?, role?}]`: one daily aggregate per day, model and role. `usage_note`: one optional line shown under the token figures.
- **Validation** (`validate` fails): every date is a real `YYYY-MM-DD`; `finish.previous` keeps `changed_on` oldest first and each entry says `why`; `progress` is 0 to 100; `tokens` and `runs` are non-negative integers; the combination of `on`, `model` and `role` is unique (ignoring case and outer spaces), so a second run that day adds to the existing entry; no empty `ships`, `why` or `model`.
- **Version.** A file using any 1.4 field says `"forge": "1.4"` or later; bump it and run `update` before the first one. `init` seeds `forge: "1.4"`, `started: today`, `glossary: []` and `usage: []`.
- **Warnings** (`check` warns, never fails): a Team desk without `who.model` (Jase's own desk excepted; the card shows "Model not set"); an open milestone without a `target`; no `project.started`; `usage` empty, or its newest entry more than 7 days old.
- **Percent complete** = (done milestones + the running milestones' `progress` / 100) / all milestones, as a whole percent, with "N of M milestones done" under it.
- **Days building** counts whole days from `project.started` to today.
- **Next up** is the earliest open milestone with a `target`, shown as "Sun 12 Oct: <ships, or the name>" with a hint: "today", "tomorrow", "in N days", or "N days late" in Coral Ink.
- **Target finish** is `finish.target`; with `previous` it adds "moved once / twice / N times, first set for <the oldest target>" and a fold listing each move with its date and why. When a target slips, move the old one into `previous` with why. A milestone that slips just gets its new `target`, with the reason in its `label` or `note`.
- **Last shipped** is `project.last_shipped`; without it, the most recently closed milestone (its `ships` line, else its name).
- **Waiting on you** counts the open asks and gives the oldest one's age in days.
- **Tokens** are labelled "Agent tokens logged (partial: the build chat's own use is not counted)": the last 7 days (today and the six before) and all time, in human units (4.2M), and a per-model split bar for the last 7 days in Capsule's block-kind hues (Fable violet, Opus blue, Sonnet teal, Haiku slate; never coral).
- **Token tips**, at most two, in this order, none when no rule fires: (1) Fable over 40% of the last 7 days: "Fable used N% of this week's tokens. Route in-between checks to Opus (gk-gauntlet); keep Fable for milestone reviews." (2) Tokens per run over 250k, over the last 7 days' entries that carry `runs`: "Agent runs average X tokens. Brief each one with the exact files to read so it reads less." (3) The last 7 days more than 1.5 times the 7 before: "Token use is up N% on last week." The renderer computes them; no tip is AI-written, so a republish spends nothing.
- **Logging usage.** After each agent run, add its `subagent_tokens` from the task notification to that day's entry for the model (and role), plus 1 to `runs`, in the turn's one update; never a separate publish for usage.

### 5.3c The database store (`project.store`, contract 1.5)

This section is the one home for the store's rules (Jase, 2026-11-20, OS Flow a-237 "b"). A republish read the whole live page first, about 440k tokens on OS Flow's 750 KB board, even when one ask changed.

- **Where the records live.** With `project.store: "db"` the published page keeps the board in its own database, collection `board`: a `meta` document with every field except `asks`, `decisions` and `work`, and those three in chunks of 25 records, `<section>-<n>`. Editing one record rewrites one chunk.
- **The repo stays the source.** `forge/forge.json` holds the full board under git and `check` validates it as before. `sync` compares it with `forge/sync-state.json` (each document's hash and last version) and writes only the changed documents, plus a delete for a chunk that no longer exists, as `ArtifactData` batch files (50 writes and 900 KB at most each). `sync --record` saves the versions the writes returned; a write left unrecorded is repeated by the next sync.
- **The page.** `build` makes `board.html` a shell (the renderer, the project name and links). The renderer reads the collection, joins it as `forge.mjs` does, and draws again on every change. A board without `store` embeds its data as before.
- **Access.** The page declares `db` with read `view` and write `admin`: everyone with the link reads, only the owner and editors write.
- **Reading cheaply.** `rows` prints one line per live row, so the skill's walk of every row reads no closed history.
- `validate` fails a `store: "db"` board that says a contract below 1.5 or has no `links.artifact`; `check` warns while documents are not synced. Tests: `master/forge.test.mjs`.

### 5.4 The renderer: `forge/forge.html`

One file, no build step, no dependencies. It reads its data from an inline `<script type="application/json" id="forge-data">` block when present, otherwise from `./forge.json` next to it. Sections in order: capsule bar, title, stamp and stale banner; Needs you (about 1.25fr) beside **Where the build is** (about 1fr; 5.3b: `headline.now`, the wafer map with one die per work row linking needs-you dies to their ask, percent complete, days building, Next up, Target finish, Last shipped, Waiting on you, agent tokens with up to two tips, and the `headline.tiles` last), stacked with Needs you first below 760px; Team room (when `team` or running work is present: a full-width grid of fixed-height desk cards, `repeat(auto-fill, minmax(240px, 1fr))`, each with its state mark, role, person unless "AI", model chip or "Model not set", `now` in two lines, a running count with the first running title, and a "Show work and desk" fold; desks waiting on Jase first on the coral wash, then active desks, then idle ones dimmed, then an Unassigned card for running work no desk's role matches; Jase's own desk left out); Milestones (rail and detail); Running now and Queued; State table with status, area and urgent filters and a sort; The end goal (when `goal` is present); Progress (when present); Recent decisions; Words we use (when `glossary` has at least one entry: a plain table with the term as each row's header of Term, Means, Example, Not to be confused with, each row stacked into one labelled block below 860px); footer pointers. A version stamp `<!-- forge renderer 1.4.0 -->` in the head, light default with dark through `prefers-color-scheme` and `data-theme`, and the stale banner while an open ask's `default.fires_on` is before today (1.4.2). The wafer's one-time fill-in (260ms per die, 6ms stagger, skipped under reduced motion) is the page's only motion moment.

### 5.5 The tool: `forge/forge.mjs`

Node, no dependencies. `validate` (schema and rules), `build` (inlines `forge.json` into `forge/board.html`, the file that gets published), `roadmap` (rewrites the generated block in `ROADMAP.md`), `check` (validate, roadmap drift, every decision's `memory_ref` found in MEMORY.md, every closed ask closed by jase or default, banned patterns from `forge/banned.txt` absent), `touch` (sets `updated`). `check` is wired into each repo's gate.

### 5.6 Style

The OS Flow app's tokens from `app/src/styles/tokens.css`, light and dark: canvas `#eef1f6` / `#12141a`, panel `#ffffff` / `#191c23`, hairline `#dfe4ec` / `#262b35`, text `#101319` / `#f4f6fa`, accent `#ff6d5a` with text-safe `#c0341f` / `#ff8f80`, success `#15803d` / `#4ade80`, warning `#92610a` / `#fcd34d`, info `#0369a1` / `#7dd3fc`, failed `#b91c1c` / `#fca5a5`, idle `#8b94a5`; panel radius 12, chips 3, rows 5; Inter and JetBrains Mono with the CJK fallbacks. Reading sizes stay the forge's (15px body, 1080px column), because the app's 13px is a tool size, not a reading size. Status to colour: done=success, running=accent, needs-you=warning, queued=info, later=idle, parked=idle dashed.

### 5.7 The OS Flow page (spec only now)

`spec/10 Forge Page.md` in the os-flow repo: route `/b/:business/p/:project/forge`, a "Forge" row per project in the sidebar, a `ForgeView` rendering the same contract with `tokens.css` and `useT`, data from a KV store behind `app/functions/api/forge/[project].ts`, written by each project's session with one `curl PUT` carrying a token Jase creates, a Cloudflare Access bypass on that path for writes only. The Gate PRD's Applier (act on an approved ask) is listed as a later feature. Roadmap row: "Forge page", right after M3b closes, before M3c.

## 6. Definition of done

- The renderer renders the OS Flow forge from JSON with no content lost against today's HTML, checked row by row.
- Course Forge and Platform Forge migrate with every open row, every open ask and every decision carried; a reviewer in a fresh context diffs each old page against its new one and returns PUBLISH or HOLD.
- `forge.mjs check` passes in all three repos and runs in their gates.
- Each repo's AGENTS.md names the new file, the command and the rule; the old boards stay as `forge/legacy/` for one month.
- `/forge` scaffolds a fourth project's forge from one command.
- OS Flow has `spec/10` and its roadmap row.

## 7. Infrastructure

| Part | Choice |
|---|---|
| Renderer | Static HTML, no framework |
| Tool | Node script, no packages |
| Storage | Git, one JSON per repo; artifact publish for Jase today |
| OS Flow page later | React view in the app, Cloudflare KV behind a Pages function, a write token Jase creates |
| Local run | Open `forge/board.html` from disk, or serve the folder |

## 8. Folder structure

Agent-Teams (master from 2026-11-12): `plugins/forge/master/` holds this spec, `forge.html`, `forge.schema.json`, `forge.mjs`, `forge.example.json` and the lifecycle map; the skill is `plugins/forge/skills/forge/SKILL.md` and the folder's guide is `plugins/forge/README.md`. Until then the master was Claude OS `00_Resources/forge/`, with the skill at `.claude/skills/forge/SKILL.md`.

Each project repo: `forge/forge.json`, `forge/forge.html` (copy, do not edit), `forge/forge.schema.json` (copy), `forge/forge.mjs` (copy), `forge/banned.txt`, `forge/board.html` (built), `forge/legacy/` (the old board for a month), `forge/archive/`.

## 9. Milestones

| # | Name | Delivers | Exit evidence |
|---|---|---|---|
| F0 | Contract | `forge.schema.json`, example JSON, this spec approved | `forge.mjs validate` passes on the example |
| F1 | Renderer | `forge.html` with every section, light and dark, phone width, stale banner on an overdue ask | Screenshots at 1440 and 390 in both themes; a Fable review returns clean |
| F2 | Tool and skill | `forge.mjs` with all five commands, `/forge` skill, README | A scratch repo scaffolds, builds, checks and fails on an injected drift |
| F3 | OS Flow migrated | `forge/forge.json` for OS Flow from today's page, board published to the same artifact URL, ROADMAP block generated, AGENTS.md updated, `spec/10` and roadmap row | Row-by-row diff against the old page: nothing lost; reviewer PUBLISH |
| F4 | Course Forge migrated | 95 rows and 4 desk items carried, SVG pipeline retired to a link, AGENTS.md updated | Same diff and reviewer; check passes in the gate |
| F5 | Platform Forge migrated | 111 live items read from the artifact store, 22 asks with firing defaults, 13 stages as bands, `build_summary.py` retired | Same diff and reviewer; `gates.mjs` calls `forge.mjs check` |
| F6 | Close | Gate PRD superseded note, playbook updated, MEMORY entries, Jase runs SYNC-REPOS.bat | Three boards open from one layout |

## 10. Quality bar and worker rules

Fable reviews the renderer and each migration diff; Opus does the migrations and the tool; Sonnet only for lookups. One agent per repo, repos are disjoint. Every count in a report is re-checked against the file. No migration marks a row done that the old board did not.

## 11. Red actions

Pushing to `main` in any project repo; republishing an artifact to a new URL; sharing any artifact; creating the KV namespace, the write token or the Access bypass in OS Flow; deleting a legacy board before its month.

## 12. Open items carried into the build

_Status 2026-10-02 end of build: F0 to F6 done; the three project branches `claude/forge-template` wait on their owning sessions to merge; the OS Flow page (5.7) is a roadmap row._

- Jase: install the Claude GitHub App on `yeunglee95-gif/Geniotek_Team_Training_App` so this session can push there (the add said pushes are refused today).
- Jase: confirm the Platform Forge's artifact store is readable from this session (it reads the live items before migrating).
- Me: the Course Forge artifact URL, read from its AGENTS.md during F4.
- Deferred: the OS Flow page build; the Applier; Chinese rendering in the standalone page.
