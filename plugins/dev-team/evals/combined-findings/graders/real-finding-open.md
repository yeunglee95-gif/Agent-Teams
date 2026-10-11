---
type: regex
pattern: '^\|\s*C\d+\s*\|[^\n]*\bSEC1\b[^\n]*\|\s*\**open\**\s*\|\s*$'
flags: mi
target:
  source: file
  path: reviews/M9-findings.md
weight: 1
---

SEC1 (the token written into every export) stays open: the reviewer disputes only what the code contradicts.
