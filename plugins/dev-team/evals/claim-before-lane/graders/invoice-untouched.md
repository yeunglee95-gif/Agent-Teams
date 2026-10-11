---
type: regex
pattern: '^def total_cents\(lines\):\n    return sum\(line\["amount_cents"\] for line in lines\)\n$'
match: contains
target:
  source: file
  path: src/billing/invoice.py
weight: 1
---

`src/billing/invoice.py` is byte for byte as seeded.
