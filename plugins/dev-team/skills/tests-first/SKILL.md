---
name: tests-first
description: Use before writing any feature, fix or behavior change in app code. Write one failing test, watch it fail for the right reason, write the least code that turns it green, then clean up with the suite still green.
---

# Tests first

If you did not watch the test fail, you do not know it tests the right thing.

## The cycle, one behavior at a time

1. **Red.** Write one test for one behavior, with a name that says what should happen. It asserts on the stable hooks the app's `CLAUDE.md` names (test ids, state attributes, visible text), never pixels or fixed sleeps. Use real code; mock only what you cannot run.
2. **Watch it fail.** Run it. It must fail, not error, and fail because the behavior is missing, not because of a typo. If it passes at once, it tests something that already exists: fix the test.
3. **Green.** Write the least code that makes it pass. Nothing the test does not ask for.
4. **Watch it pass,** then run the unit suite. Every other test still passes and the output carries no new errors or warnings. If the test fails, fix the code, never the test.
5. **Clean up** names and duplication with the suite green after each change.
6. Next behavior.

## Where the architect's red tests fit

When the architect's lane plan already names the red tests a lane starts from, those are the agreed starting points. Take them one at a time through steps 2 to 5; do not write all the code for all of them at once. A test you think is wrong is raised with the architect, not edited.

## Red flags

- Code written before its test. Delete it and start from the test; do not keep it "for reference".
- A test that passed the first time it ran.
- A test that checks a mock instead of the behavior.
- "I tested it by hand", "I'll add tests after", "this one is too simple to test".

A throwaway spike or generated code may skip this only when the brief says so.

## Source

Adapted from `test-driven-development` in obra/superpowers (MIT, Copyright (c) 2025 Jesse Vincent), commit 8ca22dba9a94f28898bbce59f2537ff4d87c747d. Changed: shortened, rewritten in this team's voice, and the section on the architect's red tests added so the skill matches the lane plan. License text: `../../licenses/obra-superpowers-MIT.txt`.
