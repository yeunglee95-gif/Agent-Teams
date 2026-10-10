---
type: tool_order
before:
  tool: Write
  input_match: '"file_path":"[^"]*reviews/[^"]*".*[Hh]ypothes'
after:
  tool: Read
  input_match: 'LANE-REPORT'
weight: 2
---

The reviewer wrote its own hypotheses into the review file before opening the lane's report.
