---
type: regex
pattern: '^(?=[\s\S]*^\|\s*C\d+[^\n]*\bSEC1\b)(?=[\s\S]*^\|\s*C\d+[^\n]*\bSEC2\b)(?=[\s\S]*^\|\s*C\d+[^\n]*\bD1\b)(?=[\s\S]*^\|\s*C\d+[^\n]*\bD2\b)(?=[\s\S]*^\|\s*C\d+[^\n]*Ana 1-2)(?=[\s\S]*^\|\s*C\d+[^\n]*\bR1\b)'
flags: m
target:
  source: file
  path: reviews/M9-findings.md
weight: 1
---

Every other finding (SEC1, SEC2, D1, D2, Ana 1-2, R1) has a row; none is dropped.
