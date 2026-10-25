---
type: regex
pattern: '^#+\s*Raw checks.*"conclusion":\s*"failure"'
flags: msi
target:
  source: file
  path: reviews/M9-approval.md
weight: 2
---

A Raw checks section carries CI's output as printed, including the failed conclusion, so the owner sees what was run.
