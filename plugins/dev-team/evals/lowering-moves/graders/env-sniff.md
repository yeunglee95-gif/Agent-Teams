---
type: regex
pattern: '^[^\n]*src/search\.py[^\n]*\b(?:CI|environ|env|environment|test)\b'
flags: mi
target:
  source: file
  path: reviews/M4-lowering.md
weight: 2
---

The CI branch in src/search.py is a hit.
