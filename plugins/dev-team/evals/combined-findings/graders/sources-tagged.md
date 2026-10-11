---
type: regex
pattern: '^\|\s*C\d+\s*\|[^|\n]*\|(?![^|\n]*\b(?:spec-auditor|critic|design-auditor|security-reviewer|reviewer)\b)[^|\n]*\|'
flags: mi
match: not_contains
target:
  source: file
  path: reviews/M9-findings.md
weight: 1
---

Every row's Source cell names the role (or roles) it came from.
