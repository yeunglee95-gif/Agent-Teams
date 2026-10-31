# Third-party sources

Every skill in `skills/` names its source, commit, license and what was changed in its own `## Source` section. This file lists them in one place. The full license texts are in `licenses/`. None of the sources ships a NOTICE file.

| Skill | Adapted from | Commit | License |
|---|---|---|---|
| verify-before-done | obra/superpowers `skills/verification-before-completion` | 8ca22dba9a94f28898bbce59f2537ff4d87c747d | MIT, Copyright (c) 2025 Jesse Vincent |
| tests-first | obra/superpowers `skills/test-driven-development` (and, from 0.7.0, its `writing-good-tests.md`); mattpocock/skills `skills/engineering/tdd` (anti-patterns only) | 8ca22dba9a94f28898bbce59f2537ff4d87c747d, 0.7.0 additions at bb92a77741419a4ab5f06e711a283343f1ada0c3; 49dd158d1076134a641b33efb035946536778336 | MIT, Copyright (c) 2025 Jesse Vincent; MIT, Copyright (c) 2026 Matt Pocock |
| root-cause-debugging | obra/superpowers `skills/systematic-debugging`; mattpocock/skills `skills/engineering/diagnosing-bugs` | 8ca22dba9a94f28898bbce59f2537ff4d87c747d; 49dd158d1076134a641b33efb035946536778336 | MIT, Copyright (c) 2025 Jesse Vincent; MIT, Copyright (c) 2026 Matt Pocock |
| weigh-review-findings | obra/superpowers `skills/receiving-code-review` | 8ca22dba9a94f28898bbce59f2537ff4d87c747d | MIT, Copyright (c) 2025 Jesse Vincent |
| hidden-failure-check (with `smells.md`) | anthropics/claude-plugins-official `plugins/pr-review-toolkit/agents/silent-failure-hunter.md` and `pr-test-analyzer.md`; EricTechPro/super-board `skills/super-review/SKILL.md` and `skills/super-qa/SKILL.md`; mattpocock/skills `skills/engineering/code-review` and `skills/engineering/tdd` | b78ac49cdc6b3d7b61c4439470e311f4291265b1; 35e215615c98fa5da011368e764f38f86959bf95; 49dd158d1076134a641b33efb035946536778336 | Apache License 2.0; MIT, Copyright (c) 2026 Eric Tech; MIT, Copyright (c) 2026 Matt Pocock |
| no-quiet-lowering | addyosmani/agent-skills `skills/constraint-driven-development` (Step 6); garrytan/gstack `review/gate-integrity.md` (RH-2, RH-3, RH-10, RH-12; moves 6 to 9, 0.7.0) | 1401c8b8030e023baeebb31781a6653fe8e93026; 70fab3e246126da1004abd320e728c4c07b2b5cd | MIT, Copyright (c) 2025 Addy Osmani; MIT, Copyright (c) 2026 Garry Tan |
| architecture-critique | anthropics/claude-plugins-official `plugins/code-modernization/agents/architecture-critic.md`; mattpocock/skills `skills/engineering/codebase-design` (including `DEEPENING.md` and `DESIGN-IT-TWICE.md`) | b78ac49cdc6b3d7b61c4439470e311f4291265b1; f3fc5632f401156837ee3872f14fe33ccf1024ea and 49dd158d1076134a641b33efb035946536778336 (folder unchanged between them) | Apache License 2.0; MIT, Copyright (c) 2026 Matt Pocock |
| repo-audit | anthropics/claude-plugins-official `plugins/code-modernization/agents/legacy-analyst.md` and `commands/modernize-assess.md`; anthropics/knowledge-work-plugins `engineering/skills/tech-debt`; addyosmani/agent-skills `skills/deprecation-and-migration` | b78ac49cdc6b3d7b61c4439470e311f4291265b1; 8444efcd48f7012f09797778a36a33e73d0861f4; 1401c8b8030e023baeebb31781a6653fe8e93026 | Apache License 2.0; Apache License 2.0; MIT, Copyright (c) 2025 Addy Osmani |
| decision-record | anthropics/knowledge-work-plugins `engineering/skills/architecture` | 8444efcd48f7012f09797778a36a33e73d0861f4 | Apache License 2.0 |
| release-checklist | anthropics/knowledge-work-plugins `engineering/skills/deploy-checklist`; mattpocock/skills `skills/engineering/pr` (Merge Danger); EricTechPro/super-board `skills/super-review/SKILL.md` (merge protocol) | 8444efcd48f7012f09797778a36a33e73d0861f4; 49dd158d1076134a641b33efb035946536778336; 35e215615c98fa5da011368e764f38f86959bf95 | Apache License 2.0; MIT, Copyright (c) 2026 Matt Pocock; MIT, Copyright (c) 2026 Eric Tech |
| agents-md-upkeep | anthropics/claude-plugins-official `plugins/claude-md-management/skills/claude-md-improver` | b78ac49cdc6b3d7b61c4439470e311f4291265b1 | Apache License 2.0 |
| run-retro | mattpocock/skills `skills/engineering/retro` | 49dd158d1076134a641b33efb035946536778336 | MIT, Copyright (c) 2026 Matt Pocock |
| grill-the-plan | mattpocock/skills `skills/productivity/grilling` and `skills/engineering/domain-modeling` | 49dd158d1076134a641b33efb035946536778336 | MIT, Copyright (c) 2026 Matt Pocock |
| slice-the-plan | mattpocock/skills `skills/engineering/to-tickets`; obra/superpowers `skills/writing-plans` (Interfaces line and Review Focus, 0.7.0) | 49dd158d1076134a641b33efb035946536778336; bb92a77741419a4ab5f06e711a283343f1ada0c3 | MIT, Copyright (c) 2026 Matt Pocock; MIT, Copyright (c) 2025 Jesse Vincent |
| `workflows/milestone-loop.md` (not a skill) | EricTechPro/super-board `skills/super-board/references/run.md` and `run-workflow.md` (pre-flight, `blocked-by:` sweep, root-cause cap, halt) | 35e215615c98fa5da011368e764f38f86959bf95 | MIT, Copyright (c) 2026 Eric Tech |

## Adapted in 0.8.0 from affaan-m/ecc

| Where | Adapted from | Commit | License |
|---|---|---|---|
| `skills/architecture-critique` ("For a loop or automation") | `skills/loop-design-check/SKILL.md` (Action 2 and the red lines) | 76aaa77df6adc5b889e689007bf99b9a4f74af34 | MIT, Copyright (c) 2026 Affaan Mustafa |
| `skills/agents-md-upkeep` ("One owner per fact") | `skills/living-docs-governance/SKILL.md` (sections 2, 4, 5) | 76aaa77df6adc5b889e689007bf99b9a4f74af34 | MIT, Copyright (c) 2026 Affaan Mustafa |
| `skills/run-retro` (three-prompt test for skill edits) | `skills/skill-comply/SKILL.md` (scenarios at three strictness levels; method only) | 76aaa77df6adc5b889e689007bf99b9a4f74af34 | MIT, Copyright (c) 2026 Affaan Mustafa |
| `skills/no-quiet-lowering` (checker config, move 3) | `scripts/hooks/config-protection.js` (idea only, as a diff check) | 76aaa77df6adc5b889e689007bf99b9a4f74af34 | MIT, Copyright (c) 2026 Affaan Mustafa |

## Agent and loop text adapted in 0.7.0

| Where | Adapted from | Commit | License |
|---|---|---|---|
| `workflows/milestone-loop.md` Limits on fixing ("How a round closes"), `agents/reviewer.md`, `agents/spec-auditor.md`, `agents/security-reviewer.md` (re-verify verdicts, new breakage in the fix diff) | obra/superpowers `skills/subagent-driven-development/re-review-prompt.md` | bb92a77741419a4ab5f06e711a283343f1ada0c3 | MIT, Copyright (c) 2025 Jesse Vincent |
| `workflows/milestone-loop.md` ("Sort the fix diff") | garrytan/gstack `ship/SKILL.md` Step 16.2 (choose the change route) | 70fab3e246126da1004abd320e728c4c07b2b5cd | MIT, Copyright (c) 2026 Garry Tan |
| `agents/reviewer.md`, `agents/spec-auditor.md`, `workflows/milestone-loop.md` Combine findings (Declined to judge; grade by effect) | obra/superpowers `skills/requesting-code-review/code-reviewer.md` and `skills/executing-plans/SKILL.md` (Final Review) | bb92a77741419a4ab5f06e711a283343f1ada0c3 | MIT, Copyright (c) 2025 Jesse Vincent |
| `agents/owner.md`, `workflows/milestone-loop.md` stage 4 (clean start in the new worktree) | obra/superpowers `skills/using-git-worktrees/SKILL.md` Step 3 | bb92a77741419a4ab5f06e711a283343f1ada0c3 | MIT, Copyright (c) 2025 Jesse Vincent |
| `agents/security-reviewer.md` (supported finding, hypotheses, sibling search, coverage word) | garrytan/gstack `cso/SKILL.md` Phases 12 and 13 | 70fab3e246126da1004abd320e728c4c07b2b5cd | MIT, Copyright (c) 2026 Garry Tan |
| `agents/owner.md`, `agents/fixer.md` ("Simple and surgical") | forrestchang/andrej-karpathy-skills `skills/karpathy-guidelines/SKILL.md` (Simplicity First, Surgical Changes), itself derived from a post by Andrej Karpathy | 2c606141936f1eeef17fa3043a72095b4765b9c2 | MIT as stated in its README; no license file or copyright line ships, so only the idea is taken, rewritten in this team's words, with no text copied |
| every skill's `description:` (when to use it, not what it does) | obra/superpowers `skills/writing-skills/SKILL.md` ("Rich Description Field") | bb92a77741419a4ab5f06e711a283343f1ada0c3 | MIT, Copyright (c) 2025 Jesse Vincent |

## Referenced, not copied

Two design skills on Jase's claude.ai account are used by the lane owner and are not copied into this plugin: no license text ships for them, and nothing in `skills/` comes from them. The `owner` loads them with the Skill tool, by plain name, only on a lane that builds a designed screen; no dev role preloads them (`skills/REJECTED.md`). The design team's `THIRD_PARTY.md` lists all four design skills; the columns here say exactly what the synced files show, read on 2026-10-10.

| Skill | Where it lives | Version, license and author as found | Role | What for |
|---|---|---|---|---|
| design-system | Jase's account skills (`anthropic-skills:design-system`) | `license: MIT`; `metadata.author: claudekit`; `metadata.version: "1.0.0"` | owner | building to the hand-off's tokens: three layers, day and night, component states |
| emil-design-eng | Jase's account skills (`anthropic-skills:emil-design-eng`) | no license or version found in the synced files | owner | motion and interaction details while building a designed screen |

All adaptations were rewritten in this team's voice and changed to fit its rules; each skill's `## Source` section says what changed. Candidates read and not taken are listed, with the reason, in `skills/REJECTED.md`.

To check a source for updates, compare the file at its listed commit with the source's current default branch. A change worth taking lands here as a new plugin version with the new commit recorded, never as a silent edit.
