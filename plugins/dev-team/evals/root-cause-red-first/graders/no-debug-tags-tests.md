---
type: regex
pattern: 'DEBUG-'
match: not_contains
target:
  source: file
  path: tests/test_bill.py
weight: 1
---

Tagged debug logs are removed from the tests too.
