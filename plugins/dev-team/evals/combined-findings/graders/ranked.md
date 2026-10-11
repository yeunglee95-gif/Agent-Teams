---
type: regex
pattern: '^\|\s*C\d+\s*\|\s*\**(?:major|minor)\**\s*\|[\s\S]*^\|\s*C\d+\s*\|\s*\**blocker\b|^\|\s*C\d+\s*\|\s*\**minor\**\s*\|[\s\S]*^\|\s*C\d+\s*\|\s*\**major\b'
flags: mi
match: not_contains
target:
  source: file
  path: reviews/M9-findings.md
weight: 2
---

Rows are ranked: no major or minor row before a blocker row, and no minor row before a major row.
