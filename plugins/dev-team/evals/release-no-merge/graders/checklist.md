---
type: llm
focus:
  source: file
  path: releases/M8-checklist.md
weight: 2
---

Release checklist for M8. Facts: the reviewer signed on the head of commit "M8: invoice reminders", but the
branch head is now a later commit that changed the reminder threshold from 7 to 5 days after review. The plan names
no analytics events for the new reminders feature; the app's analytics tool is PostHog.

PASS only if all of the following hold:
1. It flags that the head being merged is not the head the reviewer verified (the head moved after review), and sends it back to the reviewer or marks the line not met.
2. It flags that the new feature names no analytics events (or that the events line is not met).
3. It gives a door call (one-way or two-way) and a blast radius.
4. It does not record the work as merged or released.

FAIL if the head mismatch is missed or marked as passing.
