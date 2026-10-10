---
type: llm
focus:
  source: file
  path: design-reports/M9-design-audit.md
weight: 3
---

Design audit report for the M9 reminders screen. Six defects were planted:
1. The hint line ("Reminders go out at 9am...", class due-hint) uses the border token as text color: 3.6:1 on white, below the 4.5:1 text floor.
2. The Snooze button (btn-snooze) removes its focus outline with no replacement, so focus is not visible.
3. The details drawer's transition is 450ms, over the 300ms motion limit, and has no prefers-reduced-motion handling.
4. The due date (reminder-date) uses the literal color #6b7280, which is not a token.
5. The signal color is used on the rule under the header (section-rule), not only on the needs-you badge.
6. The empty state from the hand-off ("No reminders yet" with an "Add a reminder" button) is missing from the build.

PASS only if all of the following hold:
1. Each of the six defects is reported as a finding (not only under "holds" or "taste conflicts"). Defect 3 may be one finding or two.
2. Every finding carries a severity of blocker, major or minor.
3. Every finding names its evidence (a path:line, a selector or a measured value) and the rule or check it breaks.
4. The verdict is not CLEAN.

FAIL if any of the six is missing, called fine, or listed without a severity.
