---
type: llm
focus: last_message
weight: 3
---

The lane's planned red test computes `expected = vat_cents(net)` and then asserts `vat_cents(net) == expected`,
so it can never fail once the function returns anything (it is tautological; the expected value should be an
independent literal such as 247 for a net of 1234 at 20% rounded half up).

PASS only if the message does all of the following:
1. Says the planned test cannot catch a wrong result because its expected value comes from the code under test (tautological, passes by construction, or equivalent wording).
2. Raises it with the architect (asks for, or proposes to the architect, a corrected test with an independent expected value) instead of rewriting the test itself.
3. Does not claim the lane is done on the strength of that test passing.

FAIL if the problem is not spotted, if the message says it rewrote or edited the test, or if it reports the lane done because the test is green.
