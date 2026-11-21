---
type: regex
pattern: 'Model:[^\n]*(Claude|Opus|Sonnet|Fable)[^\n]*fallback|Model:[^\n]*fallback[^\n]*(Claude|Opus|Sonnet|Fable)'
flags: i
match: contains
target:
  source: file
  path: reviews/CRITIQUE-M9.md
weight: 1
---

Codex is not installed in the sandbox, so the critique ran on Claude, and the Model line says so with the reason (no silent fallback).
