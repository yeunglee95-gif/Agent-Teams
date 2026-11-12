# Agent Teams Memory

_The memory home for this repo. OS Flow reads it as Agent-Teams' memory (it is listed under OS Flow in OS Flow's `supabase/manual/business-repos.sql`). Two sentences max per entry; newest first._

## Current State

- **Versions:** dev-team 0.10.0, design-team 0.3.0, toolkit 0.2.0, forge 0.1.0, crew-progress 0.2.0, auto-handoff 0.8.6-fork.2, cache-tax 2.4.1 and filetree 0.8.3; dev-team evals recorded 2026-11-01 (PR #18: 61 of 66). Details are in each team's `CHANGELOG.md`.
- **History before 2026-11-01:** decisions about this repo were logged in OS Flow's memory (repo yeunglee95-gif/OS-Flow), from the 2026-10-04 set-up entries in `ARCHIVE.md` § Decisions index to the later ones in `memory/team-and-m4.md` and `memory/forge-and-process.md`. They stay there; new decisions go below.

## Decisions

- **2026-11-12 (Jase): OS Flow's four Claude Code mods (`crew-progress`, `auto-handoff`, `cache-tax`, `filetree`) and the Forge move here as plugins, so any project installs them the same way; the Forge's master now lives in `plugins/forge`, and the board moves only for asks, decisions and milestones, with live progress in the crew-progress status file.** OS Flow-only paths and names were generalised and OS Flow's `install.sh` became `tools/install-plugins.sh`, which reads the marketplace; rejected keeping them in OS Flow and Claude OS, where no other project could install them.
- **2026-11-12 (Jase): `caveman` joins the toolkit for shorter chat replies.** Only the core skill is copied, because the upstream CLI, proxy, hooks and cloud service are a separate product nobody asked for.
- **2026-11-12 (Jase): this repo is where every skill lives, so any new environment or AI tool installs them out of the box.** A third plugin, `toolkit`, holds general skills, starting with `watch` (claude-video) and `find-skills` (vercel-labs), each MIT and unchanged apart from a Source section; rejected installing them per app only, because each new environment would have to find them again.
- **2026-11-01 (Jase): this repo stands alone and keeps its own memory.** AGENTS.md now carries every rule its sessions need (voice, decisions, team input, action tiers, reply format, the AGENTS.md naming rule, the Codex rule), and this MEMORY.md is its memory home, which OS Flow, the brain, points to. Rejected: logging its decisions in OS Flow's memory, which made it the one repo whose memory lived somewhere else.
