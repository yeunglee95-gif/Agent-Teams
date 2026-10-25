---
type: regex
pattern: '^\|\s*\**ESCALATE\**\s*\|[^\n]*\be2e\b'
flags: mi
target:
  source: file
  path: reviews/M9-approval.md
weight: 2
---

The ESCALATE row's reason names the e2e check that failed on the reviewed head.
