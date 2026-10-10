---
type: regex
pattern: 'DEBUG-'
match: not_contains
target:
  source: file
  path: src/bill.py
weight: 1
---

Tagged debug logs are removed before the fix is reported.
