---
type: regex
pattern: '^\|\s*Spec row\s*\|\s*Test\b[^|\n]*\|\s*Level\b[^|\n]*\|\s*Edge cases\b[^|\n]*\|\s*Rank\b[^|\n]*\|\s*Note\b[^|\n]*\|\s*\n\|[\s:|-]+\|\s*\n(?:\|[^\n]*\n)*?\|\s*[`*]*S7\.1\b[^|\n]*\|(?![^|\n]*\bnone\b)[^|\n]*(?:\w\.py\b|\btest_\w+)'
flags: m
match: contains
target:
  source: file
  path: audits/M7-conformance.md
weight: 1
---

In the table, S7.1's Test cell names its test (a file or a test name), not `none`.
