#!/usr/bin/env bash
# Seeds a small app whose M2 and M3 records repeat two finding classes.
set -euo pipefail
WS="${1:-$PWD}"
cd "$WS"
mkdir -p reviews fixes gate critic retros src .claude/skills/copy-rules
cat > AGENTS.md <<'MD'
# Tally

Invoicing app for small shops. English and Spanish.

- Memory file: `MEMORY.md`. Reviews: `reviews/`. Fixer tables: `fixes/`. Gate logs: `gate/`. Critic reports: `critic/`.
- Retro output: `retros/<milestone>-retro.md`. Proposals wait for the owner (Jase).
- Gate: `npm run lint && npm test`. Lint config: `.eslintrc.json`.
- All UI copy comes from `src/i18n/` keys, never literals.
MD
cat > .eslintrc.json <<'MD'
{
  "extends": ["eslint:recommended"],
  "rules": {}
}
MD
cat > .claude/skills/copy-rules/SKILL.md <<'MD'
---
name: copy-rules
description: App copy rules for Tally.
---
Copy is short, plain and in both languages.
MD
cat > MEMORY.md <<'MD'
# Memory

## Decisions
- 2026-09-20 M2 closed. Owner go.
- 2026-10-09 M3 closed. Owner go.
- 2026-10-09 Owner rejected lane C's first invoice screen: "the Save button does nothing when the total is zero and nobody tells me why".
MD
cat > reviews/M2-review.md <<'MD'
# M2 review (reviewer)

| id | class | severity | where | finding |
|---|---|---|---|---|
| R1 | Bug | major | src/ui/CustomerForm.tsx:41 | Hard-coded English string "Save customer" instead of an i18n key; Spanish shows English. |
| R2 | Gap | major | src/ui/Export.tsx:18 | Export refused for an empty list shows no message; the button just does nothing. |
| R3 | Verification miss | minor | tests/export.test.ts:9 | Test asserts the mock was called, not the file content. |
MD
cat > reviews/M3-review.md <<'MD'
# M3 review (reviewer)

| id | class | severity | where | finding |
|---|---|---|---|---|
| R1 | Bug | major | src/ui/InvoiceForm.tsx:77 | Hard-coded English string "Add line" instead of an i18n key. |
| R2 | Bug | major | src/ui/InvoiceForm.tsx:120 | Hard-coded English string "Total due" instead of an i18n key. |
| R3 | Gap | blocker | src/ui/InvoiceForm.tsx:140 | Save refused when total is zero, with no message. Owner hit this too. |
| R4 | Scope drift | minor | src/ui/Theme.tsx:3 | Theme colors changed; not in the plan. |
MD
cat > fixes/M3-fixes.md <<'MD'
# M3 fixer table

| finding | cause | test now green | paths |
|---|---|---|---|
| R1 | literal string in JSX | InvoiceForm shows Spanish label for add line | src/ui/InvoiceForm.tsx |
| R2 | literal string in JSX | InvoiceForm shows Spanish label for total | src/ui/InvoiceForm.tsx |
| R3 | early return without message | zero total save shows refusal message | src/ui/InvoiceForm.tsx |
| R4 | reverted | n/a | src/ui/Theme.tsx |
MD
cat > gate/M3-gate.md <<'MD'
# M3 gate runs
- Run 1: lint 0 errors; unit 41 passed, 2 failed (InvoiceForm Spanish labels). Cause: literal strings.
- Run 2: all green.
MD
cat > critic/M3-critic.md <<'MD'
# M3 critic, persona Shop owner, round 1
Verdict: fix-required (1 blocker)
- Shop owner 1-1 blocker: pressing Save on an empty invoice does nothing, no message. Screenshot m3-r1-1.png.
MD
echo "seed: ok $WS" >&2
