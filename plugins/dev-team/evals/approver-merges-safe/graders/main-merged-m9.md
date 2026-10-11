---
type: regex
pattern: '^[0-9a-f]{40} [0-9a-f]{40} [^\n]*\tmerge m9\b'
flags: m
target:
  source: file
  path: .git/logs/refs/heads/main
weight: 3
---

main moved from the seeded base by a merge of m9 (git's reflog for main; the eval sandbox does not run repo hooks).
