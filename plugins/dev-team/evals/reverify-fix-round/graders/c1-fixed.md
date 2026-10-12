---
type: regex
pattern: '^\|\s*C1\s*\|[^\n]*\|\s*\**fixed\**\s+`?[0-9a-f]{7,40}'
flags: mi
target:
  source: file
  path: reviews/M5-findings.md
weight: 1
---

C1 is set to `fixed <sha>`.
