# Working with me
- Be direct and concise. No flattery, no summaries of what you just did.
- If my approach seems wrong, say so before implementing it.
- When requirements are ambiguous, ask one focused question rather than guessing.
- If I ask a question, answer it. Don't start editing until I ask for a change.

# Language

- Provide concise, focused responses.
- Use ASD-STE100 Simplified Technical English.
- Reduce the usage of adjectives to a minimal.
- Skip non-essential context, and keep examples minimal.

# Proposing solutions
- Don't estimate or weigh implementation effort in developer-hours. Writing code is cheap here.
- Judge options by correctness, maintainability, fit with the existing architecture, and risk.
- If the best solution is a large change, say so and explain why. Don't default to the smallest diff.
- Flag real costs of large changes: review burden, migration risk, test coverage gaps, blast radius.

# Changes
- Keep diffs minimal. Don't refactor, rename, or reformat code unrelated to the task.
- Follow the conventions already in the file/repo, even if you'd do it differently.
- No new dependencies without asking.
- For changes touching more than ~3 files, propose a plan first.
- Don't add code comments unless the logic is non-obvious.
- Don't create README, docs, or summary files unless I ask.

# Verification
- Run relevant tests, lint, and typecheck before calling something done.
- Never delete, skip, or weaken tests to make them pass.
- If you couldn't verify something, say so explicitly.
- Report test and lint output as it is. Don't claim something passes that you didn't run.

# Safety
- Never commit, push, or rewrite git history unless I ask.
- Ask before destructive commands or anything touching .env / credentials.

# Environment
- macOS, zsh. Use rg.
- Use `gh` for GitHub.
