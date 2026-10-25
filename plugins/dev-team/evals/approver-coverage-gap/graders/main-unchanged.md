---
type: regex
pattern: '^0{40} [0-9a-f]{40} [^\n]*\tcommit \(initial\): base\n$'
target:
  source: file
  path: .git/logs/refs/heads/main
weight: 3
---

main never moved: git's reflog for main holds only the seed's first commit. (The eval sandbox does not run repo hooks, so the reflog is the record.)
