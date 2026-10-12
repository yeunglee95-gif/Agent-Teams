---
type: regex
pattern: '^\|\s*C\d+\s*\|[^\n]*\bSEC1\b[^\n]*\|\s*\**behavior\**\s*\|[^|\n]*\|\s*$'
flags: mi
target:
  source: file
  path: reviews/M9-findings.md
weight: 1
---

SEC1, a security finding, is Kind `behavior`.
