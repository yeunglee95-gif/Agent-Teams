#!/usr/bin/env bash
set -euo pipefail
WS="${1:-$PWD}"
cd "$WS"
mkdir -p plans src docs
cat > AGENTS.md <<'MD'
# Tally
- Memory file: `MEMORY.md`. Plans: `plans/<milestone>-plan.md`. Design notes: `plans/<milestone>-design.md`.
- Glossary: `docs/GLOSSARY.md`. Decision records: `docs/decisions/`.
- Database: Postgres; tests use PGLite as a local stand-in.
MD
cat > MEMORY.md <<'MD'
# Memory
- 2026-10-09 Owner confirmed M6 decisions.
MD
cat > plans/M6-decisions.md <<'MD'
# M6 decisions (confirmed by Jase)
1. When an invoice is overdue, a payment arrives, or an order ships, the shop is notified.
2. Channels: email now through Postmark (an outside service), in-app notices stored in our own database now, SMS through Twilio next quarter.
3. Each shop chooses which events go to which channel.
4. Callers today: the invoice job, the payments webhook handler, the shipping job.
MD
cat > docs/GLOSSARY.md <<'MD'
# Glossary
**Shop**: a customer business using Tally.
**Notice**: a message to a shop about an event, on one channel.
MD
cat > src/invoice_job.py <<'PY'
def run_overdue(invoices, send_email):
    for inv in invoices:
        if inv.overdue:
            send_email(inv.shop_email, f"Invoice {inv.id} is overdue")
PY
echo "seed: ok" >&2
