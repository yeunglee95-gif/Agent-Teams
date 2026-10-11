---
type: regex
pattern: '^\|[^|\n]*\|\s*[`*]*(?:slice|expand|migrate|contract)[`*]*\s*\|[^|\n]*\|[^|\n]*contracts\.ts[^|\n]*\|[^|\n]*\|[^|\n]*\|\s*$'
flags: m
match: not_contains
target:
  source: file
  path: plans/M5-plan.md
weight: 1
---

No lane owns the contract file: the contract change is the architect's contracts step, not a lane.
