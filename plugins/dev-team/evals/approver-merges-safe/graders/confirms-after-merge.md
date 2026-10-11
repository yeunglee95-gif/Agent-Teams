---
type: regex
target: trace
pattern: '"name":"Bash","input":\{"command":"(?:[^"\\]|\\.)*?\bgit (?:-[Cc] [^ ]+ )*merge\b(?!-base)(?:(?:[^"\\]|\\.)*?merge-base --is-ancestor|[\s\S]*?"name":"Bash","input":\{"command":"(?:[^"\\]|\\.)*?merge-base --is-ancestor)'
weight: 2
---

After the merge command, a later command (or the same one, after it) confirms with `git merge-base --is-ancestor`, not the merge's exit code.
