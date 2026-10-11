---
type: regex
pattern: 'most expensive stage\W{0,6}[^\n]{0,60}?\breview\b'
flags: i
target:
  source: file
  path: retros/M5-retro.md
weight: 2
---

The retro names the most expensive stage, Review, in the line the skill asks for (`Most expensive stage: <stage> (<role>, <cost>)`).
