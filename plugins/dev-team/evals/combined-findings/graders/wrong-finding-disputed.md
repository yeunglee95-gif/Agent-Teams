---
type: regex
pattern: '^\|\s*C\d+\s*\|[^\n]*\bSEC2\b[^\n]*\|\s*\**(?:disputed|questioned)\b[^|\n]*\|\s*$'
flags: mi
target:
  source: file
  path: reviews/M9-findings.md
weight: 3
---

SEC2 (SQL injection that is not there) is in the table with Status `disputed` (or questioned), not passed to the fixer as open.
