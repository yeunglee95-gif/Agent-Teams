---
type: regex
pattern: '^\|\s*Spec row\s*\|\s*Test\b[^|\n]*\|\s*Level\b[^|\n]*\|\s*Edge cases\b[^|\n]*\|\s*Rank\b[^|\n]*\|\s*Note\b[^|\n]*\|\s*\n\|[\s:|-]+\|\s*\n(?:\|[^\n]*\n)*?\|(?:[^|\n]*\|){4}(?![^|\n]*\b(?:High|Medium|Low)\b)[^|\n]*\|'
flags: m
match: not_contains
target:
  source: file
  path: audits/M7-conformance.md
weight: 1
---

Every row of the table has a Rank of High, Medium or Low.
