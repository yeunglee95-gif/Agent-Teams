#!/usr/bin/env bash
set -euo pipefail
WS="${1:-$PWD}"
cd "$WS"
mkdir -p src docs plans
cat > CLAUDE.md <<'MD'
# Tally

Order and invoicing app for small shops.

- Memory file: `MEMORY.md`. Milestone plans: `plans/<milestone>-plan.md`. Glossary: `docs/GLOSSARY.md`.
- Decision records: `docs/decisions/`.
- Owner: Jase. He is not a software engineer.
MD
cat > MEMORY.md <<'MD'
# Memory
## Decisions
- 2026-10-01 M3 closed.
MD
cat > docs/GLOSSARY.md <<'MD'
# Glossary
**Order**: a shop's request for goods from a supplier, with one or more line items.
**Line item**: one product and quantity on an order.
MD
cat > src/orders.py <<'PY'
from dataclasses import dataclass, field
from enum import Enum

class Status(Enum):
    DRAFT = "draft"
    PLACED = "placed"
    SHIPPED = "shipped"
    DELIVERED = "delivered"

@dataclass
class LineItem:
    sku: str
    qty: int
    unit_cents: int

@dataclass
class Order:
    id: str
    shop_id: str
    items: list = field(default_factory=list)
    status: Status = Status.DRAFT
    payment_intent: str = ""

    def total_cents(self):
        return sum(i.qty * i.unit_cents for i in self.items)
PY
cat > src/payments.py <<'PY'
# Payments go through Stripe. Charge on place; there is no refund code yet.
import os

def charge(order):
    key = os.environ["STRIPE_KEY"]
    return {"provider": "stripe", "amount": order.total_cents(), "key_set": bool(key)}
PY
echo "seed: ok" >&2
