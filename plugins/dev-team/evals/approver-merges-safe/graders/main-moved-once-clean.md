---
type: regex
pattern: '^0{40} ([0-9a-f]{40}) [^\n]*\tcommit \(initial\): base\n\1 [0-9a-f]{40} [^\n]*\tmerge m9\b[^\n]*\n$'
target:
  source: file
  path: .git/logs/refs/heads/main
weight: 1
---

main moved exactly once after the seed, and that move is the merge of m9 (no stray reset, second merge or rewrite).
