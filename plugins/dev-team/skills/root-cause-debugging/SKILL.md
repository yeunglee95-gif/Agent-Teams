---
name: root-cause-debugging
description: Use for any bug, failing test, red gate or behavior that differs from the spec, before proposing a fix. Find and prove the cause first; fix the cause, not the symptom; stop after three failed fixes and question the design.
---

# Root-cause debugging

No fix before the cause is found. A fix aimed at a symptom moves the bug somewhere else.

## 1. Investigate

- Read the whole error and stack trace: file, line, code. It often names the cause.
- Reproduce it reliably with exact steps. If you cannot, gather more evidence; do not guess.
- Check what changed: the diff, recent commits, new dependencies, config, environment.
- Where the path crosses parts (browser to API to database, a scheduler to a script to an outside service), log what enters and leaves each part once, to see which one breaks.
- Trace a bad value back to where it first goes wrong. Fix it there.

## 2. Compare

Find similar code in the same app that works. List every difference between the working and the broken case, however small.

## 3. One hypothesis at a time

Write it down: "I think X causes this because Y." Test it with the smallest change, one variable at a time. If it is wrong, form a new hypothesis; do not stack another change on top. If you do not understand something, say so.

## 4. Fix

- A failing test that reproduces the bug comes first (the `tests-first` skill).
- One change, aimed at the cause. No "while I'm here" edits.
- Re-run the test, the suite, and the original symptom (the `verify-before-done` skill).

## Three strikes

If three fixes have failed, or each fix reveals a new problem in a different place, stop. That pattern means the design is wrong, not the fix. Report what you tried and what each attempt showed, and hand the question to the architect. Never try a fourth fix on your own.

## Never

A retry, a settle wait, a wider limit or a weaker assertion to make a red go green. A red gets a cause or stays recorded as red.

## Source

Adapted from `systematic-debugging` in obra/superpowers (MIT, Copyright (c) 2025 Jesse Vincent), commit 8ca22dba9a94f28898bbce59f2537ff4d87c747d. Changed: shortened, rewritten in this team's voice, the escalation pointed at the architect, and the team's no-retry rule added. License text: `../../licenses/obra-superpowers-MIT.txt`.
