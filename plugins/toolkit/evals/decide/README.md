# Replay test for `decide`

Checks whether a model picks what Jase actually picked, with the skill and without it.

- `cases.jsonl`: held-out past asks, one per line: `id`, `date`, `context`, `question`, `options` (`key`, `text`), `recommended` (what he was shown), and the hidden `pick` and `reason`. Only cases where he gave a reason; overrides are kept on purpose. None of these may appear as evidence in `skills/decide/principles.md`.
- `run.py`: runs both arms and scores them. See its header for backends: a command (`codex exec -`, `claude -p`), the OpenAI API, or prompt files for a model run elsewhere, such as Claude's Agent tool.
- `RESULTS.md`: the numbers from each run, with the date, model and case count. Raw answers land in `results/`, which is not committed.

Agreement is reported overall and on overrides alone, because a model that always takes the recommendation scores well overall and zero on overrides.
