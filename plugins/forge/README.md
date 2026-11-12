# Forge

The one build board every project keeps, and the master of its renderer, contract and tool. **This plugin is the master from 2026-11-12 (Jase)**; it moved here from Claude OS `00_Resources/forge/` at commit `13f1038`, so any project installs it the same way as the other shared tools. The brief and the decisions behind it are in `master/01 Forge Build Spec.md`.

**Install:** `/plugin marketplace add yeunglee95-gif/Agent-Teams`, then `/plugin install forge@agent-teams`. Where plugins do not install (cloud sessions), copy `skills/forge/` into the repo's `.claude/skills/` and keep `master/` reachable, both from one pinned commit.

| File | What it is |
|---|---|
| `skills/forge/SKILL.md` | The `/forge` skill: when the board moves and the procedure a session follows that turn |
| `master/01 Forge Build Spec.md` | The brief and the decisions behind it |
| `master/forge.schema.json` | The contract, version 1.4 (1.1 added `who`, ask `guide` and `links.chat`; there is no 1.2, whose releases changed only the renderer; 1.3 adds `glossary`, with its rules in the build spec 5.3a; 1.4 adds the status and usage fields behind the Where the build is panel, with their rules in the build spec 5.3b). `forge/forge.json` in every project repo obeys it |
| `master/forge.example.json` | A complete worked example of every section |
| `master/forge.html` | The renderer, 1.4.1. Copied into each repo as `forge/forge.html`; never edited there |
| `master/forge.mjs` | The tool: `validate`, `build`, `roadmap`, `check`, `touch`, `update`, `init`, `help`. Node 22, no packages |
| `master/forge-lifecycle.mmd` | The map of where the Forge lives and how it stays current, in OS Flow's Mermaid import form (kind prefixes on the ids). `forge-lifecycle-preview.png` is a plain render of it from before the move |

**The board moves only for asks, decisions and milestones; live progress goes to the crew-progress status file** (Jase, 2026-11-12). The skill holds the full rule.

## How a project uses it

```
forge/
  forge.json         the data; the one source of status for the project
  forge.html         renderer copy (version stamp on line 2)
  forge.schema.json  copy
  forge.mjs          copy
  banned.txt         one regex per line that must never appear in the JSON (client names, factory names, token shapes)
  board.html         built page (JSON inlined); the file published as the project's private artifact
  archive/           closed asks older than 30 days
```

Refresh the copies with `FORGE_MASTER=<this plugin>/master node forge/forge.mjs update`. `node forge/forge.mjs check` runs in the repo's gate. It fails on a schema error, on a glossary that breaks the build spec 5.3a rules, on status or usage fields that break the 5.3b rules, on ROADMAP.md drifting from the JSON, on a decision whose `memory_ref` is not in MEMORY.md or ARCHIVE.md, on a banned pattern, and on an ask closed by anyone but Jase or its default. It warns (without failing) on an overdue default, an action ask without a guide, a missing build-chat link, an empty glossary, a board more than a day old, and the 5.3b gaps (a desk without a model, an open milestone without a target, no `started`, a usage log empty or over 7 days old).

## Changing the renderer or the contract

Edit the master here, bump the version comment on line 2 of `forge.html` and `RENDERER_VERSION` in `forge.mjs`, screenshot the example at 1440 and 390 in both themes, get a Fable review, then **republish the sample board** (build `forge.example.json` with the new renderer and publish it to [Forge Sample Board](https://claude.ai/artifact/2DYtfEnQnRxeByy1JNhxXe), the one place Jase sees the template before any board changes) and send Jase the link with the rollout question. Only after his "proceed" run `update` in each project repo (the `check` there warns until it is done). A contract change that adds a field is a minor bump (1.1); one that removes or renames a field is a major bump and needs a migration note. Bump this plugin's version and `CHANGELOG.md` in the same change.

## Style

Capsule, the Claude OS design system in `DESIGN.md` at the Claude OS root (renderer 1.2.0 on). The `:root` blocks carry its Day values for light and its Night values for dark, switched by `prefers-color-scheme` and `data-theme`; type is Inter Tight with IBM Plex Mono for ids and paths only, in a 1080px column. When `DESIGN.md` changes, change the `:root` blocks here to match.

## Source

Written by Jase's sessions in Claude OS (approved 2026-10-02) and moved here unchanged apart from what `CHANGELOG.md` 0.1.0 lists. Line 2 of `forge.html` and the comments in `forge.mjs` still name Claude OS as the master; renaming them changes the renderer's bytes, so it waits for the next renderer release and its review.

The branch `claude/forge-template` in OS Flow (`3f457e01`, 2026-10-05) carries renderer 1.4.0; the Claude OS master at `13f1038` carries 1.4.1, which adds each ask's and work row's id beside its title, with the same schema. 1.4.1 is the newer, so it is the one here.
