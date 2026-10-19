# Floki, teams and agents

_From the Agent Teams session, 2026-10-19, at Jase's request. A draft for OS Flow: it extends spec 11 (AI Edit), spec 12 (Ask AI), spec 13 (Run agent teams), spec 15 (Start a build) and spec 16 (Team room). OS Flow's session owns where it lands, its numbering and its milestone order. Nothing here is built. Section 11 lists what Jase still has to decide._

## 1. Abstract

Floki is the front door to OS Flow and its flow engineer. He does the frequent, quick jobs himself (edit a flow, answer about it, check its structure) and hands long jobs to specialist agents behind him. Every agent, Floki included, works in one of two modes: **design mode** (proposes changes in the app; acts on nothing) and **run mode** (does business work inside a flow, with only the tools that flow grants). Live work is routed between teams by the flows' own rules, run by the run engine, never by a model's judgment. Skills are standard SKILL.md folders (the open Agent Skills format), so one skill works in Floki, in agents running on Claude or OpenAI, and in Claude Code. A business picks an industry and answers a few questions; a preset of default teams appears, drawn from one catalog, each team editable and forkable.

## 2. Decisions carried in

| Date | Decision | Source |
|---|---|---|
| 2026-10-18 | Floki is "the expert of creating workflow, diagnosing, building agentflow"; skills are defined before any are installed | Jase |
| 2026-10-18 | Floki is the front door and owns quick jobs; long jobs go to specialists behind him; live routing between teams belongs to the flows and the run engine, not to Floki | Jase agreed to the recommendation, with the build/run question below |
| 2026-10-19 | Teams, agents and sub-agents are defined in one table (section 3); a team has one lead | Jase asked; this draft proposes |
| 2026-10-19 | Industry presets of default teams, built from one catalog and from vetted outside skills | Jase |
| 2026-10-19 | Skills: a loader inside Floki; the Agent SDK for run mode; one SKILL.md library for both (section 7) | Jase agreed to draft it this way |
| standing | Floki never decides a gate and only starts, pauses or stops runs behind a confirm card; his edits are drafts | spec 13 §6.6 |
| standing | The owner approves every merge, send, spend and publish | spec 16, Agent-Teams |

## 3. Definitions

| Term | What it is | Example |
|---|---|---|
| **Floki** | OS Flow's own assistant: the front door and flow engineer. One per workspace; belongs to no team | "Add an approval before the email goes out" |
| **Team** | A group with one purpose, one **lead**, shared knowledge and a default way of working (its factory, spec 16 addendum) | Marketing team |
| **Agent** | One role with a job, a model, skills, tools and knowledge. It is either a team's **lead** (plans, assigns, combines) or a **member** (does one kind of work). Leads and members are both agents | Marketing strategist (lead); Video editor (member) |
| **Sub-agent** | A temporary helper an agent starts for one task and drops when it is done. It has no standing identity, is not listed in the Team room and owns nothing | The video editor starts three helpers to cut three lengths of one clip |
| **Skill** | A reusable know-how package an agent loads when a task calls for it: a SKILL.md folder (section 7) | "Short-form video hooks" |
| **Tool / connector** | Access to an outside system, granted per flow | Shopify, Meta Ads, Gmail |
| **Knowledge (brain)** | What agents can look up: sources, their structure and how they are retrieved | Product catalog, brand voice, past campaigns |
| **Flow** | A defined process that runs agents and tools, with gates | "New product launch" |
| **Gate** | A step where a person approves before the flow goes on | "Approve ad spend over $500" |
| **Run** | One execution of a flow, pinned to the versions of everything it uses | Launch run #41 |
| **Mode** | Design (in the app, proposes) or run (inside a flow, acts through granted tools) | Section 5 |

Two rules follow from the table:
- **One lead per team.** Several orchestrators in one group produce competing plans. The lead plans and combines; members do the work.
- **Members are standing; sub-agents are not.** A role someone will want to see, improve and reuse is a member. Spec 15's "crew" is a team in these terms; OS Flow should use one word, **team**.

## 4. Who does what

| Who | Design mode (in the app) | Run mode (inside flows) | Can act on the world | Decides gates |
|---|---|---|---|---|
| **Floki** | Edits flows (Change), answers about them (Ask), runs the structural Flow doctor, suggests tools, hands long jobs to specialists | Does no business work; may start, pause or stop runs behind a confirm card | No | Never |
| **Architect team** (Interviewer lead, Researcher, Architect) | Builds a whole flow from a goal, after an interview; returns it as Floki change previews (spec 15) | No | No | No |
| **Business consultant** | Reviews whether a flow serves the business goal: wrong process, missing step, a better route | Can run as a reviewer step inside a flow | No | No |
| **Knowledge architect** | Designs the brain: sources, structure, retrieval, freshness rules | Runs upkeep flows (re-index, freshness checks) | Only through tools the flow grants | No |
| **Team designer** | Creates teams, agents and skills in the Team room; sizes teams | No | No | No |
| **Business teams** (marketing, sales, support, operations, by preset) | Suggest changes to their own team, which the owner approves | The main workers | Only through tools the flow grants | No |
| **Run engine** (code, not an agent) | None | Routes work between steps and teams by the flow's rules; executes granted tools | Yes, as the flow grants | No; it waits at every gate |
| **The owner** | Approves every build and every change to a team | Approves at gates | Yes | Always |

**The structural doctor and the business consultant are different jobs.** "Is the flow built right?" (dead ends, error paths, a gate nobody can approve, an uncapped loop, cost) is engineering and stays with Floki, after the free deterministic checks. "Does the flow serve the business?" is the consultant's.

**Floki routes conversations; flows route work.** Handing a chat to a specialist is Floki's job. Moving live business work between teams is the flow's, so it is predictable and every decision is in the run's record.

## 5. Design mode and run mode

One agent definition (job, skills, knowledge, model, way of working) serves both modes. What differs is what it may touch.

| | Design mode | Run mode |
|---|---|---|
| Works on | Drafts of flows, teams, knowledge structure | Real tasks: leads, orders, posts, files |
| Acts on the world | No; it proposes, and the owner applies | Yes, only through the tools the flow grants |
| Output | A change preview | Results, at gates |
| Context | The canvas, specs, notes | The run's inputs and the knowledge it is pointed at |
| Judged by | Whether the build is sound | Outcomes and cost per run |
| Version | The latest draft | Pinned (`team@version/role`, spec 16 addendum §5); a run never changes mid-flight |

**Why share the definition:** one place to improve a skill; the agent that designed a step knows how it behaves when it runs; a third as many definitions to keep.

**Why separate the modes:** a design-mode agent with send or spend tools is one bad prompt from acting on a draft; runs must pin versions; build context is large and runs should be narrow; when something fails, the record must show whether the design or the run was wrong.

**A third place to run:** building a new app outside OS Flow uses the same role definition in Claude Code (the dev-team plugin), with its own permissions there.

## 6. Floki's jobs

| Job | Today (code) | Next |
|---|---|---|
| **Change**: turn a request into a change set; draft a whole flow on an empty canvas | `domain/aiEdit/editPrompt.ts`, `propose_changes` | Draft archetypes (section 8); error paths wired by default in unattended flows |
| **Ask**: answer with cited blocks, at most one suggested change | `askPrompt.ts`, `answer_question` | Optional follow-up questions tied to specific claims |
| **Flow doctor**: deterministic checks, then an AI review with findings and tool cards | `domain/flowDoctor/`, `doctorPrompt.ts`, `report_findings` | Severity tiers (must, should, nice); a false-positive rule so it does not cry wolf; reruns on real runs' costs and failures (spec 15 §4 "Not yet") |
| **Suggest a tool for a step** | Doctor rule 10 | Tool descriptions judged by a written rubric |
| **Sketch a tool card** | `sketchPrompt.ts`, `draw_sketch` | Unchanged |
| **Hand off** | None | A visible handoff ("Handing this to the Team designer"), one click to undo; the specialist's result comes back as a Floki change preview |

**Routing.** Today `flokiRoute.ts` routes by regex, and its misroute is the current release hold (R6-E-1: "When…" flow descriptions routed to Ask). The router becomes a small classifier call that returns one of: change, ask, doctor, sketch, or hand off to a named specialist, with its reason shown when it hands off. The selected Change mode always wins over the classifier.

## 7. Skills

### 7.1 Why Floki cannot load skills today

Skills are a feature of the harness around a model, not of the model. A harness lists each skill's name and description, gives the model a way to load the full text when a task needs it, and (for skills with scripts) a filesystem to run them. Floki is one model call with a system prompt, one strict output tool and the messages, so there is nothing to list or load from.

### 7.2 One format: SKILL.md

Every skill in OS Flow is a folder with a `SKILL.md` (frontmatter `name` and `description`, then instructions), plus optional `references/`, `scripts/` and `assets/`. This is the open Agent Skills standard (agentskills.io). Anthropic's API and Claude Code read it; OpenAI's API and Agents SDK read it too (their docs: "Skills are compatible with the open Agent Skills standard"). One skill therefore works in Floki, in specialists and business agents on Claude or OpenAI, and in Claude Code.

**Portability rule:** a skill made of instructions and references works everywhere. A skill that runs scripts needs a sandbox (a code-execution container or an Agent SDK workspace) and works only where one exists. Catalog skills are instruction-only unless they say otherwise in their frontmatter.

### 7.3 How each place loads them

| Where | How it loads skills | Models | Why this way |
|---|---|---|---|
| **Floki** (design mode, quick turns) | A loader we write: the server lists skill names and descriptions in the prompt and includes a skill's full text by route (the doctor always gets the review skill) or when Floki asks with a `load_skill` step | Any, including the OpenRouter fallback | No container and no added delay; keeps one structured answer per turn |
| **Specialists and business agents in run mode, on Claude** | The Claude Agent SDK, which loads SKILL.md folders as Claude Code does; OS Flow's bridge (`app/bridge/claude.ts`) already runs it | Claude | Long jobs with tools and files |
| **The same agents, on OpenAI** | The OpenAI Agents SDK's sandbox Skills capability (a local skills directory, loaded lazily with `load_skill`), or the Responses API's `shell` tool with skills attached | OpenAI | Same skill folders; the business chose OpenAI |
| **Any other model** (DeepSeek and others via OpenRouter) | The same loader as Floki's, with OS Flow's own tool loop | Any | Neither vendor SDK runs them |
| **A skill that must run code** | Anthropic's Agent Skills on the API (code-execution container) or OpenAI's hosted shell | Claude or OpenAI | Only when the skill needs a sandbox |

**The run adapter decides, the skill does not.** A run step names a role (`team@version/role`) and a model. The run engine picks the adapter for that model's provider and hands it the role's skill folders. A business switching an agent from Claude to OpenAI changes the adapter, not the skills.

**What does not carry across providers:** Claude-only or OpenAI-only features (server tools, specific container limits, provider-hosted skill IDs). Skills are stored in OS Flow, not uploaded to one vendor, so no provider holds the only copy.

### 7.4 Where skills come from and how they are vetted

Shipping a skill inside OS Flow to other businesses is redistributing it. Every catalog skill:
1. comes from a pinned commit, with its license recorded (MIT or Apache-2.0: adaptable with attribution; no license file: the idea only, in our own words);
2. is rewritten in OS Flow's terms (blocks, wires, gates, flows), never installed as published;
3. passes a small eval before it ships, with a failing baseline first;
4. is recorded in a provenance file and, if rejected, in a rejections file with the reason.

Install counts on a registry are not quality; every skill gets the same read.

## 8. Skills by role (shortlist; nothing installed)

| Role | Skill sources to adapt | What it gives |
|---|---|---|
| **Floki: draft and change** | n8n-io/skills (Apache-2.0) `n8n-workflow-lifecycle-official` (plan stage) and `n8n-error-handling-official` ("Non-negotiables", "When error handling can be looser"); czlonkowski/n8n-skills (MIT) `n8n-workflow-patterns` ("The 6 Core Patterns") | Archetype skeletons for drafts; error paths by default in unattended flows |
| **Floki: doctor** | n8n-io `references/REVIEW_CHECKLIST.md` (must, should, nice tiers; "Cross-cutting first"); czlonkowski `n8n-validation-expert/FALSE_POSITIVES.md`; n8n-io `n8n-loops-official` (no-cap loop rule only); `n8n-subworkflows-official` ("When NOT to extract") | Severity tiers and when not to flag |
| **Floki: doctor, agent flows** | affaan-m/ecc (MIT) `skills/agent-architecture-audit` (12-layer failure table, evidence phase); `skills/loop-design-check` (a machine-checkable goal with a must-not boundary; "Action 2", five ways a loop fails) | Checks for flows that contain agents and loops, not only plain steps |
| **Floki: tool suggestions** | anthropics/skills (Apache-2.0) `claude-api` `shared/prompt-audit.md` (tool descriptions); `mcp-builder` `reference/mcp_best_practices.md` ("Tool Design") | A rubric for a good tool and its description |
| **Architect team: interview** | n8n-io lifecycle plan stage; the interview structure of anthropics `doc-coauthoring` (no license file: idea only); the dev team's `grill-the-plan` | Intent, audience and constraints first; a gap check before drafting |
| **Agent building (Architect, Team designer)** | n8n-io `n8n-agents-official` ("Agent, workflow, or AI Agent node?"), `n8n-ai-nodes-official` (`SYSTEM_PROMPT.md`, `TOOLS.md`, `HUMAN_REVIEW.md`, approvals with real values) | When a step needs an agent; what goes in instructions versus a tool description; approvals that show real values |
| **Team designer** | wshobson/agents (MIT) `team-composition-patterns` ("Custom Team Guidelines", sizing); anthropics `claude-api` multi-agent "When to use it"; anthropics `skill-creator` (writing skills, with evals) | Smallest team, one lead, no overlapping roles, full context handed to each member; skill authoring |
| **Business consultant** | anthropics `discernment-nudge` (follow-up questions tied to specific claims) | Needs a skill written from Jase's own consulting method; ECC's `product-lens` Mode 1 (seven diagnostic questions with an anti-goal) and `council` are the closest outside material |
| **Knowledge architect** | affaan-m/ecc (MIT) `skills/living-docs-governance` (four document roles, one owner per fact, a delete-zone, linked docs treated as untrusted evidence); `agents/rag-pipeline-reviewer.md` (retrieval eval policy: baseline, thresholds, query slices) | Structure and freshness; how to test retrieval. A dedicated search is still due (section 11) |
| **Business teams: approvals** | affaan-m/ecc (MIT) `skills/operator-approval-loop`, without its timed auto-approval | An approval tied to a hash of the exact draft, so a changed draft needs a new approval; a receipt per send |
| **Business teams** | To be sourced per preset; for ecommerce, affaan-m/ecc (MIT) `returns-reverse-logistics`, `inventory-demand-planning`, `marketing-campaign`, `customer-billing-ops` as seeds after a domain check | Section 9 |
| **Team designer: skill evals** | affaan-m/ecc (MIT) `skills/skill-comply` (the method only: a skill tested under supportive, neutral and competing prompts) | How a new skill is shown to work before it ships |

## 9. Industry presets

**One catalog, presets on top.** Every agent and team exists once in a catalog. An industry preset is a selection from it. "Video editor" exists once and appears in the Ecommerce, Creator and Agency presets; a fix reaches all three.

**Onboarding asks three or four questions, not only the industry.** Industry alone guesses wrong (a B2B wholesale ecommerce business needs outbound sales; a direct-to-consumer brand does not):
1. Who buys: consumers or businesses?
2. How do sales happen: self-serve, inbound, outbound?
3. Which channels: web store, marketplaces, social, retail, events?
4. How big is the team?

**Defaults are editable copies that track their source.** A business can remove, edit or fork any default team. A fork records the catalog version it came from (spec 16 addendum's factory versions), so improvements can be offered later without overwriting the business's edits.

**Example: Ecommerce, direct to consumer, web store and social, small team**

| Team | Lead | Members |
|---|---|---|
| Marketing | Marketing strategist | Copywriter, Video editor, Ads specialist, Email marketer |
| Store operations | Operations lead | Catalog manager, Inventory planner |
| Customer support | Support lead | Support agent (replies drafted, sends at a gate) |
| Not included | | Outbound sales team (no outbound motion), lead-generation calling |

Jase's own businesses are the first presets to build and test against: two ecommerce businesses and one B2B service business.

## 10. Phases

| Phase | What | Depends on |
|---|---|---|
| P0 | This spec agreed; the words in section 3 used everywhere ("team", not "crew") | Jase |
| P1 | Floki's router becomes a classifier with a visible handoff; fixes R6-E-1 | spec 11 |
| P2 | The skill loader in Floki; the doctor and draft skills from section 8, each with an eval and a failing baseline | P1 |
| P3 | Design and run modes as permission profiles on one agent definition; run steps pinned to `team@version/role` | spec 13, spec 16 addendum |
| P4 | Run adapters: Claude Agent SDK first (the bridge exists), then OpenAI Agents SDK, then the loader for other models | P3 |
| P5 | Catalog and presets; the onboarding questions; forks that track their source | P3 |
| P6 | Specialists one at a time, each with its skills: Architect team (spec 15 already orders it), Team designer, Knowledge architect, Business consultant | P2, P4 |

## 11. Open questions for Jase

- **Knowledge architect skills:** ECC gives structure and retrieval-eval policy; a dedicated search (RAG, knowledge-base structure, taxonomy) is still due.
- **Business consultant:** your own consulting method is the best source; a short interview with you could seed its skill.
- **Which presets first:** your two ecommerce businesses and the B2B service business, or a general set?
- **Hosting run mode:** the Agent SDKs need a full server process; OS Flow's AI endpoints run on Cloudflare Pages Functions, which cannot host them. Where the run adapters live (the existing bridge, a container service) is not verified here.
- **Whether businesses may bring their own skills** into the catalog, and how those are vetted.

## 12. Sources

- OS Flow code and specs at the time of writing: `app/src/domain/aiEdit/*.ts`, `app/functions/ai/_lib/*.ts`, `flokiRoute.ts`, `app/bridge/claude.ts`, spec 11, 12, 13 §6.6, 15 §1 and §4, the M3C gauntlet reviews.
- Anthropic Claude API reference (Agent Skills on the Messages API with the code-execution container; the Claude Agent SDK as Claude Code's harness), read 2026-10-18.
- OpenAI: "Skills" guide (developers.openai.com/api/docs/guides/tools-skills) and the Agents SDK sandbox Skills capability (openai.github.io/openai-agents-python/ref/sandbox/capabilities/skills/), read 2026-10-19.
- ECC (affaan-m/ecc, MIT, 76aaa77): 311 skills in `skills/` (the 1,062 SKILL.md count includes translations and harness copies); about a third worth adapting. Not taken: its hooks (on by default when installed as a plugin), session observation and self-evolving skills, auto-update to latest, timed auto-approval, the merge queue that pushes main, and the boilerplate prompt block in every agent.
- Skill candidates read at: n8n-io/skills 27b6b9f (Apache-2.0), czlonkowski/n8n-skills c640094 (MIT), anthropics/skills dbd4588, wshobson/agents (MIT).
