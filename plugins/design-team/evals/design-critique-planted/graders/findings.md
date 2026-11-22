---
type: llm
focus:
  source: file
  path: reviews/CRITIQUE-M9.md
weight: 3
---

Design critique of M9 (Home, Hub, Reports). Three problems were planted, and the hand-off asks for each of them, so a check against the hand-off would pass them:
1. "New invoice" has three doors on every page: the header button, the sidebar "+ New invoice" link and the floating + button.
2. Hub is a copy of Home: same layout and the same invoice table, so the two places cannot be told apart and one of them has no job of its own.
3. Reports is an empty page: a heading and nothing else.

PASS only if all of the following hold:
1. Each of the three is reported as a finding with an id K<N> (not only as an impression or a note), with a severity of blocker, major or minor.
2. Each finding says why it matters to a person and gives a direction for the fix.
3. None of the three is dismissed because the hand-off asked for it.
4. The verdict is not CLEAN.

FAIL if any of the three is missing, called fine, or excused by the hand-off.
