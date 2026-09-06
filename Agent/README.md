<!--
Authorship: Human-AI collaboration
AI-Assisted-By: OpenAI Codex
Updated: 2026-09-06
-->

# Agent Convention Management

`Agent/` is the my-config repository's source for Agent conventions shared
across machines. Git synchronizes it with the rest of the repository. The
default checkout is `~/my-config`, and the shared convention file is
`~/my-config/Agent/AGENTS.md`.

## File Responsibilities

- [AGENTS.md](AGENTS.md): conventions shared across machines and projects.
- [INSTALL.md](INSTALL.md): instructions that can be given directly to an Agent to connect the shared conventions.
- The repository-root `AGENTS.md`: maintenance requirements specific to my-config.
- Each project's `AGENTS.md`: project procedures, deployment rules, and domain knowledge.
- Machine-local files outside the repository: machine differences and sensitive values.

## Using the Conventions on Another Machine

1. Clone or update the my-config repository.
2. Reference this repository's `Agent/AGENTS.md` from the global instruction entry point supported by the Agent application, using the actual path on that machine.
3. Confirm that the Agent has loaded the shared file before starting project work.

For a checkout at `~/my-config`, add the following to an existing instruction
entry point:

```text
Before starting work, read ~/my-config/Agent/AGENTS.md and follow its shared
cross-machine conventions. Continue to read the target project's AGENTS.md for
project-specific requirements.
```

For an Agent-led setup, give the Agent [INSTALL.md](INSTALL.md) and ask it to
carry out the instructions.

The directory is not loaded automatically by every Agent application. Connect
it through the application's supported instruction entry point. Preserve
existing local instructions and add the reference without replacing them.

## Synchronization Workflow

Before editing, inspect the working tree and synchronize remote updates. Resolve
local changes safely first. Edit shared rules in `Agent/AGENTS.md`, review the
diff and check for sensitive data, then commit or push only when authorized.
After pulling on another machine, start a new session or reload instructions as
supported by the Agent application.

This directory manages convention documents only. It does not currently provide
automatic synchronization, modify global Agent instruction entry points, or
install files.
