---
name: no-quiet-lowering
description: Use when running the gate or reviewing a diff, to catch a quality bar lowered on the way to green. Checks the diff since the branch point for moved thresholds, easier or skipped tests, silenced checkers, unfinished stubs and new exceptions.
---

# No quiet lowering

An agent that hits a red check takes the cheapest road to green. The cheapest road is usually to lower the bar, not to fix the code. Tightening a bar can be silent; loosening one must be loud.

## Check the diff since the branch point for five moves

1. **A threshold moved.** A budget, timeout, coverage target, severity or performance limit lowered, or a check moved out of the gate.
2. **A test got easier.** A skip or only marker added, a test file deleted, assertions removed from a test that stayed, an expected value edited to match a wrong output.
3. **A checker was silenced.** New suppression comments (for example `@ts-ignore`, `eslint-disable`, `# noqa`, `# type: ignore`), coverage ignores, or allow-list entries for a security scanner.
4. **Work is unfinished.** A stub that throws "not implemented", an empty catch, a TODO where the code should be.
5. **An exception appeared.** A new entry in an allow list, an ignore file or the app's exceptions table that nobody decided.

Use `git diff <branch point>...HEAD` and read it; this needs no other tool.

## What to do with a hit

Each hit is a finding: path and line, which of the five moves, and what it hides. It is at least a major, and a blocker when it hides a red the gate would otherwise show. A hit is cleared only by a decision the owner made and the memory file records, quoted with its date. "The test was flaky" is not a decision; it is a red with no cause yet.

The gate-runner reports hits beside its numbers. The reviewer checks for them in every review.

## Source

Adapted from Step 6, "Guard the bar itself", of `constraint-driven-development` in addyosmani/agent-skills (MIT, Copyright (c) 2025 Addy Osmani), commit 1401c8b8030e023baeebb31781a6653fe8e93026. Changed: only the diff guard is taken (not the CONSTRAINTS.md interview or tool installs), rewritten in this team's voice, and tied to the memory file for exceptions. License text: `../../licenses/addyosmani-agent-skills-MIT.txt`.
