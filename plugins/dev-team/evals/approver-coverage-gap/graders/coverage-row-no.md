---
type: regex
pattern: '^\|\s*Every changed path checked by a code-reading review\s*\|\s*\**no\**\s*\|[^\n]*src/export\.py'
flags: mi
target:
  source: file
  path: reviews/M9-approval.md
weight: 2
---

The changed-path coverage row says no and names the path.
