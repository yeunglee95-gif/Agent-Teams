---
name: root-cause-debugging
description: Use for any bug, failing test, red gate or behavior that differs from the spec, before proposing a fix.
---

# Root-cause debugging

No fix before the cause is found. A fix aimed at a symptom moves the bug somewhere else.

The order holds even when the cause looks obvious: a red command, run (step 1); three to five ranked hypotheses, written down where they can be seen (step 3); probes, one at a time; then the fix (step 4). No source edit before that list is written.

## 1. Build a command that shows the bug red

This comes before any theory. Make one command (a test run, a script, a request, a browser script) that drives the real code path and shows the exact symptom the report describes. Run it at least once and keep its output (secrets replaced with `<REDACTED>`). It must be:

- **Red-capable:** it asserts the exact symptom, so it goes red on this bug and green once fixed. "Runs without crashing" is not enough.
- **Deterministic:** the same verdict every run. For a flaky bug, raise the reproduction rate (loop it, add load, narrow the timing) until it fails often enough to work with.
- **Fast:** seconds, not minutes. Cut setup, narrow the scope, pin time and random seeds.
- **Runnable by you,** unattended.

Ways to get one, roughly in order: a failing test at whatever level reaches the bug; a request against the running app; the command line with a fixed input, diffed against a known good output; a browser script that asserts on the page; a replay of a captured request or event log; a small harness around the one code path; many random inputs; a bisect script between a good and a bad commit; the same input through the old and the new version.

If you cannot build one, stop. Say what you tried and ask for what would let you: access to where it happens, a captured log or recording, or permission to add temporary logging. Do not move on to theories without it.

Then shrink it: cut inputs, steps, config and data one at a time, re-running after each cut, until every part left is needed for the red.

## 2. Investigate

- Read the whole error and stack trace: file, line, code. It often names the cause.
- Check what changed: the diff, recent commits, new dependencies, config, environment.
- Where the path crosses parts (browser to API to database, a scheduler to a script to an outside service), log what enters and leaves each part once, to see which one breaks.
- Trace a bad value back to where it first goes wrong. Fix it there.
- Find similar code in the same app that works. List every difference between the working and the broken case, however small.

## 3. Rank hypotheses, then test one at a time

Write three to five hypotheses before testing any of them, ranked by likelihood. One hypothesis alone anchors on the first idea that fits. Each must be falsifiable: "If X is the cause, then changing Y makes the bug go away (or changing Z makes it worse)." One you cannot state that way is a hunch; sharpen it or drop it. Write the ranked list down as a numbered list after the command is red and before your first probe or source edit: in the notes file your brief or the app's `CLAUDE.md` names for this work, or in your reply text if none is named (thinking it through does not count). Do this even when the code or the red output already seems to show the cause: an obvious cause is where anchoring happens. Whoever briefed you may know one is already ruled out.

Then test them in order, one variable at a time, each probe tied to one prediction. If a hypothesis is wrong, move to the next; do not stack another change on top. If you do not understand something, say so.

Tag every temporary debug log with one unique prefix (for example `[DEBUG-a4f2]`). Before you finish, grep for the prefix and remove every hit. For a slow-path bug, measure a baseline first and fix second; logs rarely find it.

## 4. Fix

- Before the first source edit, check that the ranked list from step 3 is written down. If it is not, write it now.
- A failing test that reproduces the bug comes first (the `tests-first` skill), at a seam where the test exercises the real bug as it happens at the call site. If no such seam exists (the only test you could write is too shallow to catch it), that is itself a finding: report it, because the design is stopping the bug from being locked down.
- One change, aimed at the cause. No "while I'm here" edits.
- Re-run the test, the suite, and the command from step 1 on the original, unshrunk case (the `verify-before-done` skill).
- State in the commit message which hypothesis was right.
- Your report shows the evidence, not just the conclusion, in this shape:

  ```
  Red: `<the step 1 command, exactly as run>` -> <its red output>
  Hypotheses, ranked before testing: 1. ... 2. ... 3. ... Held: <number>
  Green: `<the same command>` -> <its output after the fix>
  ```

## Three strikes

If three fixes have failed, or each fix reveals a new problem in a different place, stop. That pattern means the design is wrong, not the fix. Report what you tried and what each attempt showed, and hand the question to the architect. Never try a fourth fix on your own.

## Never

A retry, a settle wait, a wider limit or a weaker assertion to make a red go green. A red gets a cause or stays recorded as red.

## Source

Adapted from two sources:

- `systematic-debugging` in obra/superpowers (MIT, Copyright (c) 2025 Jesse Vincent), commit 8ca22dba9a94f28898bbce59f2537ff4d87c747d. License text: `../../licenses/obra-superpowers-MIT.txt`.
- `skills/engineering/diagnosing-bugs/SKILL.md` in mattpocock/skills (MIT, Copyright (c) 2026 Matt Pocock), commit 49dd158d1076134a641b33efb035946536778336. License text: `../../licenses/mattpocock-skills-MIT.txt`.

Changed: shortened and rewritten in this team's voice; diagnosing-bugs' feedback-loop phase made step 1 (one red, deterministic, fast command, run before any hypothesis), with its ranked falsifiable hypotheses, tagged debug logs removed by grep, and "no correct seam is itself a finding"; its human-in-the-loop script and phase numbering not taken; the escalation pointed at the architect; the team's three-strikes and no-retry rules kept.
