---
type: regex
target: trace
pattern: 'blocked-by:(?=(?:(?!\\n)[^\n]){0,300}?\berror)(?=(?:(?!\\n)[^\n]){0,300}?design)'
flags: i
weight: 2
---

The missing error state goes back to the designer: a `blocked-by:` line, in the lane notes or the report, that names the error state and the designer or the design team.
