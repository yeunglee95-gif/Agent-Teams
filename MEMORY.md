# Agent Teams Memory

_The memory home for this repo. OS Flow reads it as Agent-Teams' memory (it is listed under OS Flow in OS Flow's `supabase/manual/business-repos.sql`). Two sentences max per entry; newest first._

## Current State

- **Versions:** dev-team 0.10.0, design-team 0.3.0 and toolkit 0.2.0, evals recorded 2026-11-01 (PR #18: 61 of 66). Details are in each team's `CHANGELOG.md`.
- **History before 2026-11-01:** decisions about this repo were logged in OS Flow's memory (repo yeunglee95-gif/OS-Flow), from the 2026-10-04 set-up entries in `ARCHIVE.md` § Decisions index to the later ones in `memory/team-and-m4.md` and `memory/forge-and-process.md`. They stay there; new decisions go below.

## Decisions

- **2026-11-12 (Jase): `caveman` joins the toolkit for shorter chat replies.** Only the core skill is copied, because the upstream CLI, proxy, hooks and cloud service are a separate product nobody asked for.
- **2026-11-12 (Jase): this repo is where every skill lives, so any new environment or AI tool installs them out of the box.** A third plugin, `toolkit`, holds general skills, starting with `watch` (claude-video) and `find-skills` (vercel-labs), each MIT and unchanged apart from a Source section; rejected installing them per app only, because each new environment would have to find them again.
- **2026-11-01 (Jase): this repo stands alone and keeps its own memory.** AGENTS.md now carries every rule its sessions need (voice, decisions, team input, action tiers, reply format, the AGENTS.md naming rule, the Codex rule), and this MEMORY.md is its memory home, which OS Flow, the brain, points to. Rejected: logging its decisions in OS Flow's memory, which made it the one repo whose memory lived somewhere else.
