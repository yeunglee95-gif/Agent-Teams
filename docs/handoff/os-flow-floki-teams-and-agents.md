# Floki, teams and agents

_From the Agent Teams session, draft 4, 2026-10-20, at Jase's request. It extends spec 11 (AI Edit), spec 12 (Ask AI), spec 13 (Run agent teams), spec 15 (Start a build), spec 16 (Team room) and the M5 row of spec 01 (AI teammates, a-132). OS Flow's session owns where it lands, its numbering and its milestone order. Nothing here is built. Section 16 lists what Jase still has to decide._

## 1. Abstract

Floki is the AI teammate every business gets built in: its front door, its flow engineer and its builder of interfaces. He does the frequent, quick jobs himself (edit a flow, answer about it, check its structure, build a small tool on a block) and hands long jobs to specialist teams behind him (build a whole flow from a goal, design the business's brain, design teams and skills, review the business, build a plugin). A person can also add their own AI (Claude Code, Codex, any MCP client) to a business like a teammate; it acts through the same list of actions Floki uses. Every agent works in one of two modes: **design mode** (proposes changes in the app; acts on nothing) and **run mode** (does business work inside a flow, with only what that flow grants). Live work is routed between teams by the flows' own rules, run by the run engine, never by a model's judgment. Skills are standard SKILL.md folders, so one skill works in Floki, in agents running on Claude or OpenAI, and in Claude Code. A business picks an industry and answers a few questions; a preset of default teams appears from one catalog, each team editable and forkable.

## 2. Decisions carried in

| Date | Decision | Source |
|---|---|---|
| 2026-10-11 | Connector: access to an outside service, no screens. Skill: know-how. Plugin: a bundle that adds screens and blocks, built on connectors and skills. Tool: one action a block calls (a-064). A plugin's block opens into its own flow like a subflow; Coldmail is the first plugin (a-063) | OS Flow MEMORY |
| 2026-10-12 | Floki composes business-home sections only from a fixed widget kit, stored as a declarative spec (data, never code) | OS Flow VISION 2026-10-12 |
| 2026-10-17 | Bring-your-own agents (a teammate's Claude Code or Codex) join rooms as members through the agent API | OS Flow MEMORY |
| 2026-10-18 | Floki is "the expert of creating workflow, diagnosing, building agentflow"; skills are defined before any are installed | Jase |
| 2026-10-18 | Floki is the front door and owns quick jobs; long jobs go to specialists behind him; live routing belongs to the flows and the run engine | Jase agreed |
| 2026-10-19 | AI teammates are M5's first item: a person's own AI is added to a business like a person, with an AI badge, permissions picked from read, draft, edit and run, and a revocable token per business; it connects through OS Flow's MCP server on its own subscription and never counts as a person on a gate (a-132) | OS Flow MEMORY |
| 2026-10-19 | One door for AI: Floki and the MCP server act through one list of OS Flow actions, so permissions, audit and the gate rule are enforced once | OS Flow MEMORY |
| 2026-10-20 | Floki builds tools inside OS Flow (small ones from a chat on a block) and apps (larger interactive pieces that connect to outside services such as Higgsfield or kie.ai) | Jase |
| 2026-10-20 | "Plugin" is renamed **App** (a-064's term replaced); a Website team runs a loop that improves the site from analytics; Floki's chat gets an effort control and voice input | Jase |
| 2026-10-20 | More default teams; a service-business preset that covers what Salesforce covers; a Knowledge architect and a Business consultant built from research, not only from Jase's view | Jase |
| standing | Floki never decides a gate; he starts, pauses or stops runs only behind a confirm card; his edits are drafts | spec 13 §6.6 |
| standing | The owner approves every merge, send, spend and publish | spec 16, Agent-Teams |

## 3. Definitions

### 3.1 People, AIs and groups

| Term | What it is | Example |
|---|---|---|
| **Member** | Anyone with a seat in a business: a **person** or an **AI teammate** | Jase; Jase's Claude Code |
| **Person** | A human member. Only a person can approve at a gate | A co-founder |
| **AI teammate** | An AI added to a business like a person, with an AI badge and permissions from read, draft, edit and run. Two kinds: **Floki** (built in, one per business) and **brought AI** (a person's own Claude Code, Codex, Cursor or other MCP client, on its own subscription) | "Codex on Alice's laptop" |
| **Team** | A group with one purpose, one **lead**, shared knowledge and a default way of working (its factory, spec 16 addendum). Its members can be agents, people and AI teammates | Marketing team |
| **Agent** | One role with a job, a model, skills, tools and knowledge, run by OS Flow. Either a team's **lead** (plans, assigns, combines) or a **member** (one kind of work) | Marketing strategist (lead); Video editor (member) |
| **Sub-agent** | A temporary helper an agent starts for one task and drops when done. No standing identity, not listed in the Team room, owns nothing | The video editor starts three helpers to cut three lengths |

Rules that follow:
- **One lead per team.** Several orchestrators in one group produce competing plans.
- **Members are standing; sub-agents are not.** A role someone will want to see, improve and reuse is a member.
- **An agent and an AI teammate differ in who runs them.** OS Flow runs an agent, with the model and skills its role names. A brought AI runs on its owner's machine and subscription and reaches OS Flow only through the action list (section 7).
- Spec 15's "crew" is a team in these terms; OS Flow uses one word, **team**.

### 3.2 What agents and people work with

| Term | What it is | Who builds it | Example |
|---|---|---|---|
| **Connector** | Access to an outside service: a key, its data and its actions. No screens | Set up by a person; Floki can guide it | Shopify, Gmail, Higgsfield, kie.ai |
| **Tool** | One action a block calls, through a connector or inside OS Flow | Floki, from a block | "Create invoice in Xero" |
| **Widget** | One piece of the fixed kit: number, list, table, chart, form field, button, note, file drop, approval card | OS Flow | |
| **Interface** (was "in-app tool") | Widgets composed into a screen on a block, a desk task or a home section; stored as a declarative spec (data, never code). Built by asking Floki in a chat on the block | Floki, in design mode | An approval card showing the draft and its numbers; an intake form; a results table |
| **App** (was **Plugin** in a-064; renamed 2026-10-20) | Installable code that adds its own screens and blocks, built on connectors and skills under one contract; its block opens into its own flow like a subflow. Made by OS Flow, by a business for itself, or by someone else and shared | OS Flow's app builder team (section 4), a business's own builder, or an outside developer; installed only on the owner's approval | An AI video or image editor on Higgsfield or kie.ai; Coldmail |
| **Team template** | A packaged team (lead, members, skills, way of working) from the catalog, which a business adds and edits | Team designer; vetted catalog | The Sales team template |
| **Skill** | Reusable know-how an agent loads when a task calls for it: a SKILL.md folder (section 9) | Team designer; vetted catalog | "Short-form video hooks" |
| **Knowledge (brain)** | What agents can look up: sources, structure, retrieval, freshness | Knowledge architect | Product catalog, brand voice, past proposals |
| **Flow** | A defined process that runs agents and tools, with gates | Floki, Architect team, people | "New client onboarding" |
| **Gate** | A step where a person approves before the flow goes on | Part of a flow | "Approve the proposal before it is sent" |
| **Run** | One execution of a flow, pinned to the versions of everything it uses | The run engine | Onboarding run #12 |
| **Mode** | Design (in the app, proposes) or run (inside a flow, acts through granted tools) | Section 5 | |

**Interface or app?** If it can be composed from widgets and needs no code, it is an interface, built in one Floki turn and previewed like any change. If it needs its own editor, live media, a canvas or custom logic (a video timeline, an image editor), it is an app: real code, built and reviewed like any code, installed with an approval. An interface is data, so Floki can build it safely in seconds; an app is code, so it goes through review.

**Why "App", not "Plugin".** In Claude Code, a plugin is a bundle of skills, agents, commands, hooks and MCP servers with no screens of its own; OS Flow already installs Claude Code plugins (the dev team is one). What OS Flow means here, an installable piece with its own screens, is what Shopify, Slack, Canva, Zoom and HubSpot call an **app** and list in an **app store**. Using "app" avoids two meanings for one word and matches what business users already know. Figma's nearest equivalent to an interface on a block is its **widget**, an interactive object on the shared canvas.

**Interfaces people work in.** The widget kit should cover the moments a person meets a flow:

| Interface | What the person does | Used by |
|---|---|---|
| Approval card | Approve, reject or edit, seeing the real values and what changed | Every gate |
| Pick the best | Choose one of several drafts, or rank them | Content, proposals, ads |
| Intake form | Give the facts a flow needs; shareable by link to someone outside the business | Client onboarding, quotes, support |
| Review and annotate | Comment on a document, image or video frame, pinned to the spot | Creative, contracts |
| Edit before send | Change rows in a table or a draft's text, then release it | Outreach lists, invoices |
| Sign | Sign or send for signature | Proposals, contracts |
| Book a time | Pick a slot from a real calendar | Sales, delivery |
| Ask a person | Answer a question a run is waiting on | Any run missing a fact |
| Checklist | Tick off steps a person must do by hand | Onboarding, fulfilment |
| File drop | Hand over files a run needs | Delivery, finance |
| Scorecard | See three to five numbers that matter, with their trend | Home, the consultant's weekly review |
| Client page | A page a client sees: status, files, approvals, invoices | Service businesses |

## 4. Who does what

| Who | Design mode (in the app) | Run mode (inside flows) | Can act on the world | Decides gates |
|---|---|---|---|---|
| **Floki** (built-in AI teammate) | Edits flows; answers about them; runs the structural Flow doctor; builds interfaces from a block chat; composes business-home sections; writes app briefs; hands long jobs to specialists | Does no business work; starts, pauses or stops runs behind a confirm card | No | Never |
| **Brought AI teammate** (Claude Code, Codex, any MCP client) | Whatever its permissions allow (read, draft, edit), through the same action list as Floki | Run, if granted: starts runs a person could start | Only through the action list | Never counts as a person |
| **Architect team** (Interviewer lead, Researcher, Architect) | Builds a whole flow from a goal, after an interview; returns it as Floki change previews (spec 15) | No | No | No |
| **Knowledge architect** | Designs the brain: sources, structure, retrieval, freshness, access | Runs upkeep flows (re-index, freshness checks, retrieval evals) | Only through granted tools | No |
| **Team designer** | Creates teams, agents and skills in the Team room; sizes teams; tests new skills | No | No | No |
| **Business consultant** | Diagnoses the business: finds the one constraint holding back profit and the few changes that move it (section 12) | Runs as a scheduled review (weekly scorecard) | No | No |
| **App builder** (the dev team and design team, hosted) | Builds apps from Floki's brief: design hand-off, code, tests, review | No | No; an app is installed only on the owner's approval | No |
| **Business teams** (by preset, section 11) | Suggest changes to their own team, which the owner approves | The main workers | Only through tools the flow grants | No |
| **Run engine** (code, not an agent) | None | Routes work between steps and teams by the flow's rules; executes granted tools | Yes, as the flow grants | No; it waits at every gate |
| **The owner and other people** | Approve every build, team change, app install | Approve at gates | Yes | Always |

**The structural doctor and the business consultant are different jobs.** "Is the flow built right?" is Floki's. "Does the business make money, and what is holding it back?" is the consultant's.

**Floki routes conversations; flows route work.**

## 5. Design mode and run mode

One agent definition (job, skills, knowledge, model, way of working) serves both modes. What differs is what it may touch.

| | Design mode | Run mode |
|---|---|---|
| Works on | Drafts of flows, teams, tools, knowledge structure | Real tasks: leads, orders, posts, files |
| Acts on the world | No; it proposes, and a person applies | Yes, only through the tools the flow grants |
| Output | A change preview | Results, at gates |
| Context | The canvas, specs, notes | The run's inputs and the knowledge it is pointed at |
| Judged by | Whether the build is sound | Outcomes and cost per run |
| Version | The latest draft | Pinned (`team@version/role`); a run never changes mid-flight |

Why share the definition: one place to improve a skill; the agent that designed a step knows how it runs; fewer definitions. Why separate the modes: safety (no send or spend tools near drafts), pinned runs, small run context, and a record that shows whether the design or the run was wrong. Building a new app outside OS Flow uses the same role in Claude Code (the dev-team plugin).

## 6. Floki's jobs

| Job | Today (code) | Next |
|---|---|---|
| **Change**: a request becomes a change set; drafts a whole flow on an empty canvas | `domain/aiEdit/editPrompt.ts`, `propose_changes` | Draft archetypes (section 10); error paths by default in unattended flows |
| **Ask**: answers with cited blocks, at most one suggested change | `askPrompt.ts`, `answer_question` | Follow-up questions tied to specific claims |
| **Flow doctor**: deterministic checks, then an AI review | `domain/flowDoctor/`, `doctorPrompt.ts`, `report_findings` | Severity tiers; a rule for when not to flag; checks for agents and loops; reruns on real runs' costs and failures |
| **Build an interface from a block chat** | Sketch only (`draw_sketch`, static, never wired to data) | A widget-kit spec wired to the block's data, previewed and applied like any change; reviewed by the doctor for gates and permissions |
| **Compose business-home sections** | Planned (VISION 2026-10-12) | From the fixed widget kit only |
| **Start an app** | None | Floki interviews, writes the app brief (screens, blocks, connectors, data, gates) and hands it to the app builder team; the result comes back for the owner's install approval |
| **Set up connectors** | None | Guides a person through connecting a service; never sees or stores the key itself |
| **Hand off** | None | A visible handoff ("Handing this to the Knowledge architect"), one click to undo; the specialist's result comes back as a Floki change preview |
| **Onboard a business and start a project** | Planned (2026-10-12 and 2026-10-19: one big prompt, multiple-choice rounds with Floki's best guess pre-selected, a fill-the-gaps list; suggestions from the profile and brain) | Picks the preset (section 11) from the onboarding answers |
| **Start any build by interview** | Planned (PRODUCT-VISION item 9, 2026-10-08) | Whatever a person wants to build (an interface, an app, a workflow, an agent flow), Floki interviews first: problem and people, the key forks, one honest challenge |
| **Propose a project's goal and milestones** | Planned (2026-10-18) | Drafts them with Keep, Edit and Dismiss; a person keeps them; Floki never adds, closes or changes one by itself |
| **Keep the business's memory** | Planned (a-088, a-092, a-093) | Floki.md (identity, standing rules, current state) and a memory folder per business; decisions committed to the memory files, through the person's harness first, with guards |
| **Prepare desk tasks** | Planned (2026-10-12) | Prepares approvals, replies, documents to sign or check on Your desk; the person presses send or sign |
| **Find** | Planned (VISION 2026-10-12) | Search first, then a cited answer, filtered by the asker's access, never revealing that hidden things exist |
| **Chat like Claude** | Planned (2026-10-18; additions 2026-10-20) | Attach images and files; see the context in use and the usage; reach every file built in the thread; an effort control (quick, standard, deep) that sets how hard Floki thinks and is shown with its cost; voice input (speak a request, see it transcribed before it is sent); the model in use shown, with the business's allowed choices |
| **In rooms** | Planned (2026-10-17) | Floki is private per person; @Floki in a team room answers or runs, never builds; flows are built in Floki, published into a room and run there |

**Routing.** Today `flokiRoute.ts` routes by regex, and its misroute was the M3c release hold (R6-E-1). The router becomes a small classifier call that returns one of change, ask, doctor, build interface, app brief, or hand off to a named specialist, with its reason shown on a handoff. A mode the person selected always wins over the classifier.

## 7. AI teammates

Built on a-132 and the one-door decision (both 2026-10-19).

| | Floki | Brought AI teammate |
|---|---|---|
| Who runs it | OS Flow, on the business's credits (falls back to OpenRouter, then the bridge) | Its owner, on their own subscription and machine |
| How it reaches OS Flow | Directly | OS Flow's MCP server, with a revocable token per business |
| What it can do | Design-mode jobs in section 6 | What its permissions allow: read, draft, edit, run |
| The action list | The same list for both; a test checks the two never drift | |
| Gates | Never decides one | Never counts as a person; it can prepare a gate's material, not approve it |
| Audit | Every action logged with "Floki" | Every action logged with the AI's name and the person who added it |
| Skills | Loaded by OS Flow (section 9) | Its own harness loads them; OS Flow can offer the business's skill folders for download so a brought AI works the same way |

**Brought AIs as team members.** A brought AI can be named as a member of a team (for example, Alice's Codex in the Delivery team) and assigned tasks the same way a person is. It cannot hold a gate seat or a lead role that approves work.

## 8. Hosting run mode

### 8.1 What exists today

- The conductor is a Cloudflare Workflow (its own `os-flow-conductor` Worker with a D1 log), and `/run/*` endpoints are Pages Functions with a 30-second wall clock (spec 13; spec 06).
- A step that needs a real agent (tools, files, long work) goes to the **bridge**: a small Node program that runs the Claude Agent SDK or `claude -p` on a "harness host" and only makes outbound calls (`app/bridge/claude.ts`). The harness host has been Jase's laptop; that bridge was paused on 2026-10-11.
- The plan (M3C-M4-PLAN §3.4b and §3.4c): R0 direct API calls for text-only blocks; R1 Run settings; R2 hosted runs on Claude Managed Agents "so a team runs with no computer awake"; R3 a packaged bridge installed with `npx` and paired by a short code.

### 8.2 Why it matters

An agent SDK (Claude's or OpenAI's) is a long-running program that needs a real Linux process, a working folder and minutes of time. Cloudflare Workers and Pages Functions cannot give it that: no child processes, no real filesystem, 128 MB of memory, and a 30-second limit on Pages Functions. So text-only steps can run in the Workers OS Flow already has, but agent steps need somewhere else. Today that somewhere is a laptop, which means a business's flows stop when the laptop sleeps.

### 8.3 Options

| Option | Runs | Who pays for compute | Fit |
|---|---|---|---|
| **A. Claude Managed Agents** (planned R2) | Claude only; Anthropic runs the loop and a sandbox per session | The business's Anthropic account | The fastest path for Claude; no use for OpenAI or other models |
| **B. Cloudflare Containers / Sandbox SDK** | Any SDK: Claude Agent SDK, OpenAI Agents SDK, or OS Flow's own loop; one Linux sandbox per session, sleeping between steps, shut down after | OS Flow's Cloudflare account (Workers Paid), passed through in credits | Same platform as the conductor; one place for every provider. Cloudflare publishes a Managed Agents template on it, marked alpha |
| **C. The business's own bridge** (planned R3) | Any SDK, on the business's machine or server | The business | For businesses that want their data on their own machines, and for brought AI teammates |
| **D. A separate server (VPS, Modal)** | Any | OS Flow | Breaks spec 01's "No VMs" line |

### 8.4 Recommendation

It is a decision and a milestone, not a redesign: the conductor already orchestrates steps; only where an agent step executes changes. Keep R2 (Managed Agents) as the first hosted path for Claude, since it is planned and needs the least code. Add **option B** as the provider-neutral hosted runner right after it, because a business that picks OpenAI or another model for its agents needs it, and it keeps everything on Cloudflare. Keep **option C** for businesses that bring their own compute. Before committing to B: verify its price per session-hour, its cold-start time, and whether the template has left alpha.

### 8.5 How comparable products run

| Product | Its own agents | Brought agents |
|---|---|---|
| **Kylon** (kylon.io) | Run on Kylon's cloud: each agent gets a cloud computer with a shell, files and a browser; model calls go through Kylon's gateway and are billed in Kylon credits | Claude Code and Codex stay on the person's computer (a background service the person starts), signed in with their own account, billed by their provider; Devin connects through its own cloud |
| **Dify** | Its own servers (Dify Cloud), or self-hosted with Docker: an API server and background workers run the workflows, calling model APIs; code steps run in Dify's own sandbox service | None; it calls models, not outside agent harnesses |

Both host the compute for their own agents. Kylon's brought agents are the same idea as OS Flow's AI teammates, and Kylon still hosts its own agents so a business does not depend on someone's laptop being awake.

### 8.6 Can AI teammates run the flows instead?

Partly. A brought AI teammate can take tasks in a flow (its permissions allow run), and its usage is billed to its owner. Three limits keep it from being the default runner:

1. **Availability.** A teammate on a laptop is offline when the laptop sleeps. A cloud session (Claude Code on the web, Codex cloud) is not tied to a laptop, but it still has to be started or scheduled by its owner.
2. **Anthropic's terms for subscriptions.** Anthropic's Claude Code legal page (read 2026-10-20) says subscription sign-in "is designed to support ordinary use of Claude Code", that Pro and Max limits "assume ordinary, individual usage", and that developers building products, including with the Agent SDK, "should use API key authentication". It does not permit a product "to route requests through Free, Pro, or Max plan credentials on behalf of their users", or to "collect, store, or intermediate Claude.ai credentials or session tokens". It does allow a platform to host the unmodified Claude Code binary where each end user signs in with their own subscription, under Anthropic's Commercial Terms. So: a person's own Claude Code doing their share of a team's work is fine; a business's always-on production flows running on one person's Max plan is not ordinary individual use; and OS Flow must never store a person's Claude sign-in token on its servers.
3. **Responsibility.** A business's production flows should not stop because one member's subscription lapses, hits a limit or leaves the business.

**Running while a laptop sleeps, without OS Flow's API credits.** Three ways:

| Way | Where it runs | Paid by | Limits |
|---|---|---|---|
| **The business's own API key** in OS Flow's hosted runner | OS Flow's hosted runner (R2, option B) | The business, directly to Anthropic or OpenAI | None beyond the provider's rate limits; the cleanest path for production |
| **The teammate's own cloud**: Claude Code on the web with a scheduled routine, or Codex cloud tasks, pulling assigned tasks from OS Flow through its MCP server | The AI vendor's cloud | The teammate's subscription | Subscription limits assume ordinary, individual use; the teammate sets up the schedule; good for a person's share of the work, not a whole business's flows |
| **An always-on box**: the packaged bridge on a mini PC (the OS Flow Station brief, 2026-10-19) | The business's own hardware | The owner's subscription or API key | Same terms as the bridge; the Station brief recommends confirming with Anthropic sales first |

**So:** OS Flow hosts its own agents for production runs (R2, then option B), billed by API key in the business's credits, the same shape as Kylon. AI teammates do assigned work on their owners' accounts, and a business with no hosted credits can still run its flows through teammates and its own bridge, with the limits above shown in Run settings. The existing bridge's plan mode (`claude -p` with a subscription token) stays on the person's own machine only, run by that person; check it against these terms before it is offered to teams.

## 9. Skills

### 9.1 Why Floki cannot load skills today

Skills are a feature of the harness around a model. A harness lists each skill's name and description, gives the model a way to load the full text, and (for skills with scripts) a filesystem. Floki is one model call with a system prompt, one strict output tool and the messages.

### 9.2 One format: SKILL.md

Every skill is a folder with a `SKILL.md` (frontmatter `name` and `description`, then instructions) and optional `references/`, `scripts/` and `assets/`: the open Agent Skills standard. Anthropic's API and Claude Code read it; OpenAI's API and Agents SDK read it too. One skill therefore works in Floki, in OS Flow's agents on Claude or OpenAI, in brought AI teammates, and in Claude Code.

**Portability rule:** instruction-only skills work everywhere. A skill that runs scripts needs a sandbox and works only where one exists. Catalog skills are instruction-only unless their frontmatter says otherwise.

### 9.3 How each place loads them

| Where | How | Models |
|---|---|---|
| **Floki** | A loader OS Flow writes: names and descriptions in the prompt; a skill's full text included by route (the doctor always gets the review skill) or on a `load_skill` step | Any, including the OpenRouter fallback |
| **Agents in run mode, Claude** | The Claude Agent SDK (bridge, hosted sandbox) or Managed Agents | Claude |
| **Agents in run mode, OpenAI** | The OpenAI Agents SDK's sandbox Skills capability, or the Responses API's `shell` tool with skills attached | OpenAI |
| **Agents on any other model** | The same loader as Floki's, with OS Flow's own tool loop | Any |
| **Brought AI teammates** | Their own harness, from skill folders the business downloads | Their own |

The run adapter decides, not the skill: a run step names a role and a model, and the run engine picks the adapter for that model's provider. Skills are stored in OS Flow, not uploaded to one vendor.

### 9.4 Where catalog skills come from

Shipping a skill inside OS Flow to other businesses is redistributing it. Every catalog skill comes from a pinned commit with its license recorded (MIT or Apache-2.0: usable with attribution; non-commercial licenses such as CC BY-NC-SA: excluded; no license file: idea only), passes a small eval with a failing baseline first, tried three ways (a prompt that asks for it, a neutral one, one that pushes against it), and is recorded with its provenance. Install counts are not quality. Two tracks:

- **Used as published.** A maintained source from a reputable publisher whose skills already fit OS Flow's rules (Anthropic's knowledge-work plugins are the first). The skills are used unmodified, so upstream improvements keep flowing; OS Flow adds a thin overlay beside them: which team and agent uses each skill, its connector placeholders mapped to OS Flow connectors, and the gates it must stop at. An upstream update is pulled as a reviewed diff, its evals re-run, then offered to businesses.
- **Adapted.** A source with good ideas that does not fit as published (n8n's skills, ECC, single community skills): rewritten in OS Flow's terms, and no longer synced.

### 9.5 Bringing your own skills

| Tier | Who sees it | Checks before it can run | Who is responsible |
|---|---|---|---|
| **Private** | The business that added it | Automatic: valid SKILL.md; size limits; a secrets scan; a scan for instructions that try to override rules or send data out; scripts flagged | The business |
| **Shared** (offered to the catalog) | Every business, once accepted | The private checks, plus the catalog process in 9.4: license, rewrite, eval, provenance | OS Flow, once accepted |
| **Verified** | Every business | Maintained by OS Flow, with evals re-run on each model change | OS Flow |

Rules for every tier:
- **A skill is know-how, never authority.** It cannot grant a tool, a connector, a permission or a gate; those come from the flow and the member's permissions.
- **Scripts run only in a sandbox** with no secrets mounted, and only where the business allowed scripts.
- **Pinned versions.** A business runs a fixed version; an update shows the diff and waits for the owner's acceptance.
- **Revocable.** A shared skill found unsafe is withdrawn from the catalog and flagged in every business that uses it.

## 10. Skills by role (shortlist; nothing installed)

Sources were read at pinned commits; licenses are from each repo's LICENSE file.

| Role | Sources to adapt | What it gives |
|---|---|---|
| **Floki: draft and change** | n8n-io/skills@27b6b9f (Apache-2.0) `n8n-workflow-lifecycle-official` (plan stage), `n8n-error-handling-official`; czlonkowski/n8n-skills@c640094 (MIT) `n8n-workflow-patterns` | Archetype skeletons; error paths by default |
| **Floki: doctor** | n8n-io `references/REVIEW_CHECKLIST.md`, `n8n-loops-official` (no-cap loop), `n8n-subworkflows-official`; czlonkowski `n8n-validation-expert/FALSE_POSITIVES.md`; affaan-m/ecc@76aaa77 (MIT) `agent-architecture-audit`, `loop-design-check` | Severity tiers, when not to flag, checks for agents and loops |
| **Floki: tools and app briefs** | anthropics/skills@dbd4588 (Apache-2.0) `claude-api` (tool descriptions), `mcp-builder` ("Tool Design"); OS Flow's design team for plugin screens | A rubric for good tools; plugin briefs a builder can work from |
| **Architect team** | n8n-io lifecycle plan stage; the interview structure of anthropics `doc-coauthoring` (no license file: idea only); the dev team's `grill-the-plan`; n8n-io `n8n-agents-official`, `n8n-ai-nodes-official` | Interview first; when a step needs an agent; instructions versus tool descriptions; approvals with real values |
| **Knowledge architect** | qdrant/skills@d2127f6 (Apache-2.0) `qdrant-search-quality` (metric by use, golden set, confidence interval on gains, held-out confirmation, symptom-to-strategy table); anthropics/knowledge-work-plugins@a266ab8 (Apache-2.0) `enterprise-search` (source authority by query type, freshness to confidence, dedup and what not to dedup, citations, conflicts) and `kb-article` (audit cadence, lifecycle); yonatangross/orchestkit@accece5 (MIT) `golden-dataset`, `rag-retrieval`; jeffallan/claude-skills@36f3fe8 (MIT) `rag-architect` (rules only, not its code); inkeep/open-knowledge-skills@efde8d3 (MIT) provenance and supersede chains; ecc `living-docs-governance` | Design, freshness, provenance and retrieval evals. **Gap:** access-controlled retrieval (permission-trimmed results, inherited source permissions, no leakage across businesses in caches or statistics) has no good skill; OS Flow writes its own |
| **Team designer** | wshobson/agents (MIT) `team-composition-patterns`; anthropics `claude-api` multi-agent guidance; anthropics `skill-creator`; ecc `skill-comply` (method) | Team sizing, one lead, no overlap; skill authoring and three-way skill tests |
| **Business consultant** | Section 12 | |
| **App builder** | Agent-Teams dev-team and design-team plugins (ours) | Apps built and reviewed like any code |
| **Business teams** | Section 11 | |

## 11. Default teams

### 11.1 One catalog, presets on top

Every team and agent exists once in a catalog; a preset is a selection. Onboarding asks three or four questions beyond the industry (who buys; how sales happen: self-serve, inbound, outbound; which channels; team size). Defaults are editable copies that track their catalog version, so improvements can be offered later without overwriting a business's edits.

### 11.2 The catalog

| Team | Lead | Members | Main skill sources |
|---|---|---|---|
| **Growth** | Growth strategist (ICP and offer) | Prospector, Outbound rep, Partnerships and referrals | KWP `small-business/lead-finder`; coreyhaines31/marketingskills@e85f3cb (MIT) `prospecting`, `cold-email`; mbfinotti/sales-skills@1ef6888 (MIT) `sales-outbound-sequence` |
| **Marketing** | Marketing lead | SEO specialist, Content writer, Social and LinkedIn manager, Email and newsletter | coreyhaines31 `seo-audit`, `content-strategy`, `copywriting`, `social`; KWP `small-business/social-content-engine`, `seo-ai-visibility`; ecc `marketing-campaign`, `brand-voice` |
| **Creative studio** | Creative director | Video editor, Image designer, Ad creative | Uses apps (AI video and image editors on Higgsfield, kie.ai); the design team's `frontend-design` for direction |
| **Sales** | Sales lead | Inbound qualifier (speed to lead), Discovery and call prep, Proposal and SOW writer, Contract reviewer | KWP `small-business/speed-to-lead`, `proposal-builder`, `contract-review`, `sales/call-prep`; mbfinotti `sales-discovery-questions` |
| **Delivery** (services) | Delivery manager | Onboarding lead, Project manager (status reports, change requests), Resource and time planner | mbfinotti/revops-skills@2dedb39 (MIT) `sales-to-cs-handoff`; KWP `operations` status report, change request, capacity plan. **Gap:** client onboarding, weekly status, scope change, utilisation and retainer burn-down need skills written for OS Flow |
| **Client success** | Account manager | Support and ticket triage, Health and renewals, Reviews and advocacy, Knowledge base writer | KWP `sales/account-plan`, `renewal-radar`, `customer-health`, `customer-support/ticket-triage`, `kb-article`, `small-business/review-reputation`, `ticket-deflector` |
| **Website** | Conversion strategist | Analytics analyst (PostHog, Microsoft Clarity, GA), Web designer (works with the design team), Web developer (ships changes through the site's own builder or the dev team), Copywriter (shared with Marketing) | coreyhaines31 `cro`, `page-cro`, `signup-flow-cro`, `ab-testing`, `analytics`, `conversion-tracking`, `site-architecture`; PostHog's own skills for instrumentation (license to check); the design team's `frontend-design`; the dev team for code changes |
| **Store operations** (ecommerce) | Operations lead | Catalog manager, Inventory planner, Returns and fulfilment | KWP `small-business/inventory-planner`, `restock`; ecc `returns-reverse-logistics`, `inventory-demand-planning` (after a domain check) |
| **Customer support** (ecommerce) | Support lead | Support agent (replies drafted, sent at a gate), Returns desk | KWP `customer-support/*`, `ticket-deflector` |
| **Finance** | Finance ops | Invoicing, Collections, Bills, Cash and P&L reporter, Tax prep | KWP `small-business/invoice-chase`, `pay-the-bills`, `cash-flow-snapshot`, `close-month`, `tax-prep`; KWP `finance/variance-analysis` |
| **Ops / RevOps** | Chief of staff | CRM steward, Reporting and forecast analyst, SOP writer, Inbox manager | KWP `small-business/crm-autopilot`, `inbox-manager`, `report-builder`, `sales/forecast`; coreyhaines31 `revops` |
| **People** | People lead | Recruiter, Onboarding, Payroll prep | KWP `small-business/hiring-screener`, `job-post-builder`, `payroll-prep` |
| **Product and engineering** | Architect | The Agent-Teams dev team and design team | Ours |

The strongest single source is anthropics/knowledge-work-plugins' `small-business` plugin (44 skills, Apache-2.0): every send is drafted and waits for approval, with no auto-send mode, which matches OS Flow's gates. Its skills share voice and style files, so it is used as a unit, unmodified, on the "used as published" track (9.4). It is one plugin for a business owner (44 skills and a router across functions), not split into teams; the same repo's role plugins (sales, marketing, customer support, finance, legal, human resources, operations, product management, data, design, engineering, productivity, enterprise search) are split by function and map to OS Flow's teams. The small-business plugin has changed four times since June 2026 (launched 2026-09-15); most of the repo's frequent commits are version bumps of partner plugins, so updates are steady but not weekly. Not taken: deanpeters' finance and pricing skills (CC BY-NC-SA, non-commercial), ecc `lead-intelligence` (browser control of LinkedIn, terms-of-service risk), alirezarezvani `customer-success-manager` (SaaS scoring scripts).

**The Website team's improvement loop.** A flow, run weekly, built to the dev team's loop rules (a goal a machine can check, a boundary, an independent judge, a person flips done):

1. The Analytics analyst reads the week's numbers (conversion by page and step, drop-offs, rage clicks and dead clicks from Clarity, session recordings flagged by PostHog) and names the biggest leak, with evidence.
2. The Conversion strategist writes one hypothesis and one change, with the metric it should move and by how much.
3. The Web designer and Copywriter prepare the change; the Web developer builds it behind a test (an A/B split or a staged rollout).
4. **Gate:** the owner approves the change before it goes live.
5. The test runs for a fixed time or sample size set in advance; the analytics decide, not the team that made the change.
6. **Gate:** the owner keeps or reverts the change. Every change and result is logged, so the next round starts from what was learned.

Boundaries the loop never crosses on its own: no change goes live without the owner's approval; no dark patterns (fake scarcity, hidden costs, pre-ticked boxes); no change to tracking or consent banners without the owner; no price change (that is the Business consultant's and the owner's call).

**Why its own team, not inside Creative studio or Marketing.** Creative studio makes assets (video, images, ads); Marketing brings people to the site; the Website team owns what happens once they arrive, measured by conversion. It borrows from both: the Copywriter from Marketing, assets from Creative studio, and engineering from the dev team.

### 11.3 Presets

| Preset | Teams |
|---|---|
| **General (any business)** | Marketing, Sales, Client success, Finance, Ops |
| **Service and consulting** | Growth, Marketing, Website, Sales, Delivery, Client success, Finance, Ops |
| **Ecommerce, direct to consumer** | Marketing, Creative studio, Website, Store operations, Customer support, Finance, Ops |
| **Ecommerce, wholesale / B2B** | The direct-to-consumer set plus Growth and Sales |
| **Software product** | Product and engineering, Marketing, Website, Sales, Client success, Finance, Ops |
| **Freelancer or consultant (one person)** | One team, "My business": a lead plus Prospector, Proposal writer, Project manager, Invoicing and collections, Content writer |
| **Creator** | Creative studio, Marketing (social and newsletter), Finance (light), a Partnerships agent for brand deals |
| **Personal** | One team, "My day": Inbox manager, Calendar and errands, Personal finance, Research and learning |

Individuals get presets too: a freelancer or creator is a business of one, so the same catalog serves them with fewer, broader agents; a personal preset covers a person's own admin. Business presets come first; individual presets follow once the business ones have run real work.

### 11.4 Which first

Build the catalog skeleton as a general set, then prove each preset on Jase's own businesses as an ordinary user of OS Flow: the service and consulting business first (the best skill coverage and Salesforce-equivalent map), then the two ecommerce businesses. A preset ships to other businesses only after it has run real work in one of Jase's. Nothing of Jase's own data enters the catalog: the pattern does, the brief does not.

## 12. The Business consultant

### 12.1 What it is for

To find the one constraint holding back profit in a small business and the few changes that move it, from the business's numbers, not from opinions. No outside skill does constraint-first diagnosis; OS Flow writes this one, drawing on the sources below.

### 12.2 How the consultant gathers information (Jase, 2026-10-21)

Learned from the first real interview, with Jase on his service business:

1. **Brain dump first.** One large box and a few macro prompts: what is wrong with the business right now; what you are trying to achieve; how fast; your plan to get there; what you have already tried. Details are welcome but not required. Most owners already know where they struggle; the consultant starts from their account, not from a blank diagnosis.
2. **Tailored follow-ups second.** Questions drawn from the dump, not a fixed list. Numbers are asked as exact rough figures in free text ("roughly what does the business cost per month?"), never as multiple-choice ranges. When the owner does not know a number, the consultant says where to find it and waits for it.
3. **Ask why before recommending a change.** Anything that looks wrong (a low price, an odd channel) may be deliberate. The consultant asks the reason first; a recommendation that the owner already rejected for a good reason is noise.
4. **Test the owner's own hypotheses with numbers.** The owner usually knows where it hurts; the consultant's job is to find which of those problems binds profit first, and to say so, with one honest challenge where the numbers disagree with the owner's view.
5. **Specific, not generic.** Every recommendation names the owner's own channels, contracts, tools and numbers. Advice that would fit any business ("fill the top of the funnel") is not finished.

### 12.3 Diagnostic sequence


0. **Goals and guardrails:** the owner's target (profit, owner pay, hours, exit), runway, hours worked. Output: a problem statement, "from X to Y by date Z".
1. **Cash triage:** bank balance, monthly burn, days of cash. Under 30 days of cash: stabilise cash before anything else.
2. **Contribution P&L** per business, then per product, channel or client: variable versus fixed costs; contribution margin after product cost, fulfilment and fees, and after ad spend (ecommerce), or margin and effective hourly rate per client (services); winners and losers by profit, not revenue; break-even volume.
3. **Driver tree and sensitivity:** the profit change from +1% price, volume, variable cost and fixed cost; levers ranked.
4. **Locate the constraint**, testing in order: each sale loses money (pricing or cost); each sale earns but there are too few (demand or funnel); demand exists but delivery or the owner's time is capped (capacity); profitable but no cash (cash cycle). Output: one named constraint with its evidence.
5. **Deep dive on that branch only:** funnel stage rates, the pricing waterfall, buyer and churned-customer interviews, or utilisation and realisation.
6. **Exploit before elevate:** at most three changes, each with expected profit change, cost and a test.
7. **Stop doing:** what to drop so the constraint gets the attention.
8. **Cash discipline** once the plan is set.
9. **Cadence:** a weekly scorecard of three to five numbers; re-diagnose when the constraint moves; test the final recommendation against a four-voice council before presenting it.

### 12.4 Methods and their usual misreadings

Theory of Constraints (spending to expand before using the constraint fully); the profit equation (pushing volume when each unit loses money; a 1% price rise typically moves operating profit about three times more than 1% more volume); issue trees (overlapping branches, data before hypotheses); unit economics (lifetime value on revenue instead of margin, blended rather than per-cohort figures); ecommerce margin after ads (trusting platform-reported return on ad spend; ignoring returns and fees); the cash conversion cycle (a profitable P&L with a shrinking bank balance); service capacity (billable utilisation of roughly 70 to 80% tends to maximise profit; scope creep and the owner's unbilled time are missed); Pareto by contribution (overhead spread by revenue share hides loss-makers); jobs to be done (explains conversion and repeat rates the numbers cannot).

### 12.5 Sources to adapt

nexscope-ai/ecommerce-skills@ee0fb29 (MIT) `ecommerce-growth-strategy` (intake and unit-economics health check; fix its payback formula, which ignores repeat purchases); alirezarezvani/claude-skills@19392f7 (MIT) `cfo-advisor` (its questions and red flags only; its scripts are not run); bytedance/deer-flow@cb1d782 (MIT) `consulting-analysis` (a hypothesis per section; no invented data); openaccountant/skills@f5abe38 (MIT) `client-profitability` (per-client P&L; replace its revenue-share overhead allocation); KWP `finance/variance-analysis` (price, volume and mix); ecc `council` (the final check). Method references: TOC Institute (five focusing steps); Marn, Roegner and Zawada, "The power of pricing" (McKinsey Quarterly 2003); McKinsey, the seven-step problem-solving process; JPMorgan Chase Institute, "Cash is King"; SPI Research on billable utilisation; Christensen et al., "Know Your Customers' Jobs to Be Done" (HBR 2016); Michalowicz, *Profit First* (a practitioner method, not tested in controlled studies).

## 13. Knowledge architect: what it owns

- **Sources:** which systems feed the brain, each with an owner, an authority level by question type (a policy question trusts the policy document; a status question trusts the latest update), and a freshness rule.
- **Structure:** document types, a glossary of the business's own terms and codenames, chunking by document type, metadata on every chunk (source, date, owner, section, permissions), and supersede chains so an old version points to its replacement.
- **Retrieval:** keyword, vector or hybrid chosen per question type; reranking only after checking the ranking ceiling; citations on every claim; conflicts surfaced, never silently resolved.
- **Access:** results trimmed to what the asking member may see; permissions inherited from the source system; nothing shared across businesses in caches or statistics.
- **Evaluation:** a labelled test set per business, metrics chosen by use, a gain counted only when its confidence interval clears zero, confirmed on held-out questions, and re-run on every retrieval change; a regression beyond the business's threshold blocks the change.
- **Upkeep flows (run mode):** re-index, a monthly stale check, a quarterly accuracy audit, dedup with a list of what must not be merged (different conclusions, versions over time).

## 14. Phases

| Phase | What | Depends on |
|---|---|---|
| P0 | This spec agreed; the words in section 3 used everywhere | Jase |
| P1 | Floki's router becomes a classifier with visible handoffs | spec 11 |
| P2 | The skill loader in Floki; the doctor and draft skills, each with an eval and a failing baseline | P1 |
| P3 | In-app tools from a block chat, on the widget kit | P1 |
| P4 | Design and run modes as permission profiles; run steps pinned to `team@version/role` | spec 13, spec 16 addendum |
| P5 | AI teammates (M5's first item, a-132) on the one action list | spec 01 M5 |
| P6 | Hosted runs: Managed Agents (R2), then the provider-neutral sandbox runner (section 8) | P4 |
| P7 | Catalog and presets; onboarding questions; forks that track their source; the service preset proven on Jase's service business first | P4 |
| P8 | Specialists one at a time: Architect team (spec 15 orders it), Knowledge architect, Business consultant, Team designer, App builder | P2, P6 |
| P9 | Bring-your-own skills: private tier, then the shared catalog process | P2 |

## 15. Not taken

From the reviews behind this spec: ECC's hooks (on by default when installed as a plugin, including a log of every tool's input and output), its self-rewriting skills, auto-update to latest, timed auto-approval and a merge queue that pushes main; gstack's autoplan and one-step ship flow; superpowers' session-start hook; any skill under a non-commercial license.

## 16. Open questions for Jase

- **Hosting:** keep Managed Agents first and add the Cloudflare sandbox runner after it (section 8.4)? Its price and alpha status need checking first.
- **Interview:** the Business consultant's first run is an interview with Jase (twelve questions, per business), and Jase's numbers stay in his businesses, never in the catalog.
- **Apps:** who may install an app a person built in one business into another; whether apps can be shared to the app store with the same three tiers as skills (private, shared, verified).
- **Brought AI teammates as team members:** may a brought AI hold a member role in a team's run-mode work (assigned tasks), or only design-mode help?

## 17. Sources

- OS Flow code and specs: `app/src/domain/aiEdit/*.ts`, `app/functions/ai/_lib/*.ts`, `flokiRoute.ts`, `app/bridge/claude.ts`, spec 01, 06, 11, 12, 13, 15, 16; MEMORY.md and `memory/vision-and-knowledge.md`, `memory/runs-and-bridge.md` on branch `fix/r50-derivations` at 9b9abc51 (2026-10-20); `routine/M3C-M4-PLAN.md`.
- Anthropic Claude API reference (Agent Skills on the Messages API; the Claude Agent SDK), read 2026-10-18.
- OpenAI: the Skills guide (developers.openai.com/api/docs/guides/tools-skills) and the Agents SDK sandbox Skills capability, read 2026-10-19.
- Anthropic: Claude Code "Legal and compliance" (code.claude.com/docs/en/legal-and-compliance), read 2026-10-20. Kylon: "How Kylon connects your agents and tools" (kylon.io/blog/how-kylon-connects-agents-and-tools). Dify: DifySandbox docs (docs.dify.ai/development/backend/sandbox).
- Cloudflare: Workers limits (developers.cloudflare.com/workers/platform/limits), Sandboxes and the Claude Managed Agents template (developers.cloudflare.com/sandbox/tutorials/claude-managed-agents/), read 2026-10-20.
- Salesforce's 2026 product line: Forrester on Dreamforce 2026; Certinia PSA product pages; TechTarget on Salesforce's SMB suites.
- Skill repos at the commits named in sections 10 to 12. The ECC count of 1,062 SKILL.md files includes translations and harness copies; 311 are distinct skills.
