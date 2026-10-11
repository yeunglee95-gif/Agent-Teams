---
type: regex
pattern: '^\|[^|\n]*\b(?:[Gg]ate|[Ss]tep)\b[^|\n]*\|(?:[^|\n]*\|){4}[^|\n]*\|\s*$'
flags: m
match: not_contains
target:
  source: file
  path: plans/M5-plan.md
weight: 1
---

The contracts step and the final gate are not rows of the lane table.
