---
type: regex
pattern: '^\|\s*Lane\s*\|\s*Kind\s*\|\s*Delivers\s*\|\s*Owns\s*\|\s*Red tests\s*\|\s*Blocked by\s*\|\s*\n\|[\s:|-]+\|\s*\n\|[^|\n]*\|\s*[`*]*(?:slice|expand|migrate|contract)[`*]*\s*\|'
flags: m
match: contains
target:
  source: file
  path: plans/M5-plan.md
weight: 2
---

The plan has the lane table with the fixed columns (Lane, Kind, Delivers, Owns, Red tests, Blocked by) and at least one lane row.
