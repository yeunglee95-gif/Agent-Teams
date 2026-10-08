# dev-team changelog

## 0.2.0 (2026-10-08)

Ten roles and eleven skills. The roles stay short and say who does what; the skills say how, and each role preloads only the ones it needs. Skills were adapted from published sources, with each source, commit, license and change recorded (`THIRD_PARTY.md`, `licenses/`).

- Roles: mechanic merged into fix-owner, renamed `fixer`, which keeps both modes (a findings pass, or one bounded fix from a precise brief). New `repo-auditor`, read-only, for code the team did not build. The reviewer now also reviews the architect's plans and the repo-auditor's consolidation plans before anyone builds.
- Skills: verify-before-done, tests-first, root-cause-debugging, weigh-review-findings, hidden-failure-check, no-quiet-lowering, architecture-critique, repo-audit, decision-record, release-checklist, claude-md-upkeep.
- The critic preloads only verify-before-done, with the screen as its evidence, and is told to ignore any rule that says to explore the project files first.
- Not taken, because they break the team's rules: skills that merge, push or deploy on their own; reviewers that fix code; loops that give up on a red after one retry; whole plugins whose startup hooks make every session read the code first.
- Models: `opus` for fixer and repo-auditor; the rest unchanged. A lead may run the fixer on `sonnet` for a bounded fix.
- Checked on Claude Code 2.1.294: skills listed by plain name preload in both layouts. The repo-auditor loaded its three from a copied `.claude/` layout, and `dev-team:reviewer` loaded its four from the plugin, per the `--debug` log ("Preloaded skill ..."). A skipped skill is logged there too.

## 0.1.0 (2026-10-04)

First release. The ten roles come from OS Flow's `.claude/agents/` (os-flow commit 65722fdd, the M3b pilot team), made app-neutral.

- Roles: architect, owner, mechanic, gate-runner, fix-owner, reviewer, spec-auditor, critic, security-reviewer, scribe.
- Every role reads the app's own `CLAUDE.md` for its memory file, specs, gate commands, ports, action tiers and specialists, and stops to ask when the `CLAUDE.md` does not say.
- Kept from OS Flow: tests first; verify every claim of done or green against the files or a re-run; one owner per cross-cutting rule, with disjoint files; never merge, deploy or settle a red; a critic never reads the code first; the scribe never invents a number; commit in short steps.
- Removed as OS Flow-specific: file paths, lane letters, ruling numbers, OS Flow's specs, the critic personas, the n8n rubric and OS Flow's security surfaces. They stay in OS Flow.
- Models, per OS Flow's current routing while Fable's limit holds: `opus` for architect, owner, fix-owner, reviewer, spec-auditor, critic, security-reviewer and scribe; `sonnet` for mechanic and gate-runner.

To do when Fable's limit lifts: architect, reviewer, spec-auditor, critic and security-reviewer return to `fable`, as a new version.
