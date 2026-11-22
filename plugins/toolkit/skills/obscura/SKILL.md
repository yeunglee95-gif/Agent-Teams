---
name: obscura
description: >
  Headless browser automation via the Obscura CLI. Fetch pages, render
  JavaScript, take screenshots, scrape in parallel, and expose an MCP server.
  Use for web scraping, dynamic content extraction, CDP-based browser control,
  or when you need a lightweight headless browser without Chrome. Prefer
  agent-browser when you need a real Chrome with the user's sign-ins.
---

# obscura

The open-source headless browser for AI agents and web scraping. Written in
Rust, 30 MB RAM, ~70 MB binary, no Chrome or Node.js required. Drop-in
replacement for headless Chrome via CDP.

## Install

**Windows (Scoop):**
```
scoop install https://raw.githubusercontent.com/h4ckf0r0day/obscura/main/scoop/obscura.json
```

**Windows (manual):** Download `obscura-x86_64-windows.zip` from
[Releases](https://github.com/h4ckf0r0day/obscura/releases), extract, add
the folder to PATH. Keep both `obscura.exe` and `obscura-worker.exe`.

**Linux/macOS:**
```
curl -LO https://github.com/h4ckf0r0day/obscura/releases/latest/download/obscura-x86_64-linux.tar.gz
tar xzf obscura-x86_64-linux.tar.gz
```

**Docker:**
```
docker run -d -p 127.0.0.1:9222:9222 h4ckf0r0day/obscura
```

## Core commands

### Fetch a page

```
obscura fetch <url> --dump html          # render JS, dump HTML
obscura fetch <url> --dump text          # readable text
obscura fetch <url> --dump links         # all links
obscura fetch <url> --dump markdown      # markdown
obscura fetch <url> --eval "document.title"  # run JS
obscura fetch <url> -s page.png          # screenshot
obscura fetch <url> --dump original > file.jpg  # raw body
```

### Serve as CDP server

```
obscura serve --port 9222               # Puppeteer/Playwright connect here
obscura serve --port 9222 --stealth     # anti-detection mode
```

### Scrape in parallel

```
obscura scrape url1 url2 url3 --concurrency 25 --format json
```

### MCP server (for AI agents)

```
obscura mcp                              # stdio (Claude Desktop, Cursor)
obscura mcp --http --port 8080           # HTTP endpoint
```

## MCP integration with OpenClaude

Connect OpenClaude to Obscura's MCP server for native browser tools:

```
openclaude --mcp-config "http://your-host:8080/mcp"
```

Available tools: `browser_navigate`, `browser_snapshot`, `browser_screenshot`,
`browser_click`, `browser_fill`, `browser_type`, `browser_press_key`,
`browser_evaluate`, `browser_wait_for`, `browser_network_requests`,
`browser_console_messages`, `browser_close`.

## VPN / proxy note

Some networks resolve all domains to private IP ranges (198.18.0.x), which
triggers Obscura's SSRF protection. Add `--allow-private-network` to any
command, or set `OBSCURA_ALLOW_PRIVATE_NETWORK=1`.

## Stealth mode

Build with `--features render,stealth` or use the `-stealth` release archive.
Enables anti-fingerprinting (per-session randomization, navigator masking)
and tracker blocking (3,520 domains).

## When to use vs agent-browser

- **agent-browser**: real Chrome, user's sign-ins, interactive browsing,
  form filling with real sessions. Needs Chrome installed.
- **obscura**: headless, no Chrome needed, lightweight, anti-detect,
  parallel scraping, cloud/VPS deployment, MCP server for agents.

## Source

Wraps the `obscura` CLI (https://github.com/h4ckf0r0day/obscura, Apache 2.0).
Installed separately — this skill teaches usage, it does not bundle the binary.