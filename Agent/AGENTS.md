<!--
Authorship: Human-AI collaboration
AI-Assisted-By: OpenAI Codex
Updated: 2026-09-06
-->

# Shared Cross-Machine Agent Conventions

This file is the single source of truth for conventions shared across machines
and projects. It is synchronized through the my-config repository. Update shared
conventions here instead of maintaining separate copies on each machine.

- Communicate with the user in Chinese by default. Report the outcome, essential evidence, and unfinished work.
- Prefer English when creating or substantially revising documentation. Follow an existing project language policy, a clear convention in neighboring documents, or an explicit user request. Keep each document internally consistent.
- Before starting work, read the target project's `AGENTS.md` and relevant documentation. Check Git status before editing and preserve existing changes.
- Explicit user instructions take precedence over this file. Keep project-specific conventions in the corresponding project. Resolve scope conflicts before proceeding and never overwrite user changes without authorization.
- Work within the user's authorization. Saving a deployment script does not authorize running it. Do not push to a remote without explicit authorization.
- Perform verification appropriate to the change and report checks that were skipped or failed.
- Treat all committed content as public. Never commit passwords, tokens, API keys, private keys, pairing codes, or real `.env` files. Keep sensitive values outside the repository and use placeholders in examples.
- Keep shared conventions in this file, project procedures in project documentation, and machine paths, addresses, runtime state, and local configuration in environment-specific documentation or files outside the repository.
- Prefer `~`, relative paths, or environment variables for cross-machine paths. Verify actual paths and available capabilities before use.
- Do not store session transcripts, caches, authentication data, or an Agent application's entire configuration directory here.

## Document Header Metadata

When creating or modifying a document with AI assistance, maintain authorship
and update metadata at the beginning of the file, before the main heading. Use
an HTML comment in Markdown:

```markdown
<!--
Authorship: Human-AI collaboration
AI-Assisted-By: OpenAI Codex
Updated: 2026-09-06
-->
```

- Set `Authorship` to the actual authorship mode. Use `Human-AI collaboration` for human-AI collaboration, and do not represent existing human-authored content as AI-authored.
- Set `AI-Assisted-By` to the AI tool that actually participated. The example applies to OpenAI Codex. Name other tools accurately and preserve existing attribution.
- Set `Updated` to the actual modification date in `YYYY-MM-DD` format. Do not copy the example date unchanged. Read-only inspection does not require a date update.
- Update existing metadata instead of inserting a duplicate. Preserve existing copyright, license, and author notices; place this metadata immediately after them when necessary.
- For scripts and configuration formats that support comments, use the format's native comment syntax. Keep a script's shebang on the first line. For formats that do not support comments, record the metadata in accompanying documentation.

## Git Commit Conventions

- Commits follow the authorization for the current task. Do not ask again when the user has already authorized a commit. A request to edit files or maintain conventions does not itself authorize a commit, and authorization to commit does not authorize a push. Never push without explicit authorization.
- Before editing and committing, inspect the current branch, `git status --short`, the working-tree diff, and the staged diff. Identify existing user changes. Commit only changes within the current task, do not include unrelated work, and do not clear the user's staging area.
- Stage by file or hunk. Avoid `git add .` and `git add -A` unless all resulting changes have been reviewed. When a file contains unrelated changes, stage only the current task's changes. Clarify the scope if they cannot be separated reliably.
- Before committing, inspect `git diff --cached` and run `git diff --cached --check`. Confirm that the staged changes contain no secrets, temporary files, accidental deletions, or unrelated formatting changes. Run checks appropriate to the change and do not bypass commit hooks.
- Give each commit one complete purpose. Commit related code, necessary tests, and documentation together, without mixing unrelated changes.
- Follow the target repository's existing commit-message format and language. Chinese is not required. When no convention exists, use `<type>: <concise summary>`. Common types include `feat`, `fix`, `docs`, `refactor`, `test`, and `chore`. State the concrete change in the summary; explain the reason and verification in the body when useful.
- For AI-assisted commits, append `AI-Assisted-By: <actual tool name>` accurately at the end of the body. Do not fabricate human authorship or review, alter Git author configuration without authorization, or invent a `Co-authored-by` identity.
- For multiline commit messages, use a message file with `git commit -F` so that newlines remain intact and shell expansion or escape sequences are not written accidentally.
- Without explicit authorization, do not amend existing commits, rewrite history, force-push, or run cleanup or reset operations that could discard changes.
- After committing, inspect the commit and working-tree status. Report the short hash, summary, verification results, push status, and any remaining changes.

Example commit message:

```text
docs: add shared Agent commit conventions

Define staging scope, pre-commit checks, and commit-message formatting.
Verification: reviewed the staged diff and checked whitespace errors.

AI-Assisted-By: OpenAI Codex
```

Always replace the example verification result with the checks actually run.
