---
type: regex
pattern: '^\|\s*Spec row\s*\|\s*Test\b[^|\n]*\|\s*Level\b[^|\n]*\|\s*Edge cases\b[^|\n]*\|\s*Rank\b[^|\n]*\|\s*Note\b[^|\n]*\|\s*\n\|[\s:|-]+\|\s*\n(?:\|[^\n]*\n)*?\|\s*[`*]*S7\.3\b[^|\n]*\|\s*[`*]*none\b[^|\n]*\|[^|\n]*\|[^|\n]*\|\s*[`*]*High\b'
flags: m
match: contains
target:
  source: file
  path: audits/M7-conformance.md
weight: 2
---

In the table, S7.3 (refunds, money) has `none` in Test and High in Rank.
