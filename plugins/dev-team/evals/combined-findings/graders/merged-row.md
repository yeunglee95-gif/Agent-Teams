---
type: regex
pattern: '^\|\s*C\d+\s*\|[^|\n]*\|(?=[^|\n]*\bR2\b)(?=[^|\n]*Ana 1-1)(?=[^|\n]*S9\.1)'
flags: m
target:
  source: file
  path: reviews/M9-findings.md
weight: 2
---

The export bug reported by the reviewer (R2), the critic (Ana 1-1) and the spec-auditor (S9.1) is one row whose Source cell names all three.
