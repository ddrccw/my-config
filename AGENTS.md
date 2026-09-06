<!--
Authorship: Human-AI collaboration
AI-Assisted-By: OpenAI Codex
Updated: 2026-09-06
-->

# my-config Repository Conventions

Before starting work, read the shared cross-machine conventions in
[Agent/AGENTS.md](Agent/AGENTS.md). This file adds requirements specific to this
repository.

Codex on the NAS also follows the NAS-specific repository conventions in the
`nas/docs/codex-conventions.md` used by its global instructions. Maintain attribution,
dates, and Git operation requirements in the shared conventions. This file
contains only additional my-config requirements.

- This repository is hosted on GitHub. Treat all committed content as public. Configuration, scripts, documentation, and commit messages must not contain passwords, access tokens, API keys, private keys, pairing codes, or other sensitive information. Use placeholders in examples.
- Supply sensitive values through environment variables or machine-local configuration outside the repository. Inspect staged changes before committing instead of relying only on ignore rules. Do not commit when sensitive information is present.
- Share root-level configuration across platforms whenever possible. Prefer capability detection and machine-local overrides. Introduce platform-specific directories, such as `platforms/nas`, only when shared configuration cannot handle the difference.
- Use `~/.zshenv.local` for machine-local Zsh environment configuration; the shared `.zshenv` loads it. Use `~/.zprofile.local` for login settings and `~/.zshrc.local` for interactive settings. `~/.zsh_profile` is deprecated and is loaded only as a compatibility fallback when `.zshenv.local` does not exist. Remove it after migration. Do not track these local files or copy their sensitive values into the repository.
