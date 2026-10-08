# Third-party sources

Every skill in `skills/` names its source, commit, license and what was changed in its own `## Source` section. This file lists them in one place. The full license texts are in `licenses/`. None of the sources ships a NOTICE file.

| Skill | Adapted from | Commit | License |
|---|---|---|---|
| verify-before-done | obra/superpowers `skills/verification-before-completion` | 8ca22dba9a94f28898bbce59f2537ff4d87c747d | MIT, Copyright (c) 2025 Jesse Vincent |
| tests-first | obra/superpowers `skills/test-driven-development` | 8ca22dba9a94f28898bbce59f2537ff4d87c747d | MIT, Copyright (c) 2025 Jesse Vincent |
| root-cause-debugging | obra/superpowers `skills/systematic-debugging` | 8ca22dba9a94f28898bbce59f2537ff4d87c747d | MIT, Copyright (c) 2025 Jesse Vincent |
| weigh-review-findings | obra/superpowers `skills/receiving-code-review` | 8ca22dba9a94f28898bbce59f2537ff4d87c747d | MIT, Copyright (c) 2025 Jesse Vincent |
| hidden-failure-check | anthropics/claude-plugins-official `plugins/pr-review-toolkit/agents/silent-failure-hunter.md` and `pr-test-analyzer.md` | b78ac49cdc6b3d7b61c4439470e311f4291265b1 | Apache License 2.0 |
| no-quiet-lowering | addyosmani/agent-skills `skills/constraint-driven-development` (Step 6) | 1401c8b8030e023baeebb31781a6653fe8e93026 | MIT, Copyright (c) 2025 Addy Osmani |
| architecture-critique | anthropics/claude-plugins-official `plugins/code-modernization/agents/architecture-critic.md`; mattpocock/skills `skills/engineering/codebase-design` | b78ac49cdc6b3d7b61c4439470e311f4291265b1; f3fc5632f401156837ee3872f14fe33ccf1024ea | Apache License 2.0; MIT, Copyright (c) 2026 Matt Pocock |
| repo-audit | anthropics/claude-plugins-official `plugins/code-modernization/agents/legacy-analyst.md` and `commands/modernize-assess.md`; anthropics/knowledge-work-plugins `engineering/skills/tech-debt`; addyosmani/agent-skills `skills/deprecation-and-migration` | b78ac49cdc6b3d7b61c4439470e311f4291265b1; 8444efcd48f7012f09797778a36a33e73d0861f4; 1401c8b8030e023baeebb31781a6653fe8e93026 | Apache License 2.0; Apache License 2.0; MIT, Copyright (c) 2025 Addy Osmani |
| decision-record | anthropics/knowledge-work-plugins `engineering/skills/architecture` | 8444efcd48f7012f09797778a36a33e73d0861f4 | Apache License 2.0 |
| release-checklist | anthropics/knowledge-work-plugins `engineering/skills/deploy-checklist` | 8444efcd48f7012f09797778a36a33e73d0861f4 | Apache License 2.0 |
| claude-md-upkeep | anthropics/claude-plugins-official `plugins/claude-md-management/skills/claude-md-improver` | b78ac49cdc6b3d7b61c4439470e311f4291265b1 | Apache License 2.0 |

All adaptations were rewritten in this team's voice and changed to fit its rules; each skill's `## Source` section says what changed.

To check a source for updates, compare the file at its listed commit with the source's current default branch. A change worth taking lands here as a new plugin version with the new commit recorded, never as a silent edit.
