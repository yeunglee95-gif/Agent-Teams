# Routing: why each role runs on what

The one home for each dev-team role's `model` and `effort`, and the evidence behind them. Agent files carry the setting; this file says why. Failed cheaper setups go in the miss log next to it, `routing-log.md`.

Measured 2026-10-11 on Claude Code 2.1.296, for dev-team 0.5.0; bake-offs for 0.6.0 under "Bake-offs". Scope approved by the owner (Jase) on 2026-10-11.

## Method

- **Which case exercises which role.** Most cases run the role's skill in the eval's main session ("You are the dev team's reviewer..."), so the session's model is the role's model there. Seven cases launch the role as a subagent with the Agent tool (`owner-builds-to-handoff`, `claim-before-lane`, from 0.6.0 `combined-findings` and the three `approver-*` cases, and from 0.7.0 `reverify-fix-round`), so the agent file's frontmatter sets the model there.
  | Role | Cases | How the role runs |
  |---|---|---|
  | architect | `grill-the-plan-asks`, `slice-the-plan-lanes`, `design-it-twice` | main session (design-it-twice also starts general-purpose sub-agents, which inherit the session model) |
  | owner | `owner-builds-to-handoff`, `tests-first-tautology`, `claim-before-lane` | subagent, main session, subagent |
  | fixer | `root-cause-red-first` | main session |
  | reviewer | `reviewer-hypotheses-first`, `combined-findings` (0.6.0), `reverify-fix-round` and `lowering-moves` (0.7.0) | main session, subagent, subagent, main session |
  | spec-auditor | `spec-audit-test-gap` | main session |
  | scribe | `run-retro-proposes`, `retro-cost-view` | main session |
  | gate-runner | `release-no-merge` | main session |
  | approver | `approver-escalates-red`, `approver-merges-safe`, `approver-off-never-merges` (0.6.0) | subagent |
  | critic, security-reviewer, repo-auditor | none | |
- **Changing the model.** For main-session cases, `claude plugin eval --model <model>`: the harness starts each run as `claude -p ... --model=<model>`, and the trace's `init` record and every assistant message name the model (`claude-opus-5-5` or `claude-sonnet-5-5`). Without `--model` the harness runs the main session on `claude-sonnet-5-5`, so the suite results before 0.5.0 measured the main-session roles on sonnet, not on the `opus` their agent files named. `--model` also reaches sub-agents that inherit the session model (design-it-twice's sub-agents ran on opus under `--model opus` and on sonnet under `--model sonnet`), but it does not override a subagent whose frontmatter names a model: in `owner-builds-to-handoff` the main session ran on sonnet and the owner subagent on `claude-opus-5-5`. For subagent cases, a scratch copy of the plugin outside the repo with only that role's `model` or `effort` changed, passed as the eval target; the trace's subagent messages (those with a `parent_tool_use_id`) then named `claude-sonnet-5-5`.
- **Changing effort.** For a subagent, `effort: low` in the scratch copy's frontmatter. For a main-session case, the environment variable `CLAUDE_CODE_EFFORT_LEVEL=low` on the eval command, which reached each run (seen in the run process's environment). The trace does not name the effort; the thinking-token estimates in the trace fell against opus at the default (reviewer from 656 to 1456 per run down to 0 to 216; spec-auditor from 1290 to 2080 down to 643 to 1085), so the setting took.
- **Arms.** Current setup against `sonnet` at default effort, 3 runs each; where sonnet failed, `opus` with `effort: low` where it was cheap to test. Promising candidates re-ran 3 more runs on both arms, for 6 each. Judge `sonnet` for the few judge questions.
- **Decision rule.** Switch only if, on the same runs, the candidate passes at least as often as the current setup and its cost per passed run (sum of each run's `costUsd` in the eval JSON over the passed runs) is at least 20% lower. Otherwise keep the current setup. A role with no case keeps its setting, marked "no eval evidence".

## Results

| Role | Current | Candidate | Passes (current, candidate) | Cost per passed run (current, candidate) | Decision |
|---|---|---|---|---|---|
| architect | opus | sonnet | 18 of 18, 18 of 18 (grill 6, 6; slice 6, 6; design-it-twice 6, 6) | $0.548, $0.236 (57% lower) | sonnet in 0.5.0; back to opus in 0.5.1; **opus confirmed by the plan bake-off (0.6.0)** |
| fixer | opus | sonnet | 6 of 6, 6 of 6 | $0.285, $0.111 (61% lower) | sonnet with step-up (0.5.2); **from 0.6.0 by the row's Kind: `behavior` on opus, `surface` on sonnet with the step-up**, see "Bake-offs" |
| scribe | opus | sonnet | 6 of 6, 6 of 6 | $0.351, $0.137 (61% lower) | **sonnet** |
| owner | opus | sonnet | 6 of 6, 3 of 6 (owner-builds-to-handoff 3, 0; tests-first-tautology 3, 3) | $0.465, $0.305 | keep opus |
| owner | opus | opus, effort low | owner-builds-to-handoff 3 of 3, 2 of 3 | $0.761, $0.621 | keep opus |
| reviewer | opus | sonnet | 3 of 3, 2 of 3 | $0.395, $0.221 | keep opus |
| reviewer | opus | opus, effort low | 3 of 3, 2 of 3 | $0.395, $0.529 | keep opus |
| spec-auditor | opus | sonnet | 3 of 3, 2 of 3 | $0.368, $0.238 | keep opus |
| spec-auditor | opus | opus, effort low | 3 of 3, 3 of 3 | $0.368, $0.344 (7% lower) | keep opus |
| gate-runner | sonnet | none tested | | | keep sonnet |
| critic | opus | none | | | keep opus, no eval evidence |
| security-reviewer | opus | none | | | keep opus: judgment role, no cost test (0.6.0) |
| approver | opus | none | | | opus: judgment role, no cost test (new in 0.6.0) |
| repo-auditor | opus | none | | | keep opus, no eval evidence |

No role sets `effort`; every role runs at the session's effort (medium by default on the 5.5 models).

What failed, in short: the owner on sonnet skipped both design-skill calls in all 3 runs and, in 2 of them, showed no red run before the screen markup and no passing run after it; the owner on opus at low effort missed the passing run after the build once; the reviewer on sonnet and on opus at low effort each wrote its hypotheses after reading the lane's report once; the spec-auditor on sonnet left the tautological test unflagged in its table once. Each is a line in `routing-log.md`.

After the switch, the full suite (main sessions on sonnet, 3 runs each) scored 33 of 36. One miss was the architect's: a `design-it-twice` run whose comparison named where the seam goes but did not compare the designs on it, which the judge failed on all three votes. Three more sonnet runs passed 3 of 3, so the architect on sonnet stands at 11 of 12 on that case in this pass (opus 6 of 6). The other two misses were the reviewer (findings judge) and the spec-auditor (S7.2 not marked tautological) running on sonnet, the setups the table above keeps them off.

Limits: 3 to 6 runs per arm is a small sample, and the main-session cases test a role's skills on a model, not the role's own agent text. The decisions hold for these cases on this version; a role whose eval misses grow on its new setting goes back to its old one.

### Independent check

Independent check by the lead session on 2026-10-11, same Claude Code version: the architect's cases on sonnet, `design-it-twice` 6 of 6, `grill-the-plan-asks` 6 of 6, `slice-the-plan-lanes` 6 of 6; `claim-before-lane` 3 of 3 and `retro-cost-view` 3 of 3; 24 of 24 for $5.34. With this, the architect on sonnet stands at 17 of 18 on `design-it-twice` across both checks.

## Held pending plan quality (0.5.1)

On 2026-10-11 the owner put the architect back on opus. The architect's three cases check that it follows its process (questions, the lane table, design-it-twice structure), not whether its plans are good, and a weak plan costs far more downstream than the planning tokens save. The 20% cost rule does not fit a judgment role on its own. The architect stays on opus until a plan-quality bake-off on real past milestones (hindsight recall against what reviews later found, and a blind pairwise comparison) shows sonnet is at least as good. The bake-off result and its decision are recorded here when it lands.

## Fixer step-up (0.5.2)

On 2026-10-11 the owner kept the fixer on sonnet with a built-in step-up: after one failed repair, the next attempt on that finding runs on opus for that one subagent call, never by switching the session's model; a second failure goes to the owner. Why this fits the fixer and not the architect: every fix is checked hard (its test must turn green, the gate runs, the reviewer re-verifies), so a weak sonnet fix is caught and costs one retry, while a weak plan looks fine until later. The fixer's one eval case is a single small bug, so a fixer bake-off on real past findings with known fix commits is running to measure first-try pass rates and, above all, silent failures (the test passes but the cause is wrong), which a step-up cannot catch. Its result is recorded here when it lands.

## Bake-offs (0.6.0)

Run 2026-10-11 and 2026-10-12 on real past OS Flow milestones and findings, Claude Code 2.1.296; about $75. They settle the two items held above.

**Architect, plan quality.** Four past milestones, three plans per model each (24 plans), from the milestone's brief at its start commit. Hindsight recall (the share of ten issues that reviews later found which the plan foresaw, judged per issue): opus 0.46, sonnet 0.48, within noise (sd 0.12 and 0.10). Blind pairwise judging, each pair in both orders by an opus judge: opus 7, sonnet 4, 1 tie; each milestone but one went to opus. Opus plans more often carried the `blocked-by:` column (9 of 12 against 3 of 12) and a red-test column per lane (4 of 12 against 1 of 12). Cost per plan $2.39 against $0.84. A second blind judge (a different model, given no context) judged three of the pairs in both orders and agreed with the opus judge on every pair in both. Decision: **the architect stays on opus.** A plan's misses show up only in the build, and the head-to-head and the plan structure favour opus; the $1.55 a plan is small against one wasted lane. Open item for the next retro: only 3 of 24 plans used the exact lane-table header the `slice-the-plan` skill asks for (all three opus), so the skill's table is not landing; the eval case passes because it checks a looser shape.

**Fixer, first-try fixes.** Five past findings with known fix commits, three runs per model each (30 runs), each graded by the real fix's held-back test and a root-cause check against the fix commit. True cause fixed and the proving check passed: opus 9 of 15, sonnet 6 of 15 (sonnet's first-try pass was 7 of 15, one of which fixed the symptom). The gap is in findings about what the code does: on a finding whose review prescribed the wrong fix (a seed edit, where the engine was the cause), opus fixed the engine 3 of 3 and sonnet followed the prescription 0 of 3, a failure the gate cannot see when the prescribed check passes. On copy and naming findings (duplicate i18n keys, a banned term on a surface) the two passed at the same rate and sonnet cost about a fifth. Cost per run $1.43 against $0.35. Both models sometimes turned a ruling test green by adding an exception or editing the rule instead of fixing the code (opus 3 runs, sonnet 2). Decisions: **the combined table gains a Kind column (`behavior` or `surface`); a `behavior` row's fixer runs on opus from the first attempt, a `surface` row on sonnet with the 0.5.2 step-up**; and an exception, allow-list or baseline entry, or narrowed rule added to a ruling test is not a fix without the architect's sign-off, which the reviewer checks on re-verify (the loop page, Limits on fixing).

Limits: four milestones and five findings from one app, three runs a cell; the recall measure is coarse and the judges are models. Re-run when the models change (When to re-test).

## Judgment roles (0.6.0)

On 2026-10-11 the owner set the security-reviewer and the new approver on `opus` as judgment roles, with no cost test. The security-reviewer now runs on every milestone, in the Review stage, and a missed hole costs far more than its tokens. The approver decides APPROVE or ESCALATE and, where an app turns auto-merge on, merges; a wrong call there lands on main. Like the architect (Held pending plan quality), the 20% cost rule does not fit a role whose mistakes show up only later. The approver's three cases check that it follows its policy (escalate a protected path, merge a safe change and confirm it, never merge with auto-merge off), not whether a cheaper model would weigh the evidence as well, so they are not a cost test.

## When to re-test

- The settings in this file were measured once and are fixed per role; nothing is re-tested per task.
- Re-test when a new model ships behind an alias the roles use (`opus`, `sonnet`): run the full dev-team suite once at 3 runs per case on the new model. If the pass rates hold, keep every setting. If a role on a cheaper tier starts failing, move just that role up a tier. If the new model is clearly better or cheaper, re-test only the roles near the line.
- Effort defaults can change between model generations, and the same suite run covers that.
- Otherwise, re-test a role only when run-retro proposes it with evidence and the owner approves. Never re-try a setup that is in the miss log unless the model has changed.

## How to re-run an arm

From the repo root, for a main-session case:

```
claude plugin eval plugins/dev-team --case <case> --runs 3 --model <model> --scaffold --allow-tools Bash Write Edit Agent --ablation none --judge-model sonnet --no-publish --keep-temp --max-cost-usd <cap> --json <out>.json
```

Add `CLAUDE_CODE_EFFORT_LEVEL=<level>` before the command for an effort arm. For a subagent case, copy `plugins/dev-team` outside the repo, change only that role's `model` or `effort`, and pass the copy as the target. Read the model from the trace (`--keep-temp` keeps it; the JSON's `tracePath` points to it) and the cost from each run's `costUsd`.
