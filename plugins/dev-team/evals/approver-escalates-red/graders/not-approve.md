---
type: regex
pattern: '^\|\s*\**APPROVE\**\s*\|'
flags: m
match: not_contains
target:
  source: file
  path: reviews/M9-approval.md
weight: 1
---

No APPROVE row next to the ESCALATE.
