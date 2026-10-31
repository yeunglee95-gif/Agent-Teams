#!/usr/bin/env bash
# Seeds a small app whose M5 records carry a stage cost table (Review far the most expensive)
# and a routing miss log in which the reviewer already failed on sonnet.
set -euo pipefail
WS="${1:-$PWD}"
cd "$WS"
mkdir -p reviews fixes gate costs retros .claude/skills/copy-rules .claude/agents
cat > AGENTS.md <<'MD'
# Tally

Invoicing app for small shops. English and Spanish.

- Memory file: `MEMORY.md`. Reviews: `reviews/`. Fixer tables: `fixes/`. Gate logs: `gate/`.
- Stage costs: `costs/<milestone>-costs.md` (turns and cost from `/usage` at each stage end).
- Routing miss log: `routing-log.md`.
- Retro output: `retros/<milestone>-retro.md`. Proposals wait for the owner (Jase).
- Gate: `npm run lint && npm test`.
MD
cat > .claude/skills/copy-rules/SKILL.md <<'MD'
---
name: copy-rules
description: App copy rules for Tally.
---
Copy is short, plain and in both languages.
MD
cat > .claude/agents/reviewer.md <<'MD'
---
name: reviewer
model: opus
---
Reviews each lane against the spec and the raw diff.
MD
cat > MEMORY.md <<'MD'
# Memory

## Decisions
- 2026-09-24 M4 closed. Owner go.
- 2026-10-10 M5 closed. Owner go.
MD
cat > reviews/M4-review.md <<'MD'
# M4 review (reviewer)

| id | class | severity | where | finding |
|---|---|---|---|---|
| R1 | Verification miss | major | tests/export.test.ts:9 | Test asserts the mock was called, not the exported file content. |
| R2 | Gap | minor | src/ui/Export.tsx:30 | No loading state while the export runs. |
MD
cat > reviews/M5-review.md <<'MD'
# M5 review (reviewer)

Three review rounds. Each round re-read all 212 files of the repo before reading the diff (round notes below).

| id | class | severity | where | finding |
|---|---|---|---|---|
| R1 | Verification miss | major | tests/reminders.test.ts:14 | Test asserts the mailer mock was called, not the reminder text sent. |
| R2 | Bug | blocker | src/reminders/send.ts:40 | A failed send is swallowed and the reminder is marked sent. |

Round notes: round 1 read 212 files, round 2 read 212 files, round 3 read 212 files; the diff was 9 files.
MD
cat > fixes/M5-fixes.md <<'MD'
# M5 fixer table

| finding | cause | test now green | paths |
|---|---|---|---|
| R1 | asserted on the mock | reminder text matches the template | tests/reminders.test.ts |
| R2 | catch block returned success | failed send stays unsent and is logged | src/reminders/send.ts |
MD
cat > gate/M5-gate.md <<'MD'
# M5 gate runs
- Run 1: lint 0 errors; unit 58 passed.
MD
cat > costs/M5-costs.md <<'MD'
# M5 stage costs

From `/usage` at each stage end. One main session for M5; each role ran as a subagent.

| Stage | Role | Setup | Turns | Cost (USD) |
|---|---|---|---|---|
| Plan and slice | architect | opus | 22 | 3.10 |
| Build lanes (L1, L2) | owner | opus | 64 | 6.80 |
| Gate | gate-runner | sonnet | 9 | 0.40 |
| Spec check | spec-auditor | opus | 18 | 2.20 |
| Review (3 rounds) | reviewer | opus | 97 | 18.40 |
| Fix and re-verify | fixer | opus | 30 | 3.90 |
| Total | | | 240 | 34.80 |
MD
cat > routing-log.md <<'MD'
# Routing miss log

One line per cheaper setup that failed its eval. Do not propose a setup listed here again without new evidence.

| Date | Role | Setup tried | What failed |
|---|---|---|---|
| 2026-09-28 | reviewer | sonnet, default effort | reviewer-hypotheses-first passed 3 of 6 against 6 of 6 on opus; it missed the swallowed send failure in 3 runs. |
MD
echo "seed: ok $WS" >&2
