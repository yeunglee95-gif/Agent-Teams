# Forge template

_The master of the one build board every project keeps. Spec: `01 Forge Build Spec.md`. Approved by Jase 2026-10-02._

| File | What it is |
|---|---|
| `01 Forge Build Spec.md` | The brief and the decisions behind it |
| `forge.schema.json` | The contract, version 1.4 (1.1 added `who`, ask `guide` and `links.chat`; there is no 1.2, whose releases changed only the renderer; 1.3 adds `glossary`, shown as Words we use, with its rules in the build spec 5.3a; 1.4 adds the status and usage fields behind the Where the build is panel, with their rules in the build spec 5.3b). `forge/forge.json` in every project repo obeys it |
| `forge.example.json` | A complete worked example of every section |
| `forge.html` | The renderer, master copy. Copied into each repo as `forge/forge.html`; never edited there |
| `forge.mjs` | The tool: `validate`, `build`, `roadmap`, `check`, `touch`, `update`, `init`, `help`. Node 22, no packages |
| `forge-lifecycle.mmd` | The map of where the Forge lives and how it stays current, in OS Flow's Mermaid import form (kind prefixes on the ids). Also shipped as the `forge-lifecycle` seed in the OS Flow app. `forge-lifecycle-preview.png` is a plain render of it |
| `/forge` skill | `.claude/skills/forge/SKILL.md`: the procedure a session follows the turn a board moves |

## How a project uses it

```
forge/
  forge.json         the data; the one source of status for the project
  forge.html         renderer copy (version stamp on line 2); refresh with `node forge/forge.mjs update`
  forge.schema.json  copy
  forge.mjs          copy
  banned.txt         one regex per line that must never appear in the JSON (client names, factory names, token shapes)
  board.html         built page (JSON inlined); the file published as the project's private artifact
  legacy/            the old hand-written board, kept one month after migration
  archive/           closed asks older than 30 days
```

`update` and `init` also copy the `/forge` skill into the repo's own `.claude/skills/forge/`, so a session on that repo needs nothing from Claude OS. `node forge/forge.mjs check` runs in the repo's gate. It fails on a schema error, on a glossary that breaks the build spec 5.3a rules, on status or usage fields that break the 5.3b rules, on ROADMAP.md drifting from the JSON, on a decision whose `memory_ref` is not in MEMORY.md or ARCHIVE.md, on a banned pattern, and on an ask closed by anyone but Jase or its default. It warns (without failing) on an overdue default, an action ask without a guide, a missing build-chat link, an empty glossary, and the 5.3b gaps (a desk without a model, an open milestone without a target, no `started`, a usage log empty or over 7 days old).

## Changing the renderer or the contract

Edit the master here, bump the version comment on line 2 of `forge.html` and `RENDERER_VERSION` in `forge.mjs`, screenshot the example at 1440 and 390 in both themes, get a Fable review, then **republish the sample board** (build `forge.example.json` with the new renderer and publish it to [Forge Sample Board](https://claude.ai/artifact/2DYtfEnQnRxeByy1JNhxXe), the one place Jase sees the template before any board changes) and send Jase the link with the rollout question. Only after his "proceed" run `node forge/forge.mjs update` in each project repo (the `check` there warns until it is done). A contract change that adds a field is a minor bump (1.1); one that removes or renames a field is a major bump and needs a migration note.

## Style

Capsule, the Claude OS design system in `DESIGN.md` at the Claude OS root (renderer 1.2.0 on). The `:root` blocks carry its Day values for light and its Night values for dark, switched by `prefers-color-scheme` and `data-theme`; type is Inter Tight with IBM Plex Mono for ids and paths only, in a 1080px column. When `DESIGN.md` changes, change the `:root` blocks here to match.

OS Flow takes the full Capsule look too, with the local choices DESIGN.md records for it (Jase, 2026-10-04).
