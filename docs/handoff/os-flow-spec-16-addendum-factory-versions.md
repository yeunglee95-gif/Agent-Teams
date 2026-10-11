# Spec 16 addendum: the team's factory, versioned, in the Team room and the canvas

_From the Agent Teams session, 2026-10-11, at Jase's request. An addition to spec 16 §3.4 (Team room) and §7 (the team's loop). OS Flow's session owns where it lands, its numbering and its milestone order. Nothing here is built._

## 1. Abstract

The dev team's way of working (its stages, roles, reviews, gates and caps) is a **factory**: an agent flow the team owns. A factory has numbered versions that never change once saved. Each project uses one version, and swaps to another at a milestone boundary. The Team room's Workflow page shows the team's factory, its versions and which project uses which; editing opens the factory in the canvas, and saving makes a new version. There is one definition, two places to see it, and no second editor.

## 2. Decisions carried in

| Date | Decision | Source |
|---|---|---|
| 2026-10-11 | "A dev team factory inside our team room, like the agent flow canvas, something we can edit and decide things", that "can be edited or saved in a new version that can be swapped into any time for different projects", for example "v1 of the AI software factory is used in this project, and v2 on another project"; "or inside the canvas with a direct link from the dev team room" | Jase |
| 2026-10-11 | Both, with one source: the factory lives as a versioned agent flow, is shown and assigned in the Team room, and is edited in the canvas through a direct link | Jase approved the recommendation |
| 2026-10-11 | dev-team 0.6 adds security review in every loop, one parallel review stage, at most two fix rounds, an approver role, and auto-merge as a per-project option that is off by default | Jase, after comparing a published software factory |
| standing | The team repo is the record (R69). OS Flow reads it and proposes changes; it never edits it in place (spec 16 §4, §5.4). The owner approves every merge, send and spend, and auto-merge is only a per-project opt-in within fixed limits | spec 16, Agent-Teams |

## 3. What a factory is

- **An agent flow in OS Flow's own block language** (spec/05, spec/08): role blocks (Agent, Reviewer, Critic, Skeptic), Gate wires, Approval blocks, Loop blocks with a round cap, a parallel group with a "wait for all" join, and Person blocks for the owner. Each role block points at a team role (`teamRole: 'dev-team@<version>/<role>'`, spec 16 §4.3), so its model and skills come from the team, not the canvas.
- **Stored in the team repo**, next to the team: for example `plugins/dev-team/factories/<name>/v<N>.<ext>`, in the format OS Flow already saves flows in. Each version is immutable; a change is a new version with a one-line "what changed".
- **The stage table in `workflows/milestone-loop.md` is the factory's readable twin.** Until OS Flow can save factories to the team repo, the loop page is the source, and the board draws it (as the prototype does today). Once factories exist, the loop page is generated from the saved factory, or the factory from the page; never two hand-kept copies.
- **Project settings are not in the factory.** Auto-merge, the line cap, whether merging deploys, and the always-ask list belong to the project (its `CLAUDE.md`), because the same factory can be safe to auto-merge in one project and deploy-on-merge in another.

## 4. What a person sees

### 4.1 Team room, Workflow page

- **The factory in use, drawn as today's board**, with a version picker: "Dev factory v2 (current) · v1".
- **A Projects panel:** each project that uses the team, the factory version it uses, and when it was last swapped. For example: OS Flow → v2, lead-sources → v1, Geniotek Platform → v2. **Swap version** schedules the change for that project's next milestone boundary, never mid-milestone, and shows a diff of the two versions first.
- **Edit in canvas** opens the selected version in the canvas editor. **Compare** shows two versions side by side: added, removed and changed blocks and wires.
- **Per-project policy row**, read from the project's `CLAUDE.md`: auto-merge off or safe changes, the line cap, and whether merging deploys. It is read-only here; changing it is an edit to that project's `CLAUDE.md` through a PR.

### 4.2 Canvas

- **The factory opens as an agent flow** with the team's roles as blocks. Every edit is a draft. **Save as new version** writes `v<N+1>` with a required one-line "what changed", as a proposal (spec 16 §5.4): a PR on the team repo that the owner merges. Nothing overwrites a saved version.
- **The Flow doctor (spec/15) runs on a factory like any flow.** Dead ends, a gate with no approver, a loop with no round cap, a review that nothing waits for, and cost per run all show before saving.
- **A link back:** "Used by: OS Flow (v2), Geniotek Platform (v2)", so an editor sees who a change would reach.

## 5. Data model (sketch; OS Flow chooses the final shape)

```ts
type FactoryVersion = {
  team: string                 // 'dev-team'
  name: string                 // 'Dev factory'
  version: number              // 1, 2, 3 (immutable once saved)
  changed: string              // one line
  teamVersion: string          // the team plugin version its role blocks point at, e.g. '0.6.0'
  flow: AgentFlow              // OS Flow's existing flow shape (blocks, wires, groups, loops)
  source: { repo: string; path: string; commit: string }
  createdAt: string; approvedBy: string
}

type ProjectAssignment = {
  project: string              // 'os-flow'
  factory: { team: string; name: string; version: number }
  since: string                // when the swap took effect (a milestone boundary)
  pendingSwap?: { version: number; atMilestone: string }
  policy: {                    // read from the project's CLAUDE.md, shown read-only
    autoMerge: 'off' | 'safe-changes'
    lineCap?: number
    mergeDeploys: boolean | 'unknown'
    alwaysAsk: string[]
  }
}
```

Where the assignment lives: in the project's own repo, a line in its `CLAUDE.md` (`Factory: dev-team / Dev factory v2`), so the project, not OS Flow, records which factory it runs, in keeping with R69. OS Flow reads it.

## 6. dev-team 0.6, the factory's next version (for the board)

| Phase | Stages |
|---|---|
| Plan | Intake, grill the plan, plan and slice, design (screens only) |
| Build | Pre-flight per lane (claims), build lanes |
| Check | Gate, then one parallel review stage: spec check, black-box UX (critic), UI check (design-auditor, screens only), security review, code review; wait for all; one combined findings list |
| Fix | Fix and re-verify, at most two rounds; fixer on sonnet, stepping up to opus after one failed repair |
| Ship | Release checklist, approver (APPROVE or ESCALATE); auto-merge only where the project opts in and the change is safe; otherwise the owner's go |
| Learn | Retro (with cost view), watch |

The exact table lands with dev-team 0.6 in `plugins/dev-team/workflows/milestone-loop.md`; the board reads it from there.

## 7. Phases

| Phase | What | Depends on |
|---|---|---|
| F0 | dev-team 0.6 ships the loop changes; the Workflow board draws the parallel stage and the approver | Agent-Teams (in progress) |
| F1 | Team room Workflow page: version picker (versions = team releases), Projects panel reading each project's `Factory:` line, the policy row | spec 16 P1 |
| F2 | Canvas opens a factory as an agent flow; Save as new version becomes a PR on the team repo; Compare | canvas editing of flows (exists), GitHub write connection |
| F3 | Run a project's milestone on its assigned factory version | spec/13 runs |

## 8. Open questions

- File format for a saved factory: OS Flow's flow JSON (best for the canvas) or generated from the loop table (best for the team's evals). Recommendation: OS Flow's flow JSON as the source, with the loop table generated from it, once F2 exists.
- Whether marketing and the other department teams get factories in the same shape (likely yes; their loops already carry a Phase column).
