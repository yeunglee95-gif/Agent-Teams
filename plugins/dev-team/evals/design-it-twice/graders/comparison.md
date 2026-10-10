---
type: llm
focus:
  source: file
  path: plans/M6-design.md
weight: 3
---

These are an architect's design notes for a notifications interface (email via Postmark now, in-app notices
in the app's Postgres database, SMS via Twilio later; callers are an invoice job, a payments webhook and a
shipping job).

PASS only if all of the following hold:
1. At least three clearly different interface designs are described.
2. They are compared explicitly on depth (how much each entry point does for callers), locality (where future change lands, for example adding SMS) and seam placement.
3. The dependencies are classified by kind, with Postmark and Twilio treated as outside services behind a port with a mock or fake in tests, and the database treated as testable with a local stand-in (PGLite) or as in-process/local.
4. It ends with one recommended design (or a named hybrid) and the reasons.

FAIL if fewer than three designs, if there is no comparison on those terms, or if there is no recommendation.
