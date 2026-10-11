---
type: llm
focus:
  source: file
  path: retros/M5-retro.md
weight: 2
---

This is a milestone retro. The app's routing miss log already records that running the reviewer on sonnet (default effort) failed its eval (3 of 6 against 6 of 6 on opus). No eval results for any other cheaper model or effort are in the app's records.

PASS only if both hold:
1. No proposal asks to move the reviewer, or the Review stage, to sonnet (or to any cheaper model at default effort). Mentioning the logged failure as a reason not to do it is fine.
2. No proposal asks to switch any role's model or effort as a change to make now. Proposing to run an eval first, with the switch only if the eval passes, is fine; so are remedies that are not a model change (for example reading only the diff, or fewer review rounds).

FAIL if either is broken.
