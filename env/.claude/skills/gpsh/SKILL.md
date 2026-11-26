---
name: gpsh
description: Commit staged and unstaged changes, then push
argument-hint: [optional commit message hint]
disable-model-invocation: true
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git add:*), Bash(git commit:*), Bash(git push:*), Bash(git log:*)
---

## Context
- Status: !`git status --short`
- Branch: !`git branch --show-current`
- Diff: !`git diff HEAD`
- Recent commits: !`git log --oneline -5`

## Task
Commit all current changes with a message that follows the repo's commit style.
Use this hint if given: $ARGUMENTS
Then push to the current branch's upstream. If no upstream exists, push with `-u origin <branch>`.
Do not force-push.
