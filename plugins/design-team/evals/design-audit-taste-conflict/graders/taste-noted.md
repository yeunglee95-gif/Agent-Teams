---
type: llm
focus:
  source: file
  path: design-reports/M9-design-audit.md
weight: 3
---

Design audit report for M9. Facts: the app's DESIGN.md (Motion section) says buttons never scale, shrink or move when pressed; the pressed state is a darker color only, by the owner's call. The lead pointed at emil-design-eng's guidance that buttons should scale to about 0.97 on press. The one real defect is the literal color #6b7280 on the due date (.reminder-date), which is not a token.

PASS only if all of the following hold:
1. The missing press scale on buttons is NOT reported as a finding (no finding with a severity says buttons should scale, or that the lack of press scale is a problem to fix).
2. The report notes the press-scale preference as a conflict between the skill's taste and DESIGN.md, settled by DESIGN.md (for example in a "Taste conflicts (noted, not findings)" section), citing DESIGN.md's Motion section or the owner's call.
3. The stray color #6b7280 is reported as a finding with a severity.

FAIL if the press scale appears as a finding of any severity, or if the stray color is missing.
