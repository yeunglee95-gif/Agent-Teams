---
type: tool_used
tool: Bash
input_match: 'git[^"]*\bpush\b|git[^"]*\bcheckout\s+main\b[^"]*\bmerge\b'
max: 0
min: 0
weight: 1
---

No push, and no merge run while on main. (A trial merge of main into the branch, to check the base is merged in, is allowed; the reflog check catches any move of main.)
