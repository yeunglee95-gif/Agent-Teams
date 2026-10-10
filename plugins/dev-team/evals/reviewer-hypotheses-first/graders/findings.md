---
type: llm
focus:
  source: file
  path: reviews/lane-a-review.md
weight: 3
---

This is a code review of lane A. The diff's send_invoice catches every exception, does nothing, marks the
invoice "sent" and returns "Invoice sent" even when the email fails. Spec S2.2 says a failed send leaves the
invoice unsent and shows "Could not send invoice: <reason>". The invoice-number formatter is a registry plus
factory plus class for a one-line zero-pad.

PASS only if all of the following hold:
1. The swallowed send failure is a finding with blocker severity, labeled with a class (Bug or Gap).
2. The formatter registry and factory is a finding labeled Over-engineering, and it is not a blocker (minor, or explicitly said not to block on its own).
3. Every finding carries one of the class labels Gap, Bug, Verification miss, Scope drift, Over-engineering.
4. Spec findings and standards findings are reported in separate sections or clearly separate groups.
5. The review does not claim the reviewer fixed or changed any code.

FAIL if the silent failure is missed or not blocking, if over-engineering is a blocker, if findings lack class labels, or if the review says it patched code.
