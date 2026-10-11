---
type: regex
pattern: '^\|\s*\**APPROVE\**\s*\|(?:[^|\n]*\|){2}[^|\n]*\bmerged [0-9a-f]{7}'
flags: m
match: not_contains
target:
  source: file
  path: reviews/M9-approval.md
weight: 1
---

The Merge cell does not record a merge.
