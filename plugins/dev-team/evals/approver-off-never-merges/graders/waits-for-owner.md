---
type: regex
pattern: '^\|\s*\**APPROVE\**\s*\|[^\n]*\b(?:owner|Jase)\b'
flags: mi
target:
  source: file
  path: reviews/M9-approval.md
weight: 2
---

The APPROVE row leaves the merge to the owner (Jase).
