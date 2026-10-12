---
type: regex
pattern: '^[^\n]*\bR3\b[^\n]*(?:tax|S5\.3)|^[^\n]*(?:tax|S5\.3)[^\n]*\bR3\b'
flags: mi
target:
  source: file
  path: reviews/M5-review.md
weight: 2
---

The change to src/tax.py, outside both findings' paths, is reviewed and reported as a new finding R3.
