---
type: regex
pattern: '^\|\s*Spec row\s*\|\s*Test\b[^|\n]*\|\s*Level\b[^|\n]*\|\s*Edge cases\b[^|\n]*\|\s*Rank\b[^|\n]*\|\s*Note\b[^|\n]*\|\s*\n\|[\s:|-]+\|\s*\n(?:\|[^\n]*\n)*?\|\s*[`*]*S7\.2\b[^|\n]*\|[^\n]*\b[Tt]autolog'
flags: m
match: contains
target:
  source: file
  path: audits/M7-conformance.md
weight: 2
---

In the table, S7.2's row marks its test tautological: it computes the expected value the way the code does.
