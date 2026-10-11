---
type: regex
pattern: 'return \[share\] \* people\n'
match: not_contains
target:
  source: file
  path: src/bill.py
weight: 1
---

The cause, one rounded share repeated for everyone, is gone.
