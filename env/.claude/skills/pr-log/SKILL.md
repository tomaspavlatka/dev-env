---
name: pr-log
description: Record a GitHub pull request in the Obsidian work journal. Use when the user gives a GitHub PR URL and wants it logged, journalled, or "added to my daily note" / "recorded under Work" / "log this PR". Fetches the PR with gh, reads its diff, resolves the Jira ticket, finds or creates the ticket note, and appends a three-level entry under the Work heading of today's daily note.
---

# pr-log

Append a PR record to today's daily note in the Obsidian vault, nested under its Jira ticket.

## Constants

```
VAULT=/Users/tomas.pavlatka/codebase/personal/ptx-obsidian-wiki
DAILY_DIR="$VAULT/5 - notes/5.1 - daily-notes"          # <YYYYMMDD-dddd>.md
DAILY_TMPL="$VAULT/6 - files/6.2 - templates/tmpl - daily.md"
TASKS_DIR="$VAULT/3 - areas/3.2 - jobs/3.2.3 - Forto/tasks"
TASK_TMPL="$VAULT/6 - files/6.2 - templates/tmpl - jira-task.md"
WORK_HEADING="## :LiComputer: Work"
```

Ignore the legacy duplicate ticket notes in `3 - areas/3.2 - jobs/3.3.3 - Forto/` — that folder is a
typo'd stale copy. `3.2.3 - Forto/tasks/` is canonical.

## Output format — reproduce exactly

Three levels, **tab** indentation (not spaces), under the Work heading:

```
- [[IAM-2544 - Create new Faro Role for Sustainability]]
	- [IAM-2544: add permission to sustainability manager](https://github.com/freight-hub/infrastructure-terraform/pull/14062)
		- adds the missing `create:shipments:services` and `update:shipments:services` permissions to the `tms:sustainability_manager` role in sandbox
```

- **Level 1** — the ticket, linked by its **full note name**, never a bare `[[IAM-2544]]`.
- **Level 2** — one tab, markdown link: the PR title verbatim as the label, the PR URL as the target.
- **Level 3** — two tabs, the summary.

Verify the indentation afterwards with `cat -vet` (`^I` = tab). `cat -A` is not available on macOS.

## Summary voice (level 3)

One sentence. Starts lowercase, no trailing period, present tense. Says what the change does and why
it matters — not a restatement of the title. Backticks for identifiers. Roughly 15–40 words. Real
examples from the journal:

- `gets workbench off the pinned canary build onto a released ^6.2.0, which pulls auth-sdk 13.7.10 and models 2.0.0 with it — both majors, but no call site needed changing`
- `wires the TMS UI role endpoints into the existing role-change notification pipeline, so grants/revokes made in the UI reach slack and email like the request-form ones do`
- ``same jump in carbon-emissions, from `^4.6.24` straight to `^6.2.0`, only package.json and the lockfile changed``

## Procedure

### 1. Parse the URL

Accept `https://github.com/<owner>/<repo>/pull/<number>`. Anything else — stop and say so.

### 2. Fetch the PR

```bash
gh pr view <url> --json number,title,url,body,headRefName,state,isDraft,additions,deletions,changedFiles,files
```

`gh` is authenticated to github.com only. If the call fails, report the `gh` error verbatim and stop —
do not fall back to guessing from the URL.

### 3. Read the diff

```bash
gh pr diff <url>
```

Write the summary from what actually changed, not from the PR body.

Guard: if `additions + deletions > 3000`, skip the diff, use the `files` list plus the PR body
instead, and say in the final report that the summary came from the file list rather than the diff.
Never truncate the diff silently.

### 4. Resolve the ticket key

First `[A-Z]+-[0-9]+` match, searched in this order: PR title → `headRefName` → PR body. Titles take
both forms `IAM-2600: subject` and `chore(deps): bump ... [IAM-2575]`.

If no key is found anywhere, ask the user which ticket this belongs to. Do not guess.

### 5. Find the ticket note

```bash
ls "$TASKS_DIR" | grep "^IAM-2544 - "
```

Use the matched filename (minus `.md`) as the wikilink target.

### 6. If the ticket note does not exist, create it

Pull the real issue from Jira via the Atlassian MCP:

1. `getAccessibleAtlassianResources` → cloudId for `forto.atlassian.net`
2. `getJiraIssue` for the key

Filename: `<KEY> - <Jira summary>.md`, sanitised the way existing files are —
`/` → ` - `, `:` and `*` dropped, `[ ]` kept.

Body: the `tmpl - jira-task.md` template verbatim, `link:` filled with
`https://forto.atlassian.net/browse/<KEY>`, Jira description converted to markdown under
`## Description`:

```
---
tags:
  - tasks
company: "[[Forto Logistics SE & Co. KG]]"
link: https://forto.atlassian.net/browse/IAM-2544
---
## Description

<description>
```

If Jira is unreachable, stop and tell the user — do not invent a title, because the filename becomes
the permanent wikilink target.

### 7. Open today's daily note

`date +%Y%m%d-%A` → e.g. `20260916-Wednesday.md` in `$DAILY_DIR`. Today only; no backfill.
If it does not exist, create it by copying `tmpl - daily.md` verbatim.

### 8. Locate the Work section

`## :LiComputer: Work`. Notes before 2026-04-08 use `#### :LiComputer: Work` — accept that too and
keep whichever level the file already has. If neither is present, insert `## :LiComputer: Work`
before `## :LiPersonStanding: People` if that heading exists, otherwise at end of file.

### 9. Insert

At the **end** of the Work section — i.e. immediately before the next heading of the same or higher
level (commonly `## :LiPersonStanding: People`), or at EOF.

- If a `- [[IAM-<n> - ...]]` bullet for this ticket is **already** under Work, nest the new PR line
  under that existing bullet instead of adding a second ticket bullet.
- Otherwise append ticket bullet → PR line → summary line.
- Preserve the blank line that separates the Work section from the following heading.
- Do not touch anything else in the file.

### 10. Idempotence

If the PR URL already appears anywhere in today's note, do not write a duplicate. Report where it
already is and offer to refresh its summary line.

### 11. Do not commit

The obsidian-git plugin auto-commits (`vault backup: YYYY-MM-DD HH:mm:ss`). Leave the working tree
dirty.

Finish by printing the daily-note path and the exact lines written.
