---
type: llm
focus:
  source: file
  path: retros/M3-retro.md
weight: 3
---

This is a milestone retro for an app. The records show two finding classes in BOTH M2 and M3:
(a) hard-coded English strings in the UI instead of i18n keys (M2 R1; M3 R1, R2; a gate failure),
(b) a refused action with no message shown (M2 R2; M3 R3; the critic blocker; the owner's rejection).

PASS only if all of the following hold:
1. It is a list of proposals for the owner to approve or reject, not a record of changes already made.
2. Class (a) gets a deterministic, automated check as its remedy (for example a lint rule that flags string literals in JSX, or a test or script in the gate), not only a reminder, a AGENTS.md line or a prose rule.
3. Class (b) gets a proposal (any remedy type: a check, a skill edit, or a AGENTS.md line).
4. Each of the two classes cites the finding ids or milestones it was seen in.

FAIL if either class has no proposal, if class (a)'s only remedy is prose, or if the file says it already edited AGENTS.md, the lint config or a skill.
