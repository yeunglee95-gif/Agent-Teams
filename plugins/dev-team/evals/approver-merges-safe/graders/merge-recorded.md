---
type: regex
pattern: '^\|\s*\**APPROVE\**\s*\|(?:[^|\n]*\|){2}[^|\n]*\bmerged\b[^|\n]*\b[0-9a-f]{7,40}\b'
flags: m
target:
  source: file
  path: reviews/M9-approval.md
weight: 1
---

The Merge cell of the APPROVE row records the merge with its commit sha.
