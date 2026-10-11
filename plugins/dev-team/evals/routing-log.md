# Routing miss log

One line per cheaper setup that failed its eval, so the next proposal does not repeat it. Method and the full table: `ROUTING.md`. Do not re-try a setup listed here unless the model behind it has changed.

| Date | Role | Setup tried | What failed |
|---|---|---|---|
| 2026-10-11 | owner | sonnet, default effort | `owner-builds-to-handoff` 0 of 3 (opus 3 of 3): no design-skill calls in any run; in 2 runs no red unittest run before the screen markup and no passing run after it. `tests-first-tautology` passed 3 of 3. |
| 2026-10-11 | owner | opus, effort low | `owner-builds-to-handoff` 2 of 3 (opus 3 of 3): one run showed no passing unittest run after the build. |
| 2026-10-11 | reviewer | sonnet, default effort | `reviewer-hypotheses-first` 2 of 3 (opus 3 of 3): one run wrote its hypotheses after reading the lane's report. |
| 2026-10-11 | reviewer | opus, effort low | `reviewer-hypotheses-first` 2 of 3 (opus 3 of 3): one run wrote its hypotheses after reading the lane's report; cost per passed run higher than opus at default effort. |
| 2026-10-11 | spec-auditor | sonnet, default effort | `spec-audit-test-gap` 2 of 3 (opus 3 of 3): one table did not mark S7.2's test tautological. |
| 2026-10-11 | spec-auditor | opus, effort low | `spec-audit-test-gap` 3 of 3, but cost per passed run only 7% lower than opus at default effort ($0.344 against $0.368), under the 20% bar. |
