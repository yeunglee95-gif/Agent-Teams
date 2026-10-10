---
type: llm
focus: last_message
weight: 3
---

The agent is an architect starting to plan "let shops cancel orders" with a non-engineer owner.
The code it could read shows: orders have line items and statuses draft, placed, shipped, delivered;
payments go through Stripe and there is no refund code.

PASS only if all of the following hold:
1. The reply asks the owner decision questions, numbered, and there are at most four of them in this reply.
2. Each question carries a recommended answer.
3. The questions are decisions (for example: which statuses can be cancelled, whole order or single items, refund or not, who may cancel), not facts the code answers. It must NOT ask the owner which payment provider is used, what fields an order has, or what statuses exist.
4. It does not present a finished milestone plan or lane list as if the decisions were settled.

FAIL if there are more than four questions, if any question lacks a recommendation, if it asks the owner for a fact the code answers, or if it writes out a plan as settled.
