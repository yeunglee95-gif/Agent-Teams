---
name: forge
description: Keep a project's Forge (its build board) current, or scaffold one for a new project. Use when an ask opens or closes, a decision is made, a milestone opens, closes or changes scope, or Jase says "/forge", "update the forge", "republish the board". Also for "forge init" on a repo with no board, and "forge update" to refresh the renderer copy from this plugin's master. Live progress goes to the crew-progress status file, not the board.
---

# /forge: the one build board per project

Every build project keeps one board: `forge/forge.json` (the data, the one source) rendered by `forge/forge.html` (a copy of the master renderer) into `forge/board.html` (the page Jase reads, published as a private artifact). The master lives in this plugin's `master/` folder, two levels above this file: the contract and its rules are in `master/01 Forge Build Spec.md`, and the schema is `master/forge.schema.json`. This skill runs from inside the project repo.

## When to run it

**The board moves only for asks, decisions and milestones (Jase, 2026-11-12).** Run it the same turn that one of these happens, before replying to Jase:

- a milestone opens, closes or changes scope, including the deploy that closes one;
- a decision is made (log it in the project's memory file first, then mirror it here with a `memory_ref` copied verbatim from that entry); a term defined by Jase, a spec or a ruling is a decision, and it goes in `glossary` the same turn;
- something new needs Jase (it goes in `asks`; nothing waits on him that is not on the board);
- an ask closes (only Jase's reply or its firing default closes one; set `closed.by` accordingly, never anything else).

**Live progress goes to the crew-progress status file, not the board.** A task finishing, a lane starting or a fix landing is read from `~/.claude/state/crew-progress/status.md` (written by the `crew-progress` plugin) and quoted in chat. Work rows, `last_shipped` and the usage log catch up at the board's next move, because step 1 walks every row.

Batch the changes of one turn into one republish.

## The procedure

1. **Read the whole file first.** Open `forge/forge.json` and walk every row of `work`, every ask and every milestone against reality, not just the part you were thinking about. Appending is not updating. Look for duplicates while you are there.
2. **Edit the JSON.** Six states only: `done`, `running`, `needs-you`, `queued`, `later`, `parked`; put nuance in `label`. Keep ids stable, never reuse one. The Team room and Lined up after are derived from `work`, so there is no second list to keep; a running row sits under the Team desk whose role (or `who.role`) equals its `who.role`, otherwise under Unassigned. An ask that may carry a default gets `default: {action, fires_on}`; never on a public URL, an outbound message, money, or a client, partner or factory commitment.
   - **Who is doing it.** Every `running` or `queued` work row you have assigned carries `who: {model, role}`: the model as named today (`"Opus 5.5"`, `"Fable 5.1"`, `"Sonnet 5.5"`; for your own work, your session's model as `get_session` reports it) and the role you dispatched (`builder`, `critic`, `planner`, `screens`, `gauntlet`), or a person's name as `model` for human work. Team desks carry it too. Write it as it is now and never rename old rows when models change. It records who the work was given to; a platform fallback is not tracked.
   - **Hands-on tasks get a guide.** Every open `action` ask carries `guide: {where, time, checked, steps}`: one action per step, each with a direct `https` link to the exact page where one exists, `checked` set to the day you verified the menus and links against the real page or its current docs. Name where a secret goes, never the secret. A payment step stops at the billing page; paying is Jase's. End with how he tells you it is done.
   - **No overdue default.** At every update, an open ask whose `default.fires_on` has passed is either fired (do the action, close it with `closed.by: "default"`) or re-dated with the reason added to `why`. Re-date at most once without Jase; a second slip becomes a `now` ask to him. Before firing, recheck that the action still avoids the excluded categories above. The board flags it red until then.
   - **Words we use.** `glossary` is the project's definitions table and each term's one home; its rules (fields, one entry per term, no empty field, no English em dash, contract 1.3) are in the build spec 5.3a. If the file still says `"forge": "1.1"`, set it to `"1.3"` and run `update` before adding the first term. The project's other files link to the Forge for a term rather than restating it.
   - **Where the build is (contract 1.4).** The status panel's rules are in the build spec 5.3b; if the file says an older `forge`, set it to `"1.4"` and run `update` first. Set `project.started` once. Give every open milestone a `target` and a `ships` line, and the running one a `progress`. When the finish slips, move the old `finish.target` into `finish.previous` with `changed_on` and `why`; when a milestone slips, edit its `target` and say why in its `label` or `note`. Give every Team desk a `who.model`.
   - **Log tokens.** Add each agent run's `subagent_tokens` from its task notification to that day's `usage` entry for the model (and role), and 1 to `runs`, at the board's next move. Never a separate publish for usage.
   - **Answer in.** `project.links.chat` is this build chat's `https://claude.ai/code/session_...` link; set it once. The board shows only the top three asks unfolded, so keep `priority` honest.
3. **Stamp, regenerate, build, check, in that order.** `touch` changes the updated line that `roadmap` writes, so the order matters:

   ```
   node forge/forge.mjs touch "<session or role>" && node forge/forge.mjs roadmap && node forge/forge.mjs build && node forge/forge.mjs check
   ```

   Fix every failure `check` reports (schema, a glossary that breaks the spec 5.3a rules, roadmap drift, a decision without its MEMORY.md or ARCHIVE.md entry, a banned pattern, an ask closed by the wrong hand) and rerun. Clear its warnings too: an overdue default, an action ask without a guide, a missing `links.chat`, an empty glossary, and the 5.3b gaps (a desk without a model, an open milestone without a target, no `started`, a stale usage log). A warning about the renderer version means run `FORGE_MASTER=<this plugin>/master node forge/forge.mjs update`.
4. The ROADMAP.md block between the markers is generated; the prose around it is yours.
5. **Publish.** If the Artifact tool is available: `Artifact publish` with `file_path: forge/board.html` and `url:` the project's artifact address from `project.links.artifact`, after an `Artifact read` of that address. Always pass the url; a publish without it creates a second page. If the tool is not available, commit the files and tell Jase the board is current in the repo.
6. **Commit** `forge/forge.json`, `forge/board.html`, `ROADMAP.md` (and the memory file if a decision landed) in one commit whose message starts with `Forge:`.

## Scaffolding a new project

From the new repo's root, where `<this plugin>` is the folder two levels above this file:

```
FORGE_MASTER=<this plugin>/master node <this plugin>/master/forge.mjs init <project-id> "<Project name>" <business> <owner/repo>
```

Then fill `forge/forge.json` from the project's brief (milestones from the spec, the first asks, the first work rows), add the artifact address to `project.links.artifact` after the first publish, add the project's own patterns to `forge/banned.txt` (client names, factory names), wire `node forge/forge.mjs check` into the repo's gate, and add to the repo's AGENTS.md: "The Forge is `forge/forge.json`; run `/forge` when an ask, a decision or a milestone moves."

`init` and `update` print a warning that no SKILL.md sits beside the master: the skill comes from this plugin, so a repo with the plugin installed needs no copy. Where plugins do not install (cloud sessions), copy this `skills/forge/` folder into the repo's `.claude/skills/` from one pinned commit of Agent-Teams.

## What the board never holds

A client name or project, a factory identity or price, a finance number, a token or secret, a decision that is not also in the project's memory file, or an ask closed by an agent. Sharing the artifact with anyone is a Red action.
