# Handoff: Agent Teams session, 2026-10-26

From session_01T2JJHH3gGRRRGEBzUto9bn ("Agent teams and skill building"), closed for cost and context. The next session starts here. Owner: Jase. Write to him in plain US English, no em dashes, short, with a recommendation first.

## What this session owns

- **Agent-Teams** (`yeunglee95-gif/Agent-Teams`): the `dev-team` and `design-team` plugins.
- **Floki and teams spec** for OS Flow: `docs/handoff/os-flow-floki-teams-and-agents.md` on branch `handoff/os-flow-floki-teams`, last commit d850114. §13.1 covers the privacy layer, department brain sections and the finance flow.
- **Geniotek business consultation** in Claude-OS: `Geniotek/reports/Business Consultation 2026-10-21.md`, revision 4, last commit 402b100. Claude-OS is being untangled (a-171), so this folder may move into Geniotek's own repository.
- **Messages to OS Flow.** Each message is a one-off scheduled task (create_trigger with persistent_session_id and run_once_at a few minutes out) into the current OS Flow session. Today that is **OS Flow: building the app (5)**, session_01SNEaY4SxYaBRmKnmPMojw1. Check list_sessions before every send, because it hands off to a new session regularly.

## State of the plugins

- **dev-team 0.9.0 and design-team 0.2.1** are merged to main (PR #15, df12426). Part 1 of 0.9 added four things:
  - CI on the reviewed head decides;
  - every review ends with a Coverage line;
  - a command that names tests must run as many as it names;
  - the approval file carries the raw output of every check.
- **`plugins/dev-team/ROADMAP.md`** holds what is planned:
  - 0.9 part 2 (waits on the unlazy verdict);
  - 0.10's breaker, first-time-user mode of the critic, and feedback triager;
  - the per-milestone four-account user round, with the breaker running in parallel and capped so it adds no build time (Jase's condition);
  - the full round before outside users;
  - who pays for which spend.
- **Eval caveat.** On this cloud machine the eval harness runs as root. The sandbox then makes the workspace and `.git` read-only, so `approver-merges-safe` and `reverify-fix-round` fail on the sandbox, not on the roles; 0.8.0 fails them the same way. Re-run both on Jase's laptop. Pass `--trust-plugin` to `claude plugin eval` in cloud runs.

## Open items

1. **0.9 part 2.** Build it when OS Flow closes the unlazy trial. The trial closes with keep, change or drop after its second lane on runnable ledgers; lane 1 closed 2026-10-21. The daily check below handles it.
2. **Jev trial (a-184, accepted).** Jev is the decision-only model for Floki's decision steps. OS Flow put the Jev Router arm in the M4b benchmark and two trials in spec/13 §14.11: email and enquiry triage, and Floki's Build or Edit classifier. Read the results when they land.
3. **Test plan (a-186 and a-187, applied in OS Flow b6464c67).**
   - A user round on the four test accounts every milestone from M4b, with the breaker on the changed parts. It is capped and parallel, and only its blockers and majors are fixed in the milestone.
   - M4b's breaker aims at permissions, separation between businesses and two people editing at once.
   - M5's Review Focus names "AI teammates cannot do more than their role allows".
   - The full breaker and first-time-user round runs after M5, before outside users.
   - Test rounds' in-app AI gets its own cap outside the USD 200 Floki benchmark.
   - Caps are set after the M4b round is measured.
4. **Deletion gap.** Answered for OS Flow on 2026-10-26 at 12:16 UTC: deleting a business leaves its flows and share snapshots behind (their 2026-10-21 privacy audit). Confirm they have a lane for it before outside users.
5. **commercial-legal plugin.** Jase was given the install card on 2026-10-21. If he installed it, he runs the setup interview in Cowork or on desktop:
   - 15-minute version, sales side first;
   - Hong Kong governing law, with Cap. 71 and Cap. 26;
   - the "one thing" deal-breaker: the liability cap and product-liability indemnity on supply agreements, because Geniotek is the seller of record.

   Decided: no outside lawyer; Jase reviews every agreement with the skill as a second reader.
6. **Geniotek, waiting on Jase.**
   - the quote count and loss reason for every quotation sent since April;
   - the share of engineer time spent on quotations;
   - approval of the three-cause delay policy;
   - the Room 88 (The Hardware Store) status. It lives in Google Chat, which this cloud session cannot read.

   Paula Wong's monthly GEN statements are in Gmail and Jase allowed reading them, but the Gmail connector cannot download attachments. Ask him to save them to a Drive folder.
7. **Spec questions still open for Jase:**
   - the hosting option (Managed Agents first, then the Cloudflare sandbox runner);
   - installing apps across businesses;
   - whether a brought AI may hold a member role in run-mode work.

## Scheduled tasks bound to the old session

Two recurring scheduled tasks fire into session_01T2JJHH3gGRRRGEBzUto9bn. Recreate each in the new session with the same prompt and schedule (copy them from list_triggers), then delete the old one once Jase confirms:

- `trig_016to1qDVSPF6oKCqTbUqG7B`, **Check unlazy verdict, then build dev-team 0.9 part 2**: daily at 08:41 Hong Kong time, stops itself on a verdict or on 2026-11-15.
- `trig_01M2CaujbEttfF1tUiLbEoLN`, **Weekly token report**: Mondays at 08:55 Hong Kong time. Last report 2026-10-26: about USD 4,020 across 12 sessions. Every session ran claude-opus-5-5. The flags were OS Flow (5) at 779K context and this session.

## Standing rules learned here

- No PR or merge without Jase's explicit go. Do not put model ids in commits or PRs. Commits end with the Co-Authored-By and Claude-Session trailers.
- Jase's business numbers never go into OS Flow's catalog; only the pattern does.
- Ask "why" before recommending a fix to something deliberate (Phase 1 is underpriced on purpose, for the portfolio). Lead with a recommendation, show the reasoning, and push back when the logic is weak.
- Check dates against the system date, never the user's time zone, after the 2026-10-21 date slip.
