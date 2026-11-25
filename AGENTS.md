# Agent Teams: rules for this repo

This repo is a Claude Code plugin marketplace; what it holds and how apps use it is in `README.md`. These are the rules for any agent or person changing it.

## Repo rules

- A team moves to its own repo only when someone outside needs access to that team alone (GitHub access is per repo).
- Business knowledge is linked, never copied. It stays in each business's own repo and Notion.
- No credentials anywhere in this repo.

## Standing rules

- **The rules file is AGENTS.md, never CLAUDE.md (Jase, 2026-10-31).** A `CLAUDE.md`, `CLAUDE.local.md` or `.claude/CLAUDE.md` in this repo or a folder above it makes Claude ignore AGENTS.md, so never create one, including through `/init`.
- **Codex and any other non-Claude agent read this same file (Jase, 2026-11-01).** Follow every rule here. Skip only the steps that name a Claude-only tool (skills, the Agent tool, model aliases such as `fable` or `opus`), and do the step's intent with your own tools.
- **Decisions (Jase, 2026-11-01).** Log every decision in `MEMORY.md` § Decisions the turn it is made: date, who, what was chosen, what was rejected, why, in two sentences at most.
- **Team input.** Never delete or overwrite a teammate's content without Jase's instruction; version on top instead, keeping the original labelled as the prior version.
- **Action tiers.** Green: read, diagnose, draft, write or change roles and skills, run evals, commit and push a working branch. Red, which waits for Jase's explicit "proceed" each time and never batches: merge or push to `main` (apps copy pinned commits of it, so a merge releases a team version), except a merge Review by risk allows; tags; anything that spends money, shares a URL or reaches the team.

- **Review by risk (Jase, 2026-11-25).** Every change merges through a pull request, and its tier decides who says yes. Name the tier in the pull request and in the reply that reports it.
  - **Agent only: merge once its checks pass, then report the pull request link in that turn's reply.** Every changed file is one of these, and the change is under 400 changed lines, not counting tests and eval cases:
    - Text that records what was already decided: `MEMORY.md`, a `CHANGELOG.md`, a README or a doc.
    - A role or skill edit whose eval cases all pass in the same change: its own cases and those of every role that loads it, with the results in its `CHANGELOG.md`.
    - A Forge tool or renderer fix whose tests all pass and which keeps the contract version and every rule Jase set.
  - **Jase:** everything else, and always:
    - A change to the action tiers, the standing rules or this list.
    - A change to what any role may do about merging, sending, spending, publishing or live data.
    - A new plugin, role or third-party code (its licence).
    - Removing a skill, role or plugin, or a model routing change.
    - A new Forge contract version, or a change to what the board shows Jase.
  - **Two people:** nothing in this repo has money or legal effect beyond licences, which Jase reviews.
  - **The first time an agent-only merge breaks something** in an app, that kind of change moves to Jase, logged in `MEMORY.md`.

## Editorial rules

Voice, for everything written here, by anyone (Jase, 2026-11-01):

- Write like a clear, thoughtful colleague talking to a smart friend: professional, not stiff. Key point first, then the context.
- Vary sentence length, and join ideas with "so", "because" and "for example" rather than stacking fragments. Do not open a direct statement with "I think" or "I believe".
- Never use: dive into, game-changing, straightforward, leverage, synergize, circle back, touch base. No em dashes; use commas, colons or periods.
- One idea per paragraph, 1 to 3 sentences each. Bold the key points. Bullets for lists, prose for explanations.
- In files that are read again, write only what changes what the reader does or knows: state a fact once, add no "not X" for an old version nobody still believes, and link rather than restate what another file holds.

## Response rule

Lead every substantial result with a two-to-four-sentence abstract of the outcome. End every response with "Next actions": the next three things only. Jase's decisions come first, each with its options, a recommendation, and the reasoning as bullet points; then the work being carried on.
