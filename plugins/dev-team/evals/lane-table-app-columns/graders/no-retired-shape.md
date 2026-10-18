---
type: regex
pattern: '^\|\s*Lane\s*\|\s*Model\s*\|'
flags: mi
match: not_contains
target:
  source: file
  path: plans/M5-plan.md
weight: 1
---

The retired table shape is not used.
