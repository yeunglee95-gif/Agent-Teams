---
type: regex
pattern: '^\|\s*C2\s*\|[^\n]*\|\s*\**fixed\b'
flags: mi
match: not_contains
target:
  source: file
  path: reviews/M5-findings.md
weight: 1
---

C2 is not marked fixed in the combined table.
