---
type: regex
pattern: '^\|\s*Decision\s*\|\s*Reason\s*\|\s*Reviewed head\s*\|\s*Merge\s*\|'
flags: m
target:
  source: file
  path: reviews/M9-approval.md
weight: 1
---

The approval file is where the AGENTS.md says, with the decision table in its fixed shape.
