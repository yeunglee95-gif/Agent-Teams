---
name: no-quiet-lowering
description: Use when running the gate, reviewing a diff or re-verifying a fix round, to catch a quality bar lowered on the way to green.
---

# No quiet lowering

An agent that hits a red check takes the cheapest road to green. The cheapest road is usually to lower the bar, not to fix the code. Tightening a bar can be silent; loosening one must be loud.

## Check the diff since the branch point for nine moves

1. **A threshold moved.** A budget, timeout, coverage target, severity or performance limit lowered, or a check moved out of the gate.
2. **A test got easier.** A skip or only marker added, a test file deleted, assertions removed from a test that stayed, an expected value edited to match a wrong output.
3. **A checker was silenced.** New suppression comments (for example `@ts-ignore`, `eslint-disable`, `# noqa`, `# type: ignore`), coverage ignores, allow-list entries for a security scanner, or a checker's own config loosened (a lint, format, type-check or test-runner config file with a rule turned off, a severity lowered or a path excluded).
4. **Work is unfinished.** A stub that throws "not implemented", an empty catch, a TODO where the code should be.
5. **An exception appeared.** A new entry in an allow list, an ignore file or the app's exceptions table that nobody decided.
6. **The spec moved to meet the work.** Acceptance text in a spec, plan or milestone file was rewritten on the branch so the delivered work matches it. Compare each acceptance line the milestone claims with its text at the branch point (`git diff <branch point>...HEAD -- <spec paths>`). The original line is still the one checked; the edit is reported as `acceptance edited`, and only the owner can accept the new text.
7. **The code knows it is under test.** Product code (not test code) branches on a test or CI signal (`CI`, `NODE_ENV === 'test'`, `PYTEST_CURRENT_TEST`, `GITHUB_ACTIONS`, a test-only flag or query parameter), so the code the tests run is not the code people get.
8. **A snapshot was regenerated, not tested.** A snapshot or golden file changed while the test that owns it did not, so new output was accepted rather than checked. A snapshot updated alongside the source change and test that explain it is not a hit.
9. **The proof is a weaker kind than the claim.** A mock, fixture, stub, replay or text search is presented as the evidence for a claim that needs the real thing: "works against the live service" when a stub answered, "the route is reachable" from a grep, "fixed" from a test that never ran the failing input.

Use `git diff <branch point>...HEAD` and read it; this needs no other tool.

## What to do with a hit

Each hit is a finding: path and line, which of the nine moves, and what it hides. It is at least a major, and a blocker when it hides a red the gate would otherwise show. A hit is cleared only by a decision the owner made and the memory file records, quoted with its date. "The test was flaky" is not a decision; it is a red with no cause yet.

The gate-runner reports hits beside its numbers. The reviewer checks for them in every review.

## Source

Adapted from Step 6, "Guard the bar itself", of `constraint-driven-development` in addyosmani/agent-skills (MIT, Copyright (c) 2025 Addy Osmani), commit 1401c8b8030e023baeebb31781a6653fe8e93026. Changed: only the diff guard is taken (not the CONSTRAINTS.md interview or tool installs), rewritten in this team's voice, and tied to the memory file for exceptions. License text: `../../licenses/addyosmani-agent-skills-MIT.txt`.

Moves 6 to 9 are adapted from RH-10 (spec editing as progress), RH-12 (environment sniffing in product code), RH-3 (snapshot or golden regenerated without its owning test) and RH-2 (proof-class inflation) in `review/gate-integrity.md` in garrytan/gstack (MIT, Copyright (c) 2026 Garry Tan), commit 70fab3e246126da1004abd320e728c4c07b2b5cd. Changed: rewritten as plain checks on the diff; gstack's tags, helper scripts, four-option prompt and PR-body lines not taken; an edited acceptance line goes to the owner. License text: `../../licenses/garrytan-gstack-MIT.txt`.

The checker-config clause in move 3 (0.8.0) is taken from the idea of `scripts/hooks/config-protection.js` in affaan-m/ecc (MIT, Copyright (c) 2026 Affaan Mustafa), commit 76aaa77df6adc5b889e689007bf99b9a4f74af34: as a check on the diff, not as a hook. License text: `../../licenses/affaan-m-ecc-MIT.txt`.
