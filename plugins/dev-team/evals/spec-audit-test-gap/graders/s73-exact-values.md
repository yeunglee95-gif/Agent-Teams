---
type: regex
pattern: '^\|\s*Spec row\s*\|\s*Test\b[^|\n]*\|\s*Level\b[^|\n]*\|\s*Edge cases\b[^|\n]*\|\s*Rank\b[^|\n]*\|\s*Note\b[^|\n]*\|\s*\n\|[\s:|-]+\|\s*\n(?:\|[^\n]*\n)*?\|\s*[`*]*S7\.3\b[^|\n]*\|[^|\n]*\|[^|\n]*\|(?:[^|\n]*?(?<![\d.])\d+(?:\.\d+)?(?![\d.]*\d)){2}'
flags: m
match: contains
target:
  source: file
  path: audits/M7-conformance.md
weight: 2
---

In the table, S7.3's Edge cases cell gives at least two exact numbers (for example the amount paid and one cent more).
