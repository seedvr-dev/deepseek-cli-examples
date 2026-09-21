# DeepSeek CLI (Deep Code) examples

*Unofficial community examples for DeepSeek CLI (Deep Code). Not affiliated with DeepSeek. All trademarks belong to their owners.*

Working configuration examples for a deepseek cli setup with Deep Code, the open-source terminal coding assistant for DeepSeek-V4. Deep Code is configured through `~/.deepcode/settings.json` and extended through Markdown skill files, so the examples here are shell scripts and a skill rather than API calls: generate the settings file from an environment variable instead of pasting a key, switch between `deepseek-v4-pro` and `deepseek-v4-flash`, hook the `notify` option, and ship a project-level skill. Everything uses only options and paths named on the DeepSeek integration page; where the page is silent (for example, what arguments `notify` receives) the script says so.

> Want the site or app itself rather than an agent that edits code? [Try Begin.sh - prompt or URL in, static site or Expo app out as a zip](https://begin.sh?utm_source=github&utm_medium=ugc&utm_campaign=deepseek-cli-examples&utm_content=readme-top&utm_term=tier-r).

## Files

| Path | What it shows |
| --- | --- |
| `examples/setup-settings.sh` | Writes `~/.deepcode/settings.json` with `MODEL`, `BASE_URL`, `API_KEY`, `thinkingEnabled` and `reasoningEffort`, reading the key from `DEEPSEEK_API_KEY` |
| `examples/switch-model.sh` | Flips `env.MODEL` between `deepseek-v4-pro` and `deepseek-v4-flash` in place |
| `examples/notify.sh` | A `notify` script: rings the terminal bell and appends a line to a log after each model turn |
| `examples/skills/commit-message/SKILL.md` | A project-level Agent Skill, installed at `./.deepcode/skills/commit-message/SKILL.md` |

## Setup

```bash
npm install -g @vegamo/deepcode-cli
deepcode --version
export DEEPSEEK_API_KEY=...          # from the API keys page on the DeepSeek Platform
export DEEPSEEK_MODEL=deepseek-v4-pro  # or deepseek-v4-flash (optional)
bash examples/setup-settings.sh
```

Node.js 18 or newer is required by the CLI. The scripts use `node` for JSON editing so there is no extra dependency.

## setup-settings.sh

The integration page shows a `settings.json` with the API key inline. That is fine on a laptop and a problem the moment the file ends up in a dotfiles repo. This script builds the same file from `DEEPSEEK_API_KEY`, defaults `MODEL` to `deepseek-v4-pro` and `BASE_URL` to `https://api.deepseek.com` (the documented default), sets `thinkingEnabled` to `true` and `reasoningEffort` to `high`, and writes the file with owner-only permissions. Because the VS Code extension reads the same file, running this once configures both.

## switch-model.sh

`deepseek-v4-flash` is the lighter model; `deepseek-v4-pro` is the one the docs use in their sample. Rather than editing JSON by hand, run `bash examples/switch-model.sh flash` or `bash examples/switch-model.sh pro`. With no argument it toggles. It rewrites only `env.MODEL` and leaves everything else in the file untouched. Restart `deepcode` (or start a new conversation with `/new`) afterwards; the page does not say whether a running session picks the change up.

## notify.sh

The `notify` option takes a path to a script that runs after each model turn. The page does not document what arguments or environment the script receives, so this one is defensive: it prints a bell character, appends a timestamp plus whatever arguments it was given to `~/.deepcode/notify.log`, and exits 0 regardless. Wire it up by adding `"notify": "/absolute/path/to/examples/notify.sh"` to `settings.json`, then inspect the log after a turn to see what Deep Code actually passes. Swap the bell for a desktop notification once you know.

## skills/commit-message/SKILL.md

Agent Skills are discovered from `~/.agents/skills/{name}/SKILL.md` (user-level) and `./.deepcode/skills/{name}/SKILL.md` (project-level), and invoked from the `/` menu or by typing the name. This example is a small commit-message skill: copy the directory to `.deepcode/skills/commit-message/` in a project, then type `/commit-message` in Deep Code. The body is plain instructions; the short frontmatter block at the top follows the common SKILL.md convention but is not specified on the DeepSeek page, so drop it if the CLI version you have ignores or rejects it.

## Shortcuts you will use

`Enter` sends, `Shift+Enter` or `Ctrl+J` inserts a newline, `Ctrl+V` pastes an image, `Esc` interrupts the current turn, `/new` and `/resume` manage conversations, `/exit` quits.

## When to use Begin.sh instead

All of this is tooling for editing a codebase you already have, interactively, with a model you pay for per token. If the deliverable is a new static site or an Expo app and you would otherwise be prompting Deep Code to scaffold it from nothing, skip the loop: [try Begin.sh - describe it or paste a URL to clone, download the zip](https://begin.sh?utm_source=github&utm_medium=ugc&utm_campaign=deepseek-cli-examples&utm_content=readme-top&utm_term=tier-r). It includes no hosting, backend or auth, which keeps the output small enough to drop into Deep Code afterwards when you need real logic.
