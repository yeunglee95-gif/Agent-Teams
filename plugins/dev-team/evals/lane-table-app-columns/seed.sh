#!/usr/bin/env bash
set -euo pipefail
WS="${1:-$PWD}"
cd "$WS"
mkdir -p plans docs src/db src/api src/ui tests
cat > AGENTS.md <<'MD'
# Tally

- Memory file: `MEMORY.md`. Milestone plans: `plans/<milestone>-plan.md`. Ownership map: `docs/ownership.md`.
- Spec: `docs/spec.md`. Tests: `tests/`, one file per area. Stable hooks: `data-testid`.
- Gate: `npm run lint && npm test && npm run e2e`.
- No issue tracker: plans live in `plans/` only.
- Every lane in a plan names the model it runs on (`opus` or `sonnet`) and what done means for it, in the lane table.
- Older plans in `plans/` use `| Lane | Model | Files | Starts from | Done means |`; that shape is retired.
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
mkdir -p src/types
echo "export interface Customer { id: string; customerName: string }" > src/types/contracts.ts
echo "export function getCustomer(id: string) { return { id, customerName: 'x' }; }" > src/db/customers.ts
echo "export function customerJson(c) { return { name: c.customerName }; }" > src/api/customers.ts
echo "export function CustomerPage({ c }) { return <h1 data-testid='customer-name'>{c.customerName}</h1>; }" > src/ui/CustomerPage.tsx
for i in $(seq 1 12); do echo "export const r$i = (c) => c.customerName;" > "src/db/report$i.ts"; done
for i in $(seq 1 13); do echo "export const h$i = (c) => c.customerName;" > "src/api/handler$i.ts"; done
for i in $(seq 1 12); do echo "export const V$i = ({ c }) => <span>{c.customerName}</span>;" > "src/ui/View$i.tsx"; done
echo "seed: ok" >&2
