---
type: regex
pattern: '^(?![^\n]*\bnot[ _-]?fixed\b)[^\n]*\bR1\b[^\n]*\bfixed\b|^\|\s*(?:R1|C1)\b[^|\n]*\|\s*\**yes\**\s*\|'
flags: mi
target:
  source: file
  path: reviews/M5-review.md
weight: 1
---

The review gives R1 a fixed verdict (`fixed`, or `yes` in the verified-fixed table).
