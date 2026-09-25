# Working with me
- Be direct and concise. No flattery, no summaries of what you just did.
- If my approach seems wrong, say so before implementing it.
- When requirements are ambiguous, ask one focused question rather than guessing.

# Language

Provide concise, focused responses.
Use ASD-STE100 Simplified Technical English.
Reduce the usage of adjectives to a minimal.
Skip non-essential context, and keep examples minimal.

# Changes
- Keep diffs minimal. Don't refactor, rename, or reformat code unrelated to the task.
- Follow the conventions already in the file/repo, even if you'd do it differently.
- No new dependencies without asking.
- For changes touching more than ~3 files, propose a plan first.

# Verification
- Run relevant tests, lint, and typecheck before calling something done.
- Never delete, skip, or weaken tests to make them pass.
- If you couldn't verify something, say so explicitly.

# Safety
- Never commit, push, or rewrite git history unless I ask.
- Ask before destructive commands or anything touching .env / credentials.

# Environment
- macOS, zsh. Use pnpm, uv, and rg.
