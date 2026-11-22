---
type: regex
pattern: 'First impressions[\s\S]*\bK1\b'
flags: i
match: contains
target:
  source: file
  path: reviews/CRITIQUE-M9.md
weight: 1
---

First impressions are written before the first finding.
