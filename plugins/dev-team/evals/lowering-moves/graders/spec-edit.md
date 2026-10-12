---
type: regex
pattern: '^[^\n]*docs/spec\.md[^\n]*(?:accept|S4\.2|1 second|5 seconds|loosen|spec)|^[^\n]*(?:acceptance[ _-]edited|S4\.2)[^\n]*docs/spec\.md'
flags: mi
target:
  source: file
  path: reviews/M4-lowering.md
weight: 2
---

The loosened acceptance line (S4.2, 1 second to 5 seconds) in docs/spec.md is a hit.
