# Changelog

Fork versions only; upstream's own changelog is in `README.md`.

## 0.8.6-fork.5 (2026-11-17)

- `threshold` 800000: upstream's sizing (160k, 80% of a 200k window) applied to a 1M window (Jase, 2026-11-17).
- `midTurn` (default false): past the threshold the reply finishes and the mod hands off at its end, instead of refusing the next tool call or request mid-reply. The engine's automatic compaction near the window still becomes a handoff at once. The upstream tests pin `midTurn: true`; four new fork tests: the 800k line, a reply that crosses it keeps working, the compaction guard, and a call during a handoff still refused. 90 of 90.

## 0.8.6-fork.4 (2026-11-17)

- `threshold` is upstream's 160000 again (Jase: follow the downloaded mod's number). `handoffAtCompaction` stays 0.

## 0.8.6-fork.3 (2026-11-17)

- Hands off when the context passes 200k tokens: `handoffAtCompaction` now defaults to 0 and `threshold` to 200000 (Jase, OS Flow, 2026-11-17). A 1M-token session that waits for its second compaction re-reads about 900k on every turn before it.
- A session that starts or resumes under the id it handed off from is re-armed (its `seeded:` marker is removed and the log says `re-armed`). In a cloud session the container restarts and resumes the seeded conversation under the original id, so the marker had blocked every later handoff: OS Flow's orchestrator compacted at about 900k three times (2026-11-15 to 11-17) after one handoff on 2026-11-14.
- The upstream tests are pinned to upstream's 160k line (`UPSTREAM`), the kill-switch tests included, which before ran in compaction mode and could not hand off either way. Four new fork tests: the 200k default, re-arm on resume and on startup, and no re-arm on a compaction or /clear.

## 0.8.6-fork.2 (2026-11-12)

- Moved from OS Flow (`tools/claude-mods`, branch `fix/r50-derivations` at `6b0b2234`) to Agent-Teams.
- `templates/brief.md` and `templates/instructions.md` name the project's memory file and status board, as its AGENTS.md names them, instead of OS Flow's MEMORY.md, Forge, ROADMAP.md claim board and Jase.
- The fork's code comments and test names say "Fork" instead of "OS Flow". `handoffAtCompaction` (default 2) and the viewer off by default are unchanged.

## 0.8.6-osflow.1 (2026-11-12)

- OS Flow's fork of upstream 0.8.6: `handoffAtCompaction`, the viewer off by default, the Not Yet Logged section and two fork tests.
