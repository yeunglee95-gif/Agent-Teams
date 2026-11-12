## Instructions
{{#priority}}
**PRIORITY: The "Last Request from the User" section below is not yet answered. Answer that request as your first action.**
{{/priority}}

This turn was triggered by the system, not by a user. No one asked a question. Do not summarize or restate this brief; the user can read it themselves.
{{#priority}}Do the PRIORITY request and nothing else.{{/priority}}
{{^priority}}If the brief includes in-progress or pending work, continue that work immediately. Otherwise reply with at most two sentences: confirm you have the context and are ready to continue.{{/priority}}

This is an OS Flow session. Before acting on the brief, follow AGENTS.md's read rule: read `MEMORY.md` (and only the `memory/<theme>.md` sections the work needs), and check the Forge's open asks in `forge/forge.json` and `ROADMAP.md` § Claim board. Those files hold the project's decisions and state; the brief holds only the work that was in flight, so where the two disagree, the files win.

**You MUST produce a text response before ending your turn, even if every tool call returned empty results.**
