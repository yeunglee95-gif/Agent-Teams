---
name: agent-browser
description: >
  Browser automation for AI agents via the agent-browser CLI. Open pages, read
  content as compact accessibility snapshots, click, fill forms, screenshot,
  and close. Use for any task needing a real browser: JavaScript-rendered
  pages, login flows, dynamic content, form submission, or visual checks.
  Prefer over webfetch when the page needs interaction or renders client-side.
---

# agent-browser

Control a real Chrome browser from the terminal. Compact text output uses
~200-400 tokens per snapshot vs ~3000-5000 for full DOM. Works with any
agent that can run shell commands.

## Install

```
npm install -g agent-browser
```

Chrome must be installed (auto-detected at the standard path). On first use,
agent-browser launches a daemon that persists between commands.

## Core workflow

```
agent-browser open <url>          # navigate
agent-browser snapshot -i         # accessibility tree with refs
agent-browser click @e1          # click element by ref
agent-browser fill @e2 "text"     # fill input
agent-browser screenshot out.png  # capture
agent-browser close               # done
```

## Reading a page

```
agent-browser open https://example.com
agent-browser snapshot -i
```

Output is a compact accessibility tree:

```
- heading "Example Domain" [ref=e1]
- link "More information..." [ref=e2]
```

Each element has a ref like `@e1`. Use refs for all interactions — they
point to the exact element from the snapshot, no re-query needed.

## Interacting

| Command | What it does |
|---|---|
| `click @ref` | Click element |
| `fill @ref "text"` | Fill input field |
| `type @ref "text"` | Type into element |
| `select @ref "value"` | Select dropdown option |
| `check @ref` / `uncheck @ref` | Toggle checkbox |
| `press Enter` | Press a key |
| `scroll down` / `scroll up` | Scroll page |
| `screenshot [path]` | Save screenshot |
| `screenshot --full` | Full-page screenshot |

## Navigation

| Command | What it does |
|---|---|
| `open <url>` | Navigate to URL |
| `back` / `forward` | History navigation |
| `reload` | Reload page |
| `close` | Close browser |

## Waiting

```
agent-browser wait @e1            # wait for element
agent-browser wait 2000           # wait 2 seconds
agent-browser wait --text "Done"  # wait for text
```

## Tabs and frames

```
agent-browser tab new <url>       # new tab
agent-browser tab list            # list tabs
agent-browser tab switch 2        # switch to tab
agent-browser frame @iframe       # enter iframe
```

## When to use vs webfetch

- **webfetch**: static pages, simple HTML, API docs, known URLs. Faster, no browser needed.
- **agent-browser**: JavaScript-rendered pages, SPAs, login flows, form submission, visual verification, or when you need to interact with the page.

## Tips

1. Always `snapshot -i` after navigating — you need refs before you can interact.
2. Re-snapshot after any action that changes the page (click, form submit, navigation).
3. Use `screenshot` to verify visual state when text output isn't enough.
4. Close the browser when done to free resources.
5. For login flows, use `fill` for username/password, then `click` on submit.

## Source

Written by this team. Wraps the `agent-browser` CLI (https://agent-browser.dev), installed separately via `npm install -g agent-browser`. Not adapted from a published skill.