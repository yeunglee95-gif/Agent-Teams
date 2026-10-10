# 16 Team setup, team room and skill board

_Draft from the Agent Teams session, 2026-10-10. Jase approved the four decisions in §11 the same day. Not yet in the os-flow repo; the OS Flow session owns where it lands and its number. Builds on spec/05 (an agent's "What it may use", `skills?: string[]`), spec/09 (read-back), spec/10 (Forge desk, Needs you), spec/13 (runs, versions, connectors named not configured) and spec/15 §5 (learning reviewed before it ships). References read this session: EricTechPro/super-board at `35e21561` (2026-10-08, MIT), mattpocock/skills at `49dd158d` (2026-10-09, MIT), Agent-Teams `plugins/dev-team` 0.2.0. Nothing here is built._

## 1. Abstract

Each department has one shared agent team (dev, marketing, and later finance, sourcing, ops) that serves every business; each business supplies its own knowledge pack at run time. The **Team setup** page shows a team's roles, the skills each role loads and where every skill came from, and lets an owner edit them by hand or switch on **Automatic**, where a scout finds candidate skills, screens and adapts them, and puts each one on the owner's desk as a proposal. The **Skill board** is a drill-down map of the same team, modeled on super-board's skill map but with the license, source commit and approval state super-board's map lacks. The team gets better over time through a retro after every milestone and a monthly upstream check, and every change ships as a new pinned team version only after the owner approves it. The team's repo stays the one home for every fact; OS Flow reads it and proposes changes to it, never edits it in place.

## 2. Decisions carried in

| Date | Decision | Source |
|---|---|---|
| 2026-10-04 | One team per department shared across businesses; business knowledge per business | Jase, research brief |
| before 2026-10-10 (Agent Teams session) | "Less is better": few agents, great skills and context. Copy outside skills with attribution, never install them blind | Jase, dev team review |
| before 2026-10-10 (Agent Teams session) | Dev team 0.2 line-up approved (10 roles, 11 skills), merged as Agent-Teams PR #1 | Jase |
| before 2026-10-10 (Agent Teams session) | "Inside the OS flow should have this team set up area where they can set up or edit skills for the team members, or they can chose automatic then our AI will match them or find the right skills using /find-skills" | Jase |
| before 2026-10-10 (Agent Teams session) | "The dream team is to be able to find skills that is the best fit… or they can learn from our own skills by everyday tasks" | Jase |
| 2026-10-09 | Dashboards and approval panels modular for any business, campaign type and location | Jase, cold email plan |
| 2026-10-10 | "We can have a skill board/map like that inside our OS flow"; the dev team should have a loop that "reviews itself and gets better by time", fits many projects, and takes in tools such as PostHog | Jase |
| standing | Owner approves every merge, every send, every skill change. Reviewer never fixes. Critic never reads code first. Credentials live with the harness, never in a flow (spec/13). A graph of a real system is read from that system and cites its files (R69) | Jase's rules, spec/13, spec/00 |

## 3. What a person sees

### 3.1 Team setup page

Reached from the Forge page's Teams shelf and from any agent block whose team is linked. One page per team.

- **Header.** Team name, department, the pinned version in use (for example `dev-team 0.2.0 @ 68fe6434`), the source repo, and a **Mode** switch: Manual or Automatic (§5).
- **Roster.** One card per role: name, one-line job, model, tools it may use (read-only roles marked), and its skills as chips. A chip shows the skill name and a small source tag (own, or the creator's GitHub login for an adapted skill). Clicking a chip opens the skill's detail (§3.3).
- **Businesses using this team.** Each business that runs the team, with its knowledge pack (brief, brand pack, approval rules, glossary) linked, and which projects or flows use it. The team is shared; the packs are not.
- **Proposals.** Pending changes for this team (new skill, skill edit, retire, role change), each with its evidence and an Approve / Edit / Reject row. The same items sit on the owner's Forge desk under Needs you (spec/10).
- **History.** Team versions with date, what changed and who approved, and a **Roll back to this version** button that pins the older version (spec/13 §7 promote and roll back).

Editing by hand: add a skill to a role, remove one, reorder, write a new skill from a template, or retire a role. Every edit becomes a proposal like any other (§5.4), so a hand edit and an automatic one take the same path to the repo. Nothing is saved straight into a running team.

### 3.2 Skill board

A map of the team, rebuilt from the repo on every read. Copies super-board's interaction ideas (drill-down views, What / When / How / Links details, author tags, deep links, search), not its page code.

- **Root view.** The team's roles, and the loop they run (§7) as one flow from intake to owner go.
- **One view per role.** Its preloaded skills, the tools it may touch, who hands it work and who it hands to.
- **One view per source creator.** Every skill adapted from obra/superpowers, mattpocock/skills, addyosmani/agent-skills, EricTechPro/super-board, Anthropic plugins, and our own, so Jase sees what he owes whom.
- **Candidates view.** Skills the scout found, with their screening result, including rejected ones and why (so the scout does not propose them again).
- **Across teams view** (once marketing exists). Skills more than one team loads, which are candidates for a shared skill shelf.

Node click: neighbours stay lit, the rest dims, details open with tabs **What · When · How · Source · Used by**. Source shows license, repo, commit, the path adapted from, and the one-line "what we changed". Deep link `#team=<id>&view=<id>&node=<id>`. Phone: details as a bottom sheet. Export: PNG and the map JSON.

### 3.4 Team room (Jase, 2026-10-10)

Jase: the skill board and the agent teams board live together in OS Flow as one place "where they sit and rest when they are not in use and also shows who is on roster, pick up a skills/cup/something when they go to work, that how it should looks like in animation. But if it is an interface, make it using the capsule design system."

Name: **Team room**, the name Capsule already gives this section of the Forge board (docs/design/CAPSULE-DESIGN.md, Components, Team room). Using it avoids a second name for the same thing. Jase offered hub, living room, break room, staff lounge, tea room and common area; any of them can replace it with a one-word change.

One page per team, two layers:

- **The room (the page's one picture, like the Forge board's wafer map).** Three zones: **Resting** (seats, one per role, plus a tea counter), the **Skill shelf** on the back wall (one cup per skill, labeled), and the **Work floor** through a doorway (a desk per running role). An agent called to work stands, walks to the shelf, picks up a cup for each skill its role preloads (copies; the shelf keeps one of each), goes through the door and sits at a desk with its cups. Called back, it returns its cups and sits down again. An agent waiting on the owner keeps its desk and wears the coral needs-you mark (the One Signal Rule: coral only there). Each agent shows its state mark beside its head (Shape Twin Rule), so the room reads without color. Picking an agent lights its cups on the shelf; picking a cup lights every agent who carries it.
- **The interface (Capsule).** Under the room: **On the roster**, one row per role (state pill, role, model chip, what it is doing now, its skills as chips; needs you first, then at work, then resting dimmed, never folded away; Jase's own desk is not listed, Needs you is his desk), and **Skill shelf**, one row per skill (source creators, license, pinned commit, how many roles load it, how many cups are out). Rejected candidates and the loop stay as tabs or links from the shelf (§3.2).

**Motion.** Real state changes drive it; nothing walks for decoration. The walk is the one exception to Capsule's under-300ms rule, because it shows a real transition; each cup's flight stays at 200 to 240 ms. Under reduced motion every agent jumps to its new place and the rows carry the change. Motion never carries information on its own: the rows say everything the room shows.

**Data.** Roles, skills and cups come from the team repo at its pinned commit (§4); states come from runs (spec/13) once real runs exist. Until then the room shows example states and says so.

**Prototype.** `docs/handoff/team-room-prototype.html` on this branch, generated from dev-team 0.3.0 at d111723e by `docs/handoff/skill-board/gen.py` with `teamroom-template.html`. It is a design reference built with Capsule tokens, not OS Flow code; OS Flow builds its own in its stack.

### 3.3 Skill detail

The skill's own text rendered read-only, its `## Source` block, the roles that load it, its evals and their last result (§6.3), the runs in which it was loaded (once real runs exist), and open proposals that touch it. **Propose an edit** opens the text in an editor whose save is a proposal.

## 4. Data model

The repo is the record. OS Flow keeps a derived index, regenerated from the repo at a pinned commit and never hand-edited (one home per fact).

### 4.1 Where each fact lives in the team repo

| Fact | Home |
|---|---|
| Role, model, tools, preloaded skills | `agents/<role>.md` frontmatter (`skills:` list) |
| Skill text | `skills/<name>/SKILL.md` |
| Source, license, commit, what changed | the skill's `## Source` section, mirrored in `THIRD_PARTY.md`; license texts in `licenses/` |
| Team version | `.claude-plugin/plugin.json` `version`, `CHANGELOG.md` |
| Evals | `evals/<skill>/` (new, §6.3) |
| Rejected candidates | `skills/REJECTED.md` (new): name, source, commit, reason, date |
| The loop the team runs | `workflows/milestone-loop.md` (new, §7) |

### 4.2 The derived index (`TeamMap`)

Same three collections as super-board's `diagrams/skill-map.json` (nodes, edges, views), so its layout ideas carry over:

```ts
type TeamMap = {
  team: { id: string; name: string; department: string; version: string;
          repo: string; commit: string; readAt: string }
  nodes: TeamNode[]
  edges: { id: string; from: string; to: string; label: string; when?: string }[]
  views: { id: string; parent?: string; title: string; caption?: string;
           nodeIds: string[]; layout?: Record<string, [number, number]> }[]
}

type TeamNode = {
  id: string
  kind: 'role' | 'skill' | 'stage' | 'tool' | 'connector' | 'candidate'
  label: string
  what: string; when?: string; how?: string
  source: string[]                 // repo paths this node was read from (R69)
  // skills and candidates only:
  author?: string                  // GitHub login, or 'own'
  license?: string                 // SPDX id
  sourceRepo?: string
  sourceCommit?: string            // full 40-character sha, never a branch
  adaptedFrom?: string             // path in the source repo
  changed?: string                 // one line: what we changed
  usedBy?: string[]                // role ids that preload it
  status?: 'in-use' | 'proposed' | 'candidate' | 'rejected' | 'retired'
  rejectedBecause?: string
  evals?: { name: string; lastResult?: 'pass' | 'fail'; at?: string }[]
}
```

Fields super-board's map does not have and we need: `license`, `sourceCommit`, `adaptedFrom`, `changed`, `usedBy`, `status`, `source` paths. Its gaps (four outside skills with no author, unpinned Matt Pocock installs, a removed skill still on the map) are exactly what these fields and a regenerate-from-repo rule prevent.

A read that finds a skill without a `## Source` section, a source with no license file, or a `skills:` entry naming a skill that does not exist shows it as a **map issue** on the board, the same way the Issues panel shows flow errors.

### 4.3 Link to spec/05

An agent block in a flow can point at a team role (`teamRole: '<team>@<version>/<role>'`). Its `skills` then come from the role and show as read-only chips in Details, with **Open in Team setup**. A block may still add its own skills on top, as today. `compileRun` turns each into `skill:<name>` exactly as spec/05 says.

## 5. Manual and Automatic

### 5.1 Manual

The owner edits through §3.1. Each save is a proposal (§5.4).

### 5.2 Automatic: what it does and does not do

Automatic means the team looks for better skills on its own and **proposes**. It never installs, never edits the repo, never changes a running team. This is the same line super-board draws in practice (its follow-up work lands in Backlog for a human), minus its exceptions that skip the human.

### 5.3 The scout pipeline

Runs on a schedule (monthly by default) and on demand from a role card (**Find skills for this role**).

1. **Need.** What to look for comes from evidence, not browsing: retro findings that repeat (§6.1), a role whose finding tally shows the same miss twice, a new tool the team must use (a PostHog connector, say), or the owner's request.
2. **Scout.** `/find-skills` and named sources the owner trusts (the creators already on the board first). Returns candidates with repo, path and commit.
3. **Screen.** A fixed rubric, recorded per candidate: license (permissive or not usable); activity (last commit, maintainers); fit to the team's rules (does it merge, deploy, edit itself, skip the owner, read code before a black-box check: each a hard reject or a part to strip); overlap with skills we have (extend ours rather than add a near-duplicate); size (does it earn its context cost). Rejects go to `REJECTED.md` with the reason.
4. **Adapt.** Rewrite to our voice and rules, pin the commit, write `## Source` and `THIRD_PARTY.md`, add the license text if new. Never vendor a whole pack.
5. **Check.** `claude plugin validate`; a load check that the role really preloads it; the skill's eval (§6.3) plus the evals of every skill it touches. A candidate without a passing eval is not proposed.
6. **Propose.** A Needs you card on the Forge desk: what it adds, the evidence that prompted it, the diff, the eval result, the license. Approve opens a PR on the team repo.
7. **Ship.** The owner merges; the team version bumps; OS Flow re-reads and the board updates. Flows pinned to the old version keep it until promoted (spec/13 §7).

### 5.4 Proposals

One shape for hand edits, scout finds and retro items: `{ kind: add | edit | retire | role-change, target, diff, evidence[], evals, license?, proposedBy, createdAt }`. One approve path: owner approves in OS Flow, OS Flow opens the PR through the team repo's GitHub connection, the owner merges (or approves the merge from the desk once M5 can), the board re-reads. Rejecting asks one line of why, which the scout reads next time.

## 6. Learning loop

What "gets better over time" means here, and what it does not. super-board's own code has no step where agents rewrite their skills; its improvement is review memory, findings filed as new tickets, a scan of its own merged PRs for repeated misses, and the author's post-mortems and evals, all approved by a person. We copy that shape and keep the person in it.

### 6.1 Retro after every milestone

A new skill `run-retro` (adapted from mattpocock `retro`), loaded by the scribe. Input: the milestone's reviewer finding tables, fixer tables, gate failures, critic reports and the owner's rejections. Output: a proposal list, each item one of: a new automated check (preferred: "a mechanical miss gets a deterministic check"), a skill edit, a CLAUDE.md line, or nothing. A finding class seen twice across milestones must produce a proposal. Items go to §5.4.

### 6.2 Upstream check, monthly

For each adapted skill, compare its pinned commit with the source's head. Changed: summarize the diff and propose an update, or record "reviewed, no change". Gone or relicensed: flag it. This is the drift super-board's own map already shows against Matt Pocock's repo.

### 6.3 Evals, so a change is proven not guessed

Each skill that changes behaviour gets at least one eval (a small fixed task and a grader), run with `claude plugin eval`, as super-board does for review memory, over-engineering and test gaps. A skill edit runs its eval and the evals of every role that loads it. A proposal shows before and after. This is the guard against a "better" skill that quietly makes the team worse.

### 6.4 Learning from our own work, across businesses

Patterns only, never one business's data (spec/15 §5): a retro on Geniotek's cold email migration may propose a skill edit; it may not copy Geniotek's brief into the team.

## 7. The team's loop, for any project

One loop the dev team runs on every project, written once in the team repo (`workflows/milestone-loop.md`, owned by the scribe) and drawn in OS Flow as an agent flow template that Start a build (spec/15) can drop into any business. It generalizes OS Flow's own `routine/BUILD_LOOP.md` and the Geniotek Platform's loop, so each project stops carrying its own copy.

| # | Stage | Who | Gate to move on |
|---|---|---|---|
| 0 | Intake | owner, or the collect step (§8) filing to Backlog | owner moves it to Ready |
| 1 | Grill the plan | architect with `grill-the-plan` (new, from mattpocock `grilling` + `domain-modeling`) | owner confirms no open decisions |
| 2 | Plan and slice | architect with `slice-the-plan` (new, from `to-tickets`) and `architecture-critique` (adds design-it-twice) | reviewer's plan critique answered |
| 3 | Pre-flight per lane | owner role, checklist from super-board's pre-flight: already done, overlapping files with another lane, spec unclear, too big | each lane proceeds, holds with a `blocked-by:` line, or is sequenced |
| 4 | Build lanes | owner role, tests first, one worktree and branch per lane | lane's named red tests now green |
| 5 | Gate | gate-runner: the project's own lint, typecheck, tests, build | all green on a fresh run |
| 6 | Spec check | spec-auditor, with super-board's test-gap table (each spec row to its test, or none) | no High gaps open |
| 7 | Black-box check | critic, screens and evidence only | report filed |
| 8 | Review | reviewer: writes its own 2 to 4 guesses from spec and diff before reading the builder's report; labels findings Gap, Bug, Verification miss, Scope drift, Over-engineering; re-checks its earlier findings | no blocking findings |
| 9 | Fix and re-verify | fixer, then reviewer's verified-fixed table | same root cause twice stops at the cap and goes to the owner |
| 10 | Release check | gate-runner with `release-checklist` (as built in dev-team 0.3.0): reviewed head is the merged head, base merged in and gate green on it, one-way or two-way door call, analytics events named for any new feature | owner signs |
| 11 | Owner go | **Jase** | merge or deploy |
| 12 | Retro | scribe with `run-retro` | proposals on the desk (§6.1) |
| 13 | Watch | the collect step reads PostHog and errors for the shipped change (§8) | findings filed to Backlog, never to Ready |

Per project, everything project-specific comes from the project's CLAUDE.md (commands, owner, protected paths, what never ships without approval), as the 10 roles already read it. super-board's per-project config and managed AGENTS.md block show the same pattern. At every stage start, blocked items whose `blocked-by:` closed go back in. Halt after two rounds with no progress and say why.

What the loop never does, though super-board does: merge on its own, merge when CI failed to start, file follow-up work straight into Ready, let a lane decide a judgement call without asking, let the reviewer patch code, or install outside skills unpinned.

## 8. Tools and connectors (PostHog and others)

Tools are named in the team and configured with the harness (spec/13: credentials with the harness or Cloudflare secrets, never in a flow or the team repo).

- **PostHog**, read-only key per business. Uses: the Watch stage (errors, rage and dead clicks, web vitals, funnel drop on the changed screens, as super-board's `collect_posthog.py` reads them with HogQL); the release check's "every new feature names its events"; and a tracking-gap finding when a shipped screen sends nothing. Findings file to Backlog with a fingerprint to avoid duplicates; the owner moves them on.
- **Sentry or the project's error log**, the same way.
- **GitHub**, for PRs, the board's state and proposals.
- **Figma or the design hand-off** (spec/09), for the critic's designed-vs-built check.

A tool used by more than one team or project appears once on the skill board with everything that uses it, like spec/15's tool cards.

## 9. Modular panels

The Team setup page, the Skill board and the proposals list are panels with one contract: they take a team id and an optional business id and render from the index. The same panels serve the dev team today and marketing, finance and sourcing teams later; a business sees its own packs and runs, never another's. This is the same rule as the cold email approval panels (2026-10-09): built once, filled per business, location and campaign type.

## 10. Phases

| Phase | What | Depends on |
|---|---|---|
| P0 | In the team repo: `run-retro`, `grill-the-plan`, `slice-the-plan`, the skill edits in §7, `workflows/milestone-loop.md`, `skills/REJECTED.md`, a first eval per changed skill. Ships as dev team 0.3 | Jase's go on scope; nothing in OS Flow |
| P1 | Read-only Skill board and Team setup in OS Flow, built from the repo at a pinned commit; map issues shown | spec/09 read-back of a repo |
| P2 | Proposals: hand edits and retro items become desk cards and PRs | Forge desk (spec/10), GitHub write connection |
| P3 | Automatic: the scheduled scout and the monthly upstream check | real runs (spec/13 phase 3) or a scheduled harness job |
| P4 | Edit and approve fully inside OS Flow, the loop as a runnable agent flow, PostHog Watch live | M5 machine interface, spec/13 runs |

P0 and a static version of P1 (a generated page from the repo, outside OS Flow) can happen now; neither waits on M4 or M5.

## 11. Decisions (approved by Jase, 2026-10-10)

1. **Scope of dev team 0.3** (§7 and P0). Recommended: three new skills (`run-retro`, `grill-the-plan`, `slice-the-plan`), the edits (debugging tight loop, design-it-twice, reviewer guesses-first and finding labels, test-gap table, merge-gate lines in the release checklist) and the loop page. Consequence: the team grows from 11 to 14 skills, no new roles.
2. **Automatic mode default.** Recommended: off per team until P3, then on as propose-only. Consequence: nothing reaches the team without your approval either way.
3. **Where the spec lands.** Recommended: hand this draft to the OS Flow session to number and fit to its spec set. Consequence: OS Flow's orchestrator owns it from there.
4. **Static skill board now.** Recommended: yes, a generated page from the Agent-Teams repo after 0.3, so you can see the map this month. Consequence: about half a day; replaced by P1 later.

## 12. Open questions

- Which outside sources the scout may search beyond the creators already on the board, and whether `/find-skills` results from unknown authors are shown at all.
- Whether marketing and dev share one skill shelf for general skills (verify-before-done, decision-record) or keep copies per team.
- Who may approve proposals once there are members (spec/04 roles): owner only, or a team lead per department.
- How evals for non-code teams (marketing copy, finance) are graded.
