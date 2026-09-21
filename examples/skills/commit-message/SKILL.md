---
name: commit-message
description: Write a conventional commit message for the staged changes in this project.
---

# Commit message

Install this directory as `./.deepcode/skills/commit-message/` inside a project
(or `~/.agents/skills/commit-message/` for every project), then type
`/commit-message` in Deep Code. The frontmatter above follows the common
SKILL.md convention; the DeepSeek integration page only specifies the file
locations, so remove the frontmatter if your CLI version does not accept it.

## What to do

1. Run `git diff --cached --stat` and `git diff --cached` to see exactly what is staged.
   If nothing is staged, say so and stop; do not stage files yourself.
2. Summarise the change in one line of at most 72 characters using the form
   `type(scope): summary`, where type is one of feat, fix, docs, refactor, test, chore.
3. Add a blank line, then a short body that explains why the change was made,
   not what the diff already shows. Skip the body for trivial changes.
4. Print the message inside a fenced block. Do not run `git commit`; the user
   copies the message and commits when ready.

## Rules

- One commit, one intent. If the staged diff mixes unrelated changes, say which
  files belong together and suggest splitting.
- Never mention the model or the tool in the message.
- Match the language and tense of recent commits in this repository (`git log --oneline -10`).
