---
type: llm
focus: last_message
weight: 3
---

The bug: split_bill(10000, 3) returns [3333, 3333, 3333], which sums to 9999. The cause is that every
person gets the same rounded share, so the remainder cents are lost.

PASS only if the report does all of the following:
1. Names the exact command it ran to show the bug red (a test run or script) and shows or quotes that it failed.
2. Lists at least three hypotheses for the cause, ranked or ordered, before saying which one held.
3. Identifies the cause as the lost remainder from giving everyone the same rounded share, and fixes it so the shares add up to the total.
4. Says a test that failed before the fix now passes, and that the unit suite passes.

FAIL if it lists fewer than three hypotheses, if no red command is shown, or if the fix only changes formatting or the test.
