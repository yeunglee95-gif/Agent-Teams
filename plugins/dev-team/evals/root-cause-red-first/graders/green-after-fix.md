---
type: regex
target: trace
pattern: '"name":"(?:Edit|Write|MultiEdit)","input":\{[^\n]{0,300}?"file_path":"[^"]*src/bill\.py"[\s\S]*Ran [1-9]\d* tests? in [\d.]+s(?:\\r)?(?:\\n)+OK\b'
weight: 1
---

After the source fix, a unittest run of at least one test passes. Any number of line breaks may sit between the `Ran N tests` line and `OK`, so output piped through `grep` or `tail` (which drops the blank line) still counts; `OK` must be a whole word, and `Ran 0 tests` does not count.
