---
type: regex
pattern: '^\|\s*Spec row\s*\|\s*Test\b[^|\n]*\|\s*Level\b[^|\n]*\|\s*Edge cases\b[^|\n]*\|\s*Rank\b[^|\n]*\|\s*Note\b[^|\n]*\|\s*\n\|[\s:|-]+\|\s*\n\|\s*[`*]*S7\.\d'
flags: m
match: contains
target:
  source: file
  path: audits/M7-conformance.md
weight: 2
---

The audit has the test-gap table with the fixed columns (Spec row, Test, Level, Edge cases, Rank, Note) and at least one row under it.
