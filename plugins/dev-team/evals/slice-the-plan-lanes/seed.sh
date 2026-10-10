#!/usr/bin/env bash
set -euo pipefail
WS="${1:-$PWD}"
cd "$WS"
mkdir -p plans docs src/db src/api src/ui tests
cat > CLAUDE.md <<'MD'
# Tally

- Memory file: `MEMORY.md`. Milestone plans: `plans/<milestone>-plan.md`. Ownership map: `docs/ownership.md`.
- Spec: `docs/spec.md`. Tests: `tests/`, one file per area. Stable hooks: `data-testid`.
- Gate: `npm run lint && npm test && npm run e2e`.
- No issue tracker: plans live in `plans/` only.
MD
cat > MEMORY.md <<'MD'
# Memory
## Decisions
- 2026-10-09 Owner confirmed M5 decisions (plans/M5-decisions.md).
MD
cat > plans/M5-decisions.md <<'MD'
# M5 decisions (confirmed by Jase, 2026-10-09)
1. Shops can add a private note to a customer (spec S5.1), see the latest note on the customer page (S5.2), and edit or delete their own notes (S5.3).
2. Notes are plain text, up to 2,000 characters.
3. Rename the customer field `customerName` to `displayName` everywhere (S5.4). It is used in about 40 files across src/db, src/api and src/ui; changing it in one edit breaks every caller at once.
MD
cat > docs/spec.md <<'MD'
# Spec
## S5 Customer notes
- S5.1 Add a private note to a customer, up to 2,000 characters.
- S5.2 Customer page shows the latest note.
- S5.3 Edit or delete your own note.
- S5.4 The customer's name field is `displayName`.
MD
cat > docs/ownership.md <<'MD'
# Ownership map
- `src/db/customers.ts`, `src/db/notes.ts` (new): data
- `src/api/customers.ts`, `src/api/notes.ts` (new): API
- `src/ui/CustomerPage.tsx`, `src/ui/NoteEditor.tsx` (new): screens
- `src/types/contracts.ts`: contract file, architect only
- About 40 other files under `src/` read `customerName`.
MD
for f in db/customers api/customers ui/CustomerPage; do echo "export const customerName = 'x';" > "src/$f.ts"; done
echo "seed: ok" >&2
