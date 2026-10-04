# dev-team changelog

## 0.1.0 (2026-10-04)

First release. The ten roles come from OS Flow's `.claude/agents/` (os-flow commit 65722fdd, the M3b pilot team), made app-neutral.

- Roles: architect, owner, mechanic, gate-runner, fix-owner, reviewer, spec-auditor, critic, security-reviewer, scribe.
- Every role reads the app's own `CLAUDE.md` for its memory file, specs, gate commands, ports, action tiers and specialists, and stops to ask when the `CLAUDE.md` does not say.
- Kept from OS Flow: tests first; verify every claim of done or green against the files or a re-run; one owner per cross-cutting rule, with disjoint files; never merge, deploy or settle a red; a critic never reads the code first; the scribe never invents a number; commit in short steps.
- Removed as OS Flow-specific: file paths, lane letters, ruling numbers, OS Flow's specs, the critic personas, the n8n rubric and OS Flow's security surfaces. They stay in OS Flow.
- Models, per OS Flow's current routing while Fable's limit holds: `opus` for architect, owner, fix-owner, reviewer, spec-auditor, critic, security-reviewer and scribe; `sonnet` for mechanic and gate-runner.

To do when Fable's limit lifts: architect, reviewer, spec-auditor, critic and security-reviewer return to `fable`, as a new version.
