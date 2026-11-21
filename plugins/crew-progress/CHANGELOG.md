# Changelog

## 0.2.1 (2026-11-21)

- The design team's new `design-critic` wears the critic's costume in the design team's violet.

## 0.2.0 (2026-11-12)

- Moved from OS Flow (`tools/claude-mods`, branch `fix/r50-derivations` at `6b0b2234`) to Agent-Teams.
- Codex's session logs and the status file are found under the user's home (`HOME`, or `USERPROFILE` on Windows) instead of a fixed `/root`, so the mod works for any user. `tests/paths.test.ts` checks both.
- The README describes this fork instead of upstream savvy-progress, and says every new role gets a costume.

## 0.1.0 (2026-11-12)

- OS Flow's fork of savvy-progress: Codex tasks and ChatGPT plan limits beside Claude's subagents, role costumes, the status file at `~/.claude/state/crew-progress/status.md`, and `/crew`.
