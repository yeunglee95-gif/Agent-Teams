---
type: regex
pattern: '^[^\n]*\bR2\b[^\n]*\bnot[ _-]?fixed\b|^[^\n]*\bnot[ _-]?fixed\b[^\n]*\bR2\b'
flags: mi
target:
  source: file
  path: reviews/M5-review.md
weight: 2
---

The review gives R2 a not-fixed verdict: the attempted fix still shows 1250 as "$12.5".
