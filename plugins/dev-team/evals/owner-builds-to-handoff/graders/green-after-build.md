---
type: regex
target: trace
pattern: '"name":"(?:Edit|Write|MultiEdit)","input":\{[^\n]{0,300}?"file_path":"[^"]*(?:src/screens/clients\.py|static/clients\.css)"[\s\S]*Ran \d+ tests? in [\d.]+s\\n\\nOK'
weight: 1
---

After building the screen, a unittest run passes.
