---
name: tests-first
description: Use before writing any feature, fix or behavior change in app code.
---

# Tests first

If you did not watch the test fail, you do not know it tests the right thing.

## The cycle, one behavior at a time

1. **Red.** Write one test for one behavior, with a name that says what should happen. It asserts on the stable hooks the app's `CLAUDE.md` names (test ids, state attributes, visible text), never pixels or fixed sleeps. Use real code; mock only what you cannot run, and a mock carries the full shape of the real data. Before the test body, name the change in the app code that would make it fail; if you cannot name one, the test checks nothing.
2. **Watch it fail.** Run it. It must fail, not error, and fail because the behavior is missing, not because of a typo. If it passes at once, it tests something that already exists: fix the test.
3. **Green.** Write the least code that makes it pass. Nothing the test does not ask for.
4. **Watch it pass,** then run the whole unit suite, not just your file. Every other test still passes and the output carries no new errors or warnings. If the test fails, fix the code, never the test. Any red you saw in the suite, even one you did not cause, is named in your report; leaving it out is a false report.
5. **Clean up** names and duplication with the suite green after each change.
6. Next behavior.

## Where the architect's red tests fit

When the architect's lane plan already names the red tests a lane starts from, those are the agreed starting points. Take them one at a time through steps 2 to 5; do not write all the code for all of them at once. A test you think is wrong is raised with the architect, not edited.

## Red flags

- Code written before its test. Delete it and start from the test; do not keep it "for reference".
- A test that passed the first time it ran.
- A test that checks a mock instead of the behavior.
- "I tested it by hand", "I'll add tests after", "this one is too simple to test".

## Two named anti-patterns

- **Tautological test.** The assertion works out the expected value the same way the code does (`expect(add(a, b)).toBe(a + b)`, a snapshot built the same way, a constant compared with itself). It passes by construction and can never disagree with the code. Expected values come from somewhere independent: a known good literal, a worked example, the spec.
- **Horizontal slicing.** Writing all the tests first and then all the code. Tests written in bulk check imagined behavior and the shape of things, not what a person sees, and they fix the test structure before you understand the code. Work in vertical slices: one test, the code for it, then the next test, each one shaped by what the last cycle taught you. This holds even when the architect's plan names several red tests up front.

A throwaway spike or generated code may skip this only when the brief says so.

## Source

Adapted from `test-driven-development` in obra/superpowers (MIT, Copyright (c) 2025 Jesse Vincent), commit 8ca22dba9a94f28898bbce59f2537ff4d87c747d, with the two named anti-patterns from `skills/engineering/tdd/SKILL.md` in mattpocock/skills (MIT, Copyright (c) 2026 Matt Pocock), commit 49dd158d1076134a641b33efb035946536778336. Changed: shortened, rewritten in this team's voice, and the section on the architect's red tests added so the skill matches the lane plan; from tdd, only the tautological and horizontal-slicing anti-patterns, with its "confirm seams with the user" step left out because the architect's lane plan names the red tests. License texts: `../../licenses/obra-superpowers-MIT.txt`, `../../licenses/mattpocock-skills-MIT.txt`.

In 0.7.0, from the same skill at obra/superpowers commit bb92a77741419a4ab5f06e711a283343f1ada0c3 and its `writing-good-tests.md`: the whole-suite run with every red named, naming the failing change before the test body, and mocks that carry the full data shape.
