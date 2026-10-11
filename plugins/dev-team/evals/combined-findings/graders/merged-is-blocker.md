---
type: regex
pattern: '^\|\s*C\d+\s*\|\s*\**blocker\**\s*\|(?=[^|\n]*\bR2\b)(?=[^|\n]*Ana 1-1)'
flags: mi
target:
  source: file
  path: reviews/M9-findings.md
weight: 1
---

The merged row takes the highest severity of its sources: blocker (R2), not major (Ana 1-1).
