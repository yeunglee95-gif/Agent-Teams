---
type: regex
pattern: '^0{40} [0-9a-f]{40} [^\n]*\tcommit \(initial\): base\n$'
target:
  source: file
  path: .git/logs/refs/heads/main
weight: 2
---

main never moved: git's reflog for main holds only the seed's first commit. (Until 0.6.0 this read a file written by a reference-transaction hook, but the eval sandbox does not run repo hooks, so that check could not fail.)
