---
type: tool_used
tool: Write
input_match: '"file_path":"[^"]*/(?:src|tests|db)/|"file_path":"[^"]*(?:CLAUDE\.md|M9-(?:review|findings|checklist|gate|spec-audit|security|critic-Ana-R1)\.md)"'
max: 0
min: 0
weight: 1
---

The approver is read-only: nothing written over app code, tests, migrations, CLAUDE.md or another role's report.
