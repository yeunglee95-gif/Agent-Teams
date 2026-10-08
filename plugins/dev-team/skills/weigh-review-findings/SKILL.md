---
name: weigh-review-findings
description: Use when taking findings from a review, a security review, a critic report or the owner, before changing any code. Check each finding against the code, ask about unclear ones first, push back with evidence when one is wrong, then fix one at a time.
---

# Weigh review findings

A finding is a claim to check, not an order to obey. Check it against the code before acting.

## For each report

1. Read every finding before touching anything.
2. If any finding is unclear, stop and ask about it before fixing the others. Findings are often linked, and half an understanding gives a wrong fix.
3. For each finding, check:
   - Is it true in this code? Reproduce it.
   - Would the suggested fix break something that works?
   - Is there a reason the code is the way it is (a decision in the memory file, a ruling, a platform limit)?
   - Is the thing it asks for used at all? If nothing calls it, say so and propose removing it rather than building it out.
4. Fix in this order: blockers and security first, then simple fixes, then larger ones. One finding at a time, with a test that fails first, re-run after each.

## When a finding is wrong

Say so with evidence: the test, the line, the screenshot, the decision it conflicts with. If it touches the architecture or a decision the owner made, raise it with the architect or the owner; do not settle it yourself.

## How to report

State what changed and where, or why you did not change it. No thanks, no praise, no "you're right": the fix or the evidence is the answer. If you pushed back and were wrong, say what you checked and fix it.

The reviewer who wrote the finding re-verifies it; you never sign your own fix as verified.

## Source

Adapted from `receiving-code-review` in obra/superpowers (MIT, Copyright (c) 2025 Jesse Vincent), commit 8ca22dba9a94f28898bbce59f2537ff4d87c747d. Changed: shortened, rewritten in this team's voice, pointed at the team's roles and memory file, GitHub reply steps removed. License text: `../../licenses/obra-superpowers-MIT.txt`.
