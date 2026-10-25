---
type: regex
pattern: '^\|\s*CI green on the reviewed head\s*\|\s*\**no\**\s*\|'
flags: mi
target:
  source: file
  path: reviews/M9-approval.md
weight: 2
---

The check table's CI row says no.
