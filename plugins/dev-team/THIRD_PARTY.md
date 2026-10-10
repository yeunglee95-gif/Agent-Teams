# Third-party sources

Every skill in `skills/` names its source, commit, license and what was changed in its own `## Source` section. This file lists them in one place. The full license texts are in `licenses/`. None of the sources ships a NOTICE file.

| Skill | Adapted from | Commit | License |
|---|---|---|---|
| verify-before-done | obra/superpowers `skills/verification-before-completion` | 8ca22dba9a94f28898bbce59f2537ff4d87c747d | MIT, Copyright (c) 2025 Jesse Vincent |
| tests-first | obra/superpowers `skills/test-driven-development`; mattpocock/skills `skills/engineering/tdd` (anti-patterns only) | 8ca22dba9a94f28898bbce59f2537ff4d87c747d; 49dd158d1076134a641b33efb035946536778336 | MIT, Copyright (c) 2025 Jesse Vincent; MIT, Copyright (c) 2026 Matt Pocock |
| root-cause-debugging | obra/superpowers `skills/systematic-debugging`; mattpocock/skills `skills/engineering/diagnosing-bugs` | 8ca22dba9a94f28898bbce59f2537ff4d87c747d; 49dd158d1076134a641b33efb035946536778336 | MIT, Copyright (c) 2025 Jesse Vincent; MIT, Copyright (c) 2026 Matt Pocock |
| weigh-review-findings | obra/superpowers `skills/receiving-code-review` | 8ca22dba9a94f28898bbce59f2537ff4d87c747d | MIT, Copyright (c) 2025 Jesse Vincent |
| hidden-failure-check (with `smells.md`) | anthropics/claude-plugins-official `plugins/pr-review-toolkit/agents/silent-failure-hunter.md` and `pr-test-analyzer.md`; EricTechPro/super-board `skills/super-review/SKILL.md` and `skills/super-qa/SKILL.md`; mattpocock/skills `skills/engineering/code-review` and `skills/engineering/tdd` | b78ac49cdc6b3d7b61c4439470e311f4291265b1; 35e215615c98fa5da011368e764f38f86959bf95; 49dd158d1076134a641b33efb035946536778336 | Apache License 2.0; MIT, Copyright (c) 2026 Eric Tech; MIT, Copyright (c) 2026 Matt Pocock |
| no-quiet-lowering | addyosmani/agent-skills `skills/constraint-driven-development` (Step 6) | 1401c8b8030e023baeebb31781a6653fe8e93026 | MIT, Copyright (c) 2025 Addy Osmani |
| architecture-critique | anthropics/claude-plugins-official `plugins/code-modernization/agents/architecture-critic.md`; mattpocock/skills `skills/engineering/codebase-design` (including `DEEPENING.md` and `DESIGN-IT-TWICE.md`) | b78ac49cdc6b3d7b61c4439470e311f4291265b1; f3fc5632f401156837ee3872f14fe33ccf1024ea and 49dd158d1076134a641b33efb035946536778336 (folder unchanged between them) | Apache License 2.0; MIT, Copyright (c) 2026 Matt Pocock |
| repo-audit | anthropics/claude-plugins-official `plugins/code-modernization/agents/legacy-analyst.md` and `commands/modernize-assess.md`; anthropics/knowledge-work-plugins `engineering/skills/tech-debt`; addyosmani/agent-skills `skills/deprecation-and-migration` | b78ac49cdc6b3d7b61c4439470e311f4291265b1; 8444efcd48f7012f09797778a36a33e73d0861f4; 1401c8b8030e023baeebb31781a6653fe8e93026 | Apache License 2.0; Apache License 2.0; MIT, Copyright (c) 2025 Addy Osmani |
| decision-record | anthropics/knowledge-work-plugins `engineering/skills/architecture` | 8444efcd48f7012f09797778a36a33e73d0861f4 | Apache License 2.0 |
| release-checklist | anthropics/knowledge-work-plugins `engineering/skills/deploy-checklist`; mattpocock/skills `skills/engineering/pr` (Merge Danger); EricTechPro/super-board `skills/super-review/SKILL.md` (merge protocol) | 8444efcd48f7012f09797778a36a33e73d0861f4; 49dd158d1076134a641b33efb035946536778336; 35e215615c98fa5da011368e764f38f86959bf95 | Apache License 2.0; MIT, Copyright (c) 2026 Matt Pocock; MIT, Copyright (c) 2026 Eric Tech |
| claude-md-upkeep | anthropics/claude-plugins-official `plugins/claude-md-management/skills/claude-md-improver` | b78ac49cdc6b3d7b61c4439470e311f4291265b1 | Apache License 2.0 |
| run-retro | mattpocock/skills `skills/engineering/retro` | 49dd158d1076134a641b33efb035946536778336 | MIT, Copyright (c) 2026 Matt Pocock |
| grill-the-plan | mattpocock/skills `skills/productivity/grilling` and `skills/engineering/domain-modeling` | 49dd158d1076134a641b33efb035946536778336 | MIT, Copyright (c) 2026 Matt Pocock |
| slice-the-plan | mattpocock/skills `skills/engineering/to-tickets` | 49dd158d1076134a641b33efb035946536778336 | MIT, Copyright (c) 2026 Matt Pocock |
| `workflows/milestone-loop.md` (not a skill) | EricTechPro/super-board `skills/super-board/references/run.md` and `run-workflow.md` (pre-flight, `blocked-by:` sweep, root-cause cap, halt) | 35e215615c98fa5da011368e764f38f86959bf95 | MIT, Copyright (c) 2026 Eric Tech |

All adaptations were rewritten in this team's voice and changed to fit its rules; each skill's `## Source` section says what changed. Candidates read and not taken are listed, with the reason, in `skills/REJECTED.md`.

To check a source for updates, compare the file at its listed commit with the source's current default branch. A change worth taking lands here as a new plugin version with the new commit recorded, never as a silent edit.
