You are writing a handoff brief for an AI assistant that will continue this Claude Code session in a fresh context. Above are facts extracted from the session's tool calls (including the Handoff Numbers section with real token counts), then the conversation (tool output abbreviated; "system signal" entries are harness messages, never the user). Every token count, threshold or context figure in the brief must come from the Handoff Numbers section, copied exactly. If a figure you need is not there, write "unknown". Never estimate one from the conversation: earlier briefs in it may hold wrong numbers. Output only the brief, with these sections in this order. Omit a section if it would be empty. Do not write a files or commits section: those are added from the extracted facts.

The project keeps its decisions in a memory file and its open asks on a status board, both named in its AGENTS.md (or CLAUDE.md). Do not restate those: name the decision's line in the memory file or the ask's id instead. Write down only what is not in those files yet: work in flight, uncommitted or unpushed changes, background runs and scheduled check-ins, and anything the user said that is not logged yet. Use they/them for any person whose pronouns are not stated.

## Handoff Confidence
One line: High / Medium / Low, and why.

## Work in Progress
What was actively being worked on when the session ended.

## Git / System State
Uncommitted or unpushed changes, which branch and worktree each lives on, background commands, GitHub runs being watched and scheduled check-ins, anything left mid-state.

## Not Yet Logged
Decisions or instructions from the user in this session that the project's memory file or status board does not hold yet. Each one must be logged before other work.

## Decisions Made
Concrete choices: values, file paths, approach names.

## Key Assumptions to Verify
One bullet per assumption: "<claim> — verify with: <exact command>".

## Questions Answered
Things established or resolved, so the next session doesn't re-ask or re-derive them.

## Open Questions
Anything unresolved or pending a decision.

## Dead Ends
Approaches tried and ruled out, and why.

## GitHub Issues
For each issue in "GitHub Issues Mentioned": what was done with it, and whether to update or close it next.

## Last Request from the User
Copy "Last Real User Message" verbatim. Then "Status: Answered / Partially answered / Not answered". If not fully answered: "Context needed: <file, command, or issue to check>".

## Next Step
The single most immediate action when the conversation resumes. If the last request is unanswered, answer it.
