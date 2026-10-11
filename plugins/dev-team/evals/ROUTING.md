# Routing: why each role runs on what

The one home for each dev-team role's `model` and `effort`, and the evidence behind them. Agent files carry the setting; this file says why. Failed cheaper setups go in the miss log next to it, `routing-log.md`.

Measured 2026-10-11 on Claude Code 2.1.296, for dev-team 0.5.0. Scope approved by the owner (Jase) on 2026-10-11.

## Method

- **Which case exercises which role.** Most cases run the role's skill in the eval's main session ("You are the dev team's reviewer..."), so the session's model is the role's model there. Two cases launch the role as a subagent with the Agent tool (`owner-builds-to-handoff`, `claim-before-lane`), so the agent file's frontmatter sets the model there.
  | Role | Cases | How the role runs |
  |---|---|---|
  | architect | `grill-the-plan-asks`, `slice-the-plan-lanes`, `design-it-twice` | main session (design-it-twice also starts general-purpose sub-agents, which inherit the session model) |
  | owner | `owner-builds-to-handoff`, `tests-first-tautology`, `claim-before-lane` | subagent, main session, subagent |
  | fixer | `root-cause-red-first` | main session |
  | reviewer | `reviewer-hypotheses-first` | main session |
  | spec-auditor | `spec-audit-test-gap` | main session |
  | scribe | `run-retro-proposes`, `retro-cost-view` | main session |
  | gate-runner | `release-no-merge` | main session |
  | critic, security-reviewer, repo-auditor | none | |
- **Changing the model.** For main-session cases, `claude plugin eval --model <model>`: the harness starts each run as `claude -p ... --model=<model>`, and the trace's `init` record and every assistant message name the model (`claude-opus-5-5` or `claude-sonnet-5-5`). Without `--model` the harness runs the main session on `claude-sonnet-5-5`, so the suite results before 0.5.0 measured the main-session roles on sonnet, not on the `opus` their agent files named. `--model` also reaches sub-agents that inherit the session model (design-it-twice's sub-agents ran on opus under `--model opus` and on sonnet under `--model sonnet`), but it does not override a subagent whose frontmatter names a model: in `owner-builds-to-handoff` the main session ran on sonnet and the owner subagent on `claude-opus-5-5`. For subagent cases, a scratch copy of the plugin outside the repo with only that role's `model` or `effort` changed, passed as the eval target; the trace's subagent messages (those with a `parent_tool_use_id`) then named `claude-sonnet-5-5`.
- **Changing effort.** For a subagent, `effort: low` in the scratch copy's frontmatter. For a main-session case, the environment variable `CLAUDE_CODE_EFFORT_LEVEL=low` on the eval command, which reached each run (seen in the run process's environment). The trace does not name the effort; the thinking-token estimates in the trace fell against opus at the default (reviewer from 656 to 1456 per run down to 0 to 216; spec-auditor from 1290 to 2080 down to 643 to 1085), so the setting took.
- **Arms.** Current setup against `sonnet` at default effort, 3 runs each; where sonnet failed, `opus` with `effort: low` where it was cheap to test. Promising candidates re-ran 3 more runs on both arms, for 6 each. Judge `sonnet` for the few judge questions.
- **Decision rule.** Switch only if, on the same runs, the candidate passes at least as often as the current setup and its cost per passed run (sum of each run's `costUsd` in the eval JSON over the passed runs) is at least 20% lower. Otherwise keep the current setup. A role with no case keeps its setting, marked "no eval evidence".

## Results

| Role | Current | Candidate | Passes (current, candidate) | Cost per passed run (current, candidate) | Decision |
|---|---|---|---|---|---|
| architect | opus | sonnet | 18 of 18, 18 of 18 (grill 6, 6; slice 6, 6; design-it-twice 6, 6) | $0.548, $0.236 (57% lower) | **sonnet** |
| fixer | opus | sonnet | 6 of 6, 6 of 6 | $0.285, $0.111 (61% lower) | **sonnet** |
| scribe | opus | sonnet | 6 of 6, 6 of 6 | $0.351, $0.137 (61% lower) | **sonnet** |
| owner | opus | sonnet | 6 of 6, 3 of 6 (owner-builds-to-handoff 3, 0; tests-first-tautology 3, 3) | $0.465, $0.305 | keep opus |
| owner | opus | opus, effort low | owner-builds-to-handoff 3 of 3, 2 of 3 | $0.761, $0.621 | keep opus |
| reviewer | opus | sonnet | 3 of 3, 2 of 3 | $0.395, $0.221 | keep opus |
| reviewer | opus | opus, effort low | 3 of 3, 2 of 3 | $0.395, $0.529 | keep opus |
| spec-auditor | opus | sonnet | 3 of 3, 2 of 3 | $0.368, $0.238 | keep opus |
| spec-auditor | opus | opus, effort low | 3 of 3, 3 of 3 | $0.368, $0.344 (7% lower) | keep opus |
| gate-runner | sonnet | none tested | | | keep sonnet |
| critic | opus | none | | | keep opus, no eval evidence |
| security-reviewer | opus | none | | | keep opus, no eval evidence |
| repo-auditor | opus | none | | | keep opus, no eval evidence |

No role sets `effort`; every role runs at the session's effort (medium by default on the 5.5 models).

What failed, in short: the owner on sonnet skipped both design-skill calls in all 3 runs and, in 2 of them, showed no red run before the screen markup and no passing run after it; the owner on opus at low effort missed the passing run after the build once; the reviewer on sonnet and on opus at low effort each wrote its hypotheses after reading the lane's report once; the spec-auditor on sonnet left the tautological test unflagged in its table once. Each is a line in `routing-log.md`.

After the switch, the full suite (main sessions on sonnet, 3 runs each) scored 33 of 36. One miss was the architect's: a `design-it-twice` run whose comparison named where the seam goes but did not compare the designs on it, which the judge failed on all three votes. Three more sonnet runs passed 3 of 3, so the architect on sonnet stands at 11 of 12 on that case in this pass (opus 6 of 6). The other two misses were the reviewer (findings judge) and the spec-auditor (S7.2 not marked tautological) running on sonnet, the setups the table above keeps them off.

Limits: 3 to 6 runs per arm is a small sample, and the main-session cases test a role's skills on a model, not the role's own agent text. The decisions hold for these cases on this version; a role whose eval misses grow on its new setting goes back to its old one.

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
