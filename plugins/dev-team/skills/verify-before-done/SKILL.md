---
name: verify-before-done
description: Use before saying anything is done, fixed, passing, green or clean, before a commit, and before reporting another agent's work as finished. Requires fresh evidence from a check run in this turn; a claim without it is not made.
---

# Verify before done

No claim of done, fixed, passing, green or clean without fresh evidence from this turn. A check you ran earlier, a check another agent says it ran, and "it should pass now" are not evidence.

## The gate

Before any status claim:

1. Name the check that proves it: the test, the gate part, the build, the screenshot, the diff.
2. Run it now, in full. Not a subset, not the last run.
3. Read the whole output: exit code, counts of passed, failed and skipped.
4. Say what the output says. If it confirms the claim, state the claim with its numbers. If it does not, state the real status with its numbers.

Skipping a step is not a shortcut; it is an unverified claim.

## What each claim needs

| Claim | Needs | Not enough |
|---|---|---|
| Tests pass | The test command's output with 0 failed | An earlier run, "should pass" |
| Bug fixed | The original symptom re-run and gone | The code changed |
| A test guards the bug | The test watched red without the fix, then green with it | The test passes once |
| Build succeeds | The build command exits 0 | Lint passed |
| An agent finished | The diff shows the change, and its tests run green for you | The agent's report |
| Spec met | Each spec row checked one by one | Tests passing |
| A screen works (critic) | A screenshot of the result on that target | The code that should draw it |

## Stop when you notice

- "should", "probably", "seems to", "looks fine"
- Relief or praise before the check ran ("Done!", "Perfect")
- A report from another agent about to be passed on as fact
- A partial run standing in for the full one
- "Just this once"

Every one of these means: run the check, then speak.

The app's `CLAUDE.md` names the gate commands and the targets. "Not run" on any target is a red result, not a blank.

## Source

Adapted from `verification-before-completion` in obra/superpowers (MIT, Copyright (c) 2025 Jesse Vincent), commit 8ca22dba9a94f28898bbce59f2537ff4d87c747d. Changed: rewritten in this team's voice, the table extended with the spec and critic rows, PR and push wording removed. License text: `../../licenses/obra-superpowers-MIT.txt`.
