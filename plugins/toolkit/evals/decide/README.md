# Replay test for `decide`

Checks whether a model picks what the owner actually picked, with the skill and without it. **The cases, the owner's principles and overrides, and the results all stay in the project**, because they quote the owner's reasons; this folder holds only the runner.

- **Inputs**, in the project's `context/decide/` (or any folder passed as `--context`): `principles.md`, `overrides.md` and `cases.jsonl`. The case fields are in `run.py`'s header. Hold out only cases where the owner gave a reason, keep overrides in on purpose, and never cite a held-out case as evidence in `principles.md`.
- **Backends**: a command (`codex exec -`, `claude -p`), the OpenAI API, or prompt files for a model run elsewhere, such as Claude's Agent tool, scored afterwards with `run.py score`.
- **Scores** are reported overall and on overrides alone, because a model that always takes the recommendation scores well overall and zero on overrides. Record each run's date, model and case count in the project.
