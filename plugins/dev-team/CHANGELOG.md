# dev-team changelog

## 0.4.0 (2026-10-10)

The loop gains the design team's two stages. Scope approved by the owner on 2026-10-10; ships with design-team 0.1.0 in the same repo.

- Loop: two new stages for milestones that change screens, **Design** (stage 3, the design team's designer, after Plan and slice and before Build; gate: the owner approves the design hand-off) and **Design check** (stage 9, the design team's design-auditor, after Black-box check and before Review; gate: no blocker or major design finding open). Both are skipped for a milestone with no screen change. Sixteen stages, renumbered; Watch is now stage 15. A new **Phase** column (Plan, Build, Check, Fix, Ship, Learn) groups the stages for tools that draw the loop. A missing screen, state or token goes back to the designer at pre-flight; the design-auditor, like the reviewer, never patches code; design findings are re-checked by id in Fix and re-verify.
- `owner`: on a lane that builds a designed screen, reads the hand-off, loads `design-system` and `emil-design-eng` with the Skill tool, and builds to the hand-off; a gap goes back to the designer, never invented by the lane.
- Not taken: preloading the four design skills on every dev role (`skills/REJECTED.md`). The reviewer, critic, architect and the other roles are unchanged; the critic stays screen-only.
- `THIRD_PARTY.md`: a "Referenced, not copied" table for the two account skills the owner loads.
- Checked on Claude Code 2.1.296: from a plugin subagent, the Skill tool loads an account skill by plain name (`SkillTool returning 2 newMessages for skill anthropic-skills:design-system` in the `--debug-file` log).
- Skills and models unchanged.

## 0.3.0 (2026-10-10)

Fourteen skills, one milestone loop, and the first evals. Scope approved by the owner on 2026-10-10. The team learns between milestones through a retro whose proposals the owner approves; nothing edits a skill, hook or `CLAUDE.md` on its own. New sources: mattpocock/skills at 49dd158d1076134a641b33efb035946536778336 and EricTechPro/super-board at 35e215615c98fa5da011368e764f38f86959bf95, both MIT (`THIRD_PARTY.md`, `licenses/`).

- New skills: `run-retro` (scribe; turns a milestone's findings into proposals, a finding class seen twice must get one, a deterministic check preferred), `grill-the-plan` (architect; facts looked up, decisions to the owner, at most four questions a round, nothing written until the owner confirms), `slice-the-plan` (architect; vertical slices as lanes with disjoint files and named red tests, blocked-by order, expand then migrate then contract for wide refactors, owner checks the breakdown).
- Changed skills: `root-cause-debugging` (a red, deterministic, fast command first; three to five ranked hypotheses; tagged debug logs removed; no correct seam is a finding), `architecture-critique` (dependency kinds; an optional design-it-twice step only the architect runs), `hidden-failure-check` (hypotheses before the builder's report; finding classes Gap, Bug, Verification miss, Scope drift, Over-engineering, with over-engineering never blocking alone; earlier findings re-checked by id; spec and standards axes kept apart; the test-gap table; a code-smell baseline in `smells.md`), `tests-first` (tautological tests and horizontal slicing named), `release-checklist` (merge danger, merge-gate lines the owner signs, analytics events named for every new feature).
- Roles: architect preloads `grill-the-plan`, `slice-the-plan` and `architecture-critique`; scribe preloads `run-retro` and owns the loop page; spec-auditor preloads `hidden-failure-check` and adds the test-gap table to its sweep; reviewer writes hypotheses before any builder's report, labels findings by class and axis, and records the head sha it verified on. Every role in the loop points to the loop page; lane owners answer the pre-flight questions first.
- New: `workflows/milestone-loop.md`, the fourteen-stage loop from intake to watch, with pre-flight per lane, `blocked-by:` lines and a sweep at each stage start, a same-root-cause-twice cap that goes to the owner, a halt after two rounds with no progress, and the list of what the loop never does.
- New: `skills/REJECTED.md`, the candidates read and not taken, with source, commit and reason (auto-merge, the CI-budget bypass, the reviewer's authorize-to-fix clause, cards straight to ready, the never-ask decision ladder, unpinned installs, and others).
- New: `evals/`, one case per new or changed skill, run with `claude plugin eval`. How to run them is in the README.
- Models unchanged.

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
