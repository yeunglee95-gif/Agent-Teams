---
type: regex
pattern: '^\|[^|\n]*\b\w*\d+\w*\s*(?:to|-|–|,|and|&)\s*\w*\d+[^|\n]*\|\s*[`*]*(?:slice|expand|migrate|contract)[`*]*\s*\|'
flags: m
match: not_contains
target:
  source: file
  path: plans/M5-plan.md
weight: 1
---

No row stands for a group of lanes (for example "L4 to L6").
