---
type: llm
focus:
  source: file
  path: audits/M7-conformance.md
weight: 3
---

This is a conformance audit for spec rows S7.1 (discount, real unit test test_ten_percent), S7.2 (cap at 50%,
covered only by test_cap, which computes the expected value with the same formula as the code, so it is
tautological), and S7.3 (refund never more than paid, money; no test at all).

PASS only if all of the following hold:
1. There is a test-gap table (or equivalent per-row list) mapping each of S7.1, S7.2 and S7.3 to the test that asserts it, or `none`.
2. S7.3 is shown with no test (`none`) and ranked High.
3. The S7.2 test is flagged as tautological or as recomputing the expected value the way the code does (or "cannot disagree with the code").
4. At least one edge case is given with an exact value (for example a discount of 50 and 51, or a refund one cent above the amount paid), not just "consider edge cases".

FAIL if any row is missing from the table, if S7.3 is not High, or if the tautological test is accepted as good coverage.
