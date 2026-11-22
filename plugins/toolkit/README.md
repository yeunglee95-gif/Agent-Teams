# Toolkit

Skills for any team or app, kept here so a new environment or AI tool gets them by installing one plugin.

| Skill | Use it to |
|---|---|
| `watch` | Watch a video from a URL or file: frames plus a timestamped transcript, or Gemini watching the whole video when a `GEMINI_API_KEY` is set. Needs Python 3.10+, ffmpeg and yt-dlp. |
| `caveman` | Shorter chat replies: answer first, no filler, every technical fact kept. Anything written to files, commits or messages stays in normal prose. Off with "stop caveman" or "normal mode". |
| `find-skills` | Search the open skills ecosystem (`npx skills find`) and install a vetted skill. A skill found this way joins this toolkit, with its source and licence in `THIRD_PARTY.md`, before any app relies on it. |
| `agent-browser` | Browser automation for AI agents: open pages, read content as compact accessibility snapshots, click, fill forms, screenshot. Uses Chrome via the agent-browser CLI. Use for JavaScript-rendered pages, login flows, dynamic content, or visual checks. Prefer over webfetch when interaction is needed. |
| `obscura` | Headless browser for AI agents and web scraping: fetch/render pages, screenshots, parallel scraping, CDP server, MCP server. No Chrome needed. Use for cloud/VPS deployment, stealth scraping, or when Chrome is unavailable. Prefer agent-browser when you need the user's real Chrome sign-ins. |

**Install:** `/plugin marketplace add yeunglee95-gif/Agent-Teams`, then `/plugin install toolkit@agent-teams`. Where plugins do not install (cloud sessions), copy `skills/*` into the app's `.claude/skills/` from one pinned commit. Codex reads the same folders: copy `skills/*` into the project's `.agents/skills/` or `~/.codex/skills/`.
