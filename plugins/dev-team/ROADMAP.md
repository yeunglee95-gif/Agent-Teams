# dev-team roadmap

What is planned and not built. Shipped work is in `CHANGELOG.md`; nothing here is in any role yet.

## 0.9 part 2: waits on the unlazy trial

After OS Flow's second lane on a runnable ledger closes the trial with keep, change or drop:

- Runnable lane ledgers, with unlazy pinned at 1667149 (if keep).
- A three-way bake-off on one real milestone: a plain session, a session with unlazy, and the full team.

## 0.10: agents that keep improving an app after it ships (Jase, 2026-10-25)

These three run once an app has a build people can use: a preview with test accounts for the first two, and real users for the third. They are not part of every milestone.

### Breaker (new role)

Its job is to break the running app on purpose before real users do. It works on a preview or staging build with the test accounts, never on live data. It probes:

- **Inputs:** empty, very long, unicode, Chinese, emoji, pasted rich text.
- **Timing:** double submits, two tabs editing one thing, a refresh mid-save.
- **Network:** offline, slow, a request cut off halfway.
- **Size:** very large flows and lists.
- **Permissions:** a lower role trying a higher role's action, through both the screen and the API.
- **Performance:** measured against the app's budget.

Each finding comes with steps that reproduce it and goes into the combined findings table, like the critic's. Here is how it differs from the others:

- The **security-reviewer** reads code.
- The **critic** behaves like a reasonable person.
- The **breaker** behaves like an unlucky or careless one, at volume.

It never runs a load test or touches anything live without the owner's go.

### First-time user (a mode of the critic, not a new role)

A fresh account with the lowest role and no prior state, given only a goal, with no docs and no help from anyone. Its tools are the browser only: no code, no admin and no API.

It reports the **error-free session** rate: the share of sessions with no error shown, no dead end (several steps with no progress), and no loop back to a screen it already left. It also reports the time to first success.

This is a mode of the critic, not a separate role, because the critic already works black-box from the screen. What it adds is the restricted account and the session metric.

### Feedback triager (new role, Watch stage)

It reads feedback from:

- the app's analytics tool (PostHog: session replays, rage clicks, errors);
- the error log;
- in-app feedback;
- the support inbox.

It groups duplicates and sorts each item as bug, usability, feature request or noise. It ranks items by severity and how many people each one reaches. Sorting is a typed decision, which a decision model such as Jev could make cheaply.

Then it routes them:

- **Simple bugs** become a ready-to-fix item, with steps that reproduce the bug and a proposed red test.
- **Everything else** goes to the owner's desk, ranked.

A simple bug is fixed only through the loop: fixer, gate, review, approver, with auto-merge only where the app opted in. Two rules on the loop page change only by the owner's decision, recorded in the app's `CLAUDE.md`:

- Watch findings go to the backlog, never straight to ready. Letting triage move a "simple bug" to ready is a standing rule the owner turns on per app.
- No role patches code outside the loop. The triager never fixes anything itself.

### Per-milestone user round (Review stage, Jase, 2026-10-25)

Every milestone that changes something a person can see or do gets a user round, scoped to what it changed. A milestone with no such change skips it, and the plan says so in one line.

1. **Scenario.** The architect writes a short scenario from the plan:
   - which features changed;
   - which roles touch them;
   - two or three real tasks that pass between accounts. For example: the Owner invites, the Editor builds and publishes, the Commenter leaves a note, an approval reaches the right person, and the newest invitee finds their way in.
2. **Four accounts, four people.** Each test account is played by its own critic persona, a different kind of user in a different role. They use the preview build only through the screen, on every target and in every language the app ships. Each records what they expected against what happened, with screenshots.
3. **Design on real use.** The design-auditor reviews each role's screenshots from the round, so the same screen is checked as an Owner and as a Viewer sees it.
4. **Breaker on the changes.** The breaker attacks what the milestone changed and the plan's Review Focus list, not the whole app. It runs at the same time as the other reviews in the Review stage, so it adds no wall-clock time beyond the slowest of them, and it stops at its usage cap. Its blockers and majors are fixed in the milestone's fix rounds; its minors go to the backlog and never hold the milestone.
5. **Findings.** Everything goes into the combined findings table and the normal fix rounds. Each persona reports its error-free session rate, so the trend shows across milestones.
6. **Breaks become tests.** Every fixed breaker finding keeps its test in the suite, so later milestones re-check it for free in the gate.
7. **First-time user mode** runs only when the milestone changes the first-run path: onboarding, empty states, the business home, sign-up or invites.

The round has a usage cap per milestone, set from the first measured round. When it stops at the cap, its Coverage line says what it did not reach.

### Full round before outside users

Once most of the app is built, the full breaker and first-time-user round runs across the whole app, before any outside user signs up. A launch waits for this round and its fixes; the round is never squeezed to keep a launch date.

### Why per milestone and not only at the end (evaluated 2026-10-25)

Per milestone costs more in testing tokens, about three rounds against one. It costs less in fixing:

- a defect found days after its code was written is fixed inside that milestone's fix rounds;
- one found weeks later touches old code, needs re-review and re-testing, and later work may already be built on it (AI teammates use the same role checks as people).

Per milestone also spreads about half a day across each milestone, instead of one to two weeks bunched before the launch target. Testing only at the end wastes less effort on screens that will change again, so it still suits pure look-and-feel polish; the full round covers that.

### Who pays

- **The testing agents** (personas, breaker, design-auditor) run as Claude Code sessions on the owner's Claude plan. On a subscription their cost is usage limits and waiting time, not a bill, unless the owner moves to API billing or buys extra usage.
- **The app's own AI** (Floki, AI steps in a flow), when a test account uses it, is billed to the app's model account (OpenRouter for OS Flow). Test rounds get their own cap on that account, separate from any benchmark budget, so a test round never spends a benchmark's credit.

## When each runs on OS Flow (Jase, 2026-10-25)

- **Every milestone from M4b:** the per-milestone user round on the four test accounts, with the breaker on the milestone's changes (Jase, 2026-10-25, on the condition that it adds no build time and never delays a milestone or the launch to the team).
- **M4b's breaker** aims at permissions, separation between businesses and two people editing at once inside that milestone's round, instead of a separate pass, because M5's AI teammates build on the same role checks. M5's Review Focus names "AI teammates cannot do more than their role allows".
- **After M5, before outside users:** the full breaker and first-time-user round across the whole app. Launch waits for it.
- **From launch (after w-079):** the feedback triager, reading PostHog, Microsoft Clarity, the error log and the feedback inbox.
- **Money:**
  - The USD 200 of OpenRouter credit stays for the Floki benchmark.
  - Test rounds' in-app AI gets its own cap on the same account.
  - The testing agents run on Jase's Claude plan.
  - The M4b round is measured first (agent usage and in-app AI spend, separately), and the caps are set from it.
