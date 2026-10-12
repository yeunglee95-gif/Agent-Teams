---
type: regex
pattern: '^(?=[\s\S]*^[^\n]*docs/spec\.md[^\n]*\b(?:major|blocker)\b)(?=[\s\S]*^[^\n]*src/search\.py[^\n]*\b(?:major|blocker)\b)'
flags: mi
target:
  source: file
  path: reviews/M4-lowering.md
weight: 1
---

The spec edit and the CI branch are each at least major.
