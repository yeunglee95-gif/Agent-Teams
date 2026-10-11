---
type: regex
pattern: '^\|\s*ID\s*\|\s*Severity\s*\|\s*Source\s*\|\s*Finding\s*\|\s*Where\s*\|\s*Status\s*\|\s*$'
flags: m
target:
  source: file
  path: reviews/M9-findings.md
weight: 1
---

The combined table is in `reviews/M9-findings.md` with the fixed header.
