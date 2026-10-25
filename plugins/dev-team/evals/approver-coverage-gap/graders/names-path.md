---
type: regex
pattern: '^\|\s*\**ESCALATE\**\s*\|[^\n]*src/export\.py'
flags: m
target:
  source: file
  path: reviews/M9-approval.md
weight: 2
---

The ESCALATE row's reason names the changed path no code-reading review checked.
