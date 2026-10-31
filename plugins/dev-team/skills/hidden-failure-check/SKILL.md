---
name: hidden-failure-check
description: Use when reviewing a change or re-reviewing after a fix, and in the spec-auditor's sweep.
---

# Hidden-failure check

Two questions for every change: does anything fail without telling anyone, and would the tests notice if the feature broke? A builder's report answers neither; it is a lead, never evidence.

## Before anything: your own pass

1. **Re-review? Earlier findings first.** If an earlier review of this work exists, check each of its findings by id before anything else: fixed (cite the `path:line` or test that shows it), not fixed (still true of the code; a reply saying "fixed" or a closed thread is not evidence), or no longer applies (the code is gone or the spec changed; do not raise it again). Ids never change; new findings take the next free id.
2. **Hypotheses before the report.** Read the spec rows the work claims and the raw diff (`git diff <base>...HEAD`) and nothing else. Write two to four hypotheses into your review file: what must be true for this to be right, and where it would most likely break. Save the file before you open the report in any way, and never read the report in the same command or step as anything else. Only then open the builder's report, lane message or PR description, and check each of its claims against the code and a test run, the same way you check your own hypotheses. Reading the report first anchors you on the builder's framing; the point of a review is a second, independent look.
3. Scope is the diff and what it touches, never the whole codebase.

## Part 1: errors that hide

Find every place the change handles an error: try and catch, error callbacks, default values on failure, optional chaining, retries, fallbacks. For each one ask:

- **Is it silent?** An empty catch, a catch that only logs and carries on, a null or default returned without a log. A failed send that still reports "sent" is a blocker: the app lies about itself.
- **Is the catch too broad?** Name the unrelated errors it would also swallow.
- **Is the fallback justified?** A fallback the spec does not ask for hides the real problem. A fallback to a fake or sample implementation outside tests is a blocker.
- **Does the person see it?** A message that says what went wrong and what they can do, in every language the app ships.
- **Does it reach the log** with enough context (what failed, which record) to debug it months later, and without any credential?
- **Should it go up instead,** to a handler that can do something about it?

## Part 2: the test-gap table

On a change that touches auth, money, data loss or security, have a read-only sub-agent fill steps 1 to 3 from the spec rows, the diff range and the changed-file list only, so it is not anchored on the builder's reasoning.

The result is one table with these columns, one row per spec row, because the owner, the fixer and the checks read it:

`| Spec row | Test (file > name, or none) | Level (unit, component, e2e) | Edge cases (exact values) | Rank (High, Medium, Low) | Note |`

Test is the test that asserts the row, as `file > test name`, or `none`. Edge cases holds the row's exact values from step 2. Rank is the row's worst open gap, Low when none is open. A test flagged in step 3 stays in Test, and its row says `tautological` (or `cannot fail`) in Note. Other tables (edge-case classes, mutations) can follow; they do not replace this one.

1. **Each spec row to its test.** One row per behavior the work claims. For each level (unit, component, end-to-end), the test that asserts it (`file > test name`, or `path:line`), or `none`, or `n/a: <reason>`. Fill the unit level for every row first, then component, then end-to-end. A test that runs the code but asserts nothing about the row is `none`.
2. **Edge cases with exact values.** For each changed input or branch, mark each class pinned (`path:line`), gap (with the exact value that would show it, never "consider edge cases"), or n/a: limits (limit minus one, the limit, limit plus one; zero, null and empty), money and dates (rounding, time zone shift, month end), input (unicode, very long, formula injection in exports), volume (none, one, many, paging), access (signed out, another person's id, wrong plan), error paths (every catch and rejected promise), repeats and races (double submit, replay), interface states (loading, empty, error, disabled), accessibility (role and name, focus).
3. **Test the tests.** Flag a test that asserts on its own mock, checks how the code is built instead of what it does, recomputes the expected value the way the code does (tautological: it can never disagree with the code), or cannot fail. For high-risk logic, name the change no test would catch (`>` to `>=`, a dropped branch).
4. **Rank.** High: a spec row with no test at any level, or any gap in access, money, security or data loss. Medium: a partly covered branch, a change no test catches, a missing loading, empty or error state. Low: cosmetic, copy, logging.
5. **Prove the new tests.** A new test that passed on its first run has not been seen to fail. Break the line it guards in a scratch worktree, see the test red, restore the line, see it green. The broken line never reaches a commit, and nobody who checks this way edits the app's real code.

High gaps block: the stage does not pass while one is open. Each goes to the fixer as a finding, labeled like any other (Verification miss, or Gap when the behavior itself is missing), with the exact value, the expected result, the level and the target file. Medium and Low are listed and never block on their own.

## Report each finding

Every finding carries:

- **Class:** Gap (a spec row or asked-for behavior missing or incomplete), Bug (the code likely fails or regresses), Verification miss (the code may be right but the evidence does not prove it), Scope drift (the diff changes something nobody asked for, or skips a stated constraint), or Over-engineering (it works but builds more than the spec needs: a new dependency, abstraction, setting or file where existing code or one line would do). Over-engineering is always minor and never blocks on its own. A simplification that would cut validation, security, data-loss protection or accessibility is not a finding.
- **Axis:** spec (does it do what the spec row says) or standards (does it follow the app's `AGENTS.md` (or `CLAUDE.md` where the app has not switched yet) rules and the code-smell baseline in `smells.md`, next to this file). Report the two axes in separate sections and never rerank findings across them; name the worst finding within each axis, not one winner overall. A smell is always a judgment call and the app's documented rules override it.
- **Severity:** blocker (silent failure, a fallback that lies, a High gap), major (an untested rule or path a person depends on, a misleading message), minor (missing context, a smell, over-engineering).
- Path and line, what could be hidden or missed, what the person would experience, and a suggested test title.

Every item you report as a problem is a finding with all of the above, including test gaps and broken `AGENTS.md` rules. A hypothesis or claim you checked and found true is not a finding: list it as "holds", with the `path:line` or command that showed it, so the next round does not argue it again.

## Source

Adapted from three sources:

- The `silent-failure-hunter` and `pr-test-analyzer` agents in Anthropic's `pr-review-toolkit` plugin (anthropics/claude-plugins-official, Apache License 2.0), commit b78ac49cdc6b3d7b61c4439470e311f4291265b1. License text: `../../licenses/Apache-2.0.txt`.
- `skills/super-review/SKILL.md` (review flow steps 2 and 3, "Review remembers") and `skills/super-qa/SKILL.md` ("Test-gap check (after build)") in EricTechPro/super-board (MIT, Copyright (c) 2026 Eric Tech), commit 35e215615c98fa5da011368e764f38f86959bf95. License text: `../../licenses/erictechpro-super-board-MIT.txt`.
- `skills/engineering/code-review/SKILL.md` (the two axes and the smell baseline) and the tautological-test anti-pattern in `skills/engineering/tdd/SKILL.md` in mattpocock/skills (MIT, Copyright (c) 2026 Matt Pocock), commit 49dd158d1076134a641b33efb035946536778336. License text: `../../licenses/mattpocock-skills-MIT.txt`.

Changed: merged into one skill and rewritten in this team's voice; severities mapped to this team's blocker, major and minor; the mutation check added. From super-board: hypotheses before the builder's report, the five finding classes with over-engineering never blocking alone, re-checking earlier findings by id, and the test-gap table, with acceptance criteria read as spec rows; not taken: the GitHub report comment, the ponytail plugin, routing to lanes by PR thread, filing refactor cards straight to Ready, the "if the user authorizes, fix" clause, and writing the High-gap tests (this team's fixer writes them). From code-review: the two axes kept apart and never reranked, and the smell baseline as judgment calls; the parallel sub-agents and tracker lookup not taken.
