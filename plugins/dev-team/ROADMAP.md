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

## When each runs on OS Flow

- **Breaker and first-time user:** in the closing gauntlet after M4b, on the four test accounts, with their own budget beside the Floki benchmark's USD 200.
- **Feedback triager:** once outside users sign up (after w-079), reading PostHog and Microsoft Clarity, and the feedback inbox.
