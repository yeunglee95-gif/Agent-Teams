---
name: hidden-failure-check
description: Use when reviewing a change for errors that fail quietly and for tests that do not really test. Finds swallowed errors, silent fallbacks, misleading messages, and tests that would still pass if the feature broke.
---

# Hidden-failure check

Two questions for every change: does anything fail without telling anyone, and would the tests notice if the feature broke?

## Part 1: errors that hide

Find every place the change handles an error: try and catch, error callbacks, default values on failure, optional chaining, retries, fallbacks. For each one ask:

- **Is it silent?** An empty catch, a catch that only logs and carries on, a null or default returned without a log. A failed send that still reports "sent" is a blocker: the app lies about itself.
- **Is the catch too broad?** Name the unrelated errors it would also swallow.
- **Is the fallback justified?** A fallback the spec does not ask for hides the real problem. A fallback to a fake or sample implementation outside tests is a blocker.
- **Does the person see it?** A message that says what went wrong and what they can do, in every language the app ships.
- **Does it reach the log** with enough context (what failed, which record) to debug it months later, and without any credential?
- **Should it go up instead,** to a handler that can do something about it?

## Part 2: tests that do not test

Map the change's behaviors to its tests. For each gap, say which bug the missing test would catch:

- Error paths and refusals with no test.
- Boundaries (empty, one, many, too long, wrong type) with no test.
- Business rules with a happy-path test only.
- Tests that check how the code is built (a mock was called) instead of what it does. They break on a harmless refactor and miss real bugs.
- Tests that would still pass with the feature deleted. Prove it with the reviewer's mutation check: break the line behind the assertion and confirm the test goes red.

## Report each finding

Path and line, severity (blocker: silent failure or a fallback that lies; major: an untested rule or path a person depends on, or a misleading message; minor: missing context), what could be hidden or missed, what the person would experience, and a suggested test title.

## Source

Adapted from the `silent-failure-hunter` and `pr-test-analyzer` agents in Anthropic's `pr-review-toolkit` plugin (anthropics/claude-plugins-official, Apache License 2.0), commit b78ac49cdc6b3d7b61c4439470e311f4291265b1. Changed: the two agents merged into one skill, rewritten in this team's voice, the project-specific logging and error-id lines removed, severities mapped to this team's blocker, major and minor, and the mutation check added. License text: `../../licenses/Apache-2.0.txt`.
