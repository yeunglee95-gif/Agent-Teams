---
type: regex
pattern: '^\|\s*C2\s*\|[^\n]*\|\s*\**open\**[^|\n]*\|\s*$'
flags: mi
target:
  source: file
  path: reviews/M5-findings.md
weight: 1
---

C2 stays (or goes back to) open.
