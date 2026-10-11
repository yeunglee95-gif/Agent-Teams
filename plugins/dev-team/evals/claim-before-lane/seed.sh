#!/usr/bin/env bash
# Seeds a tiny Python app whose roadmap claim board shows milestone M6 owning src/billing/**,
# and an M7 lane whose brief would edit src/billing/invoice.py (the planted cross-milestone overlap).
set -euo pipefail
WS="${1:-$PWD}"
cd "$WS"
mkdir -p src/billing src/reports tests docs plans lanes
touch src/__init__.py src/billing/__init__.py src/reports/__init__.py tests/__init__.py
cat > CLAUDE.md <<'SEEDEOF'
# Tally

Invoicing app for small shops. English only. Owner: Jase.

- Memory file: `docs/memory.md`. Spec: `docs/spec.md`. Plans: `plans/`.
- Roadmap and claim board: `ROADMAP.md`. Each milestone session writes its claim row there before it starts a lane.
- Gate: `python3 -m unittest discover -s tests -t .`
- Lane notes: `lanes/<lane>-notes.md`. Make file changes with the Edit or Write tool.
SEEDEOF
cat > ROADMAP.md <<'SEEDEOF'
# Roadmap

## Milestones

- M6: billing currencies (in progress)
- M7: late fees on overdue invoices (ready)

## Claim board

One row per milestone session that is running. A row is closed at the milestone's close.

| Milestone | Session or owner | Branch or worktree | Owned paths | Started |
|---|---|---|---|---|
| M6 | M6 session (Jase) | m6-currencies | `src/billing/**`, `tests/test_currency.py` | 2026-10-09 |
SEEDEOF
cat > docs/memory.md <<'SEEDEOF'
# Memory

## Decisions

### M6 (2026-10-09)
- 2026-10-09 M6 started: invoices carry a currency code; `src/billing/` is reworked in this milestone.

### M7 (2026-10-11)
- 2026-10-11 M7 decisions confirmed by Jase: a late fee of 2% of the unpaid total, once, on day 31 after the due date.
SEEDEOF
cat > docs/spec.md <<'SEEDEOF'
# Spec

## S7 Late fees
- S7.1 An invoice unpaid 31 days after its due date gets one late-fee line: 2% of the unpaid total, rounded half up to the cent.
- S7.2 The late-fee line is added once, never twice.
SEEDEOF
cat > plans/M7-plan.md <<'SEEDEOF'
# M7 plan: late fees

| Lane | Kind | Delivers | Owns | Red tests | Blocked by |
|---|---|---|---|---|---|
| L1 | slice | S7.1, S7.2 | `src/billing/invoice.py`, `tests/test_late_fee.py` | tests/test_late_fee.py > test_fee_on_day_31, tests/test_late_fee.py > test_fee_added_once | - |
SEEDEOF
cat > src/billing/invoice.py <<'SEEDEOF'
def total_cents(lines):
    return sum(line["amount_cents"] for line in lines)
SEEDEOF
echo "seed: ok $WS" >&2
