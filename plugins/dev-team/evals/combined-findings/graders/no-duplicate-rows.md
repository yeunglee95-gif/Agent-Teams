---
type: regex
pattern: '^\|\s*C\d+\s*\|[^|\n]*\|[^|\n]*?(\bR2\b|Ana 1-1|S9\.1|\bSEC1\b|\bSEC2\b|\bD1\b|\bD2\b|Ana 1-2|\bR1\b)[^|\n]*\|[^\n]*\n(?:[^\n]*\n)*?\|\s*C\d+\s*\|[^|\n]*\|[^|\n]*?\1(?![\d.-])'
flags: m
match: not_contains
target:
  source: file
  path: reviews/M9-findings.md
weight: 2
---

No source finding id appears in the Source cell of two rows: a finding two reports share is one row. (Only the Source cell is read; a row's Finding text may mention another row's id.)
