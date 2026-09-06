<!--
Authorship: Human-AI collaboration
AI-Assisted-By: OpenAI Codex
Updated: 2026-09-06
-->

# Agent Installation Instructions

This document is intended to be given directly to an Agent. When the user asks
you to carry it out, connect the shared conventions in this repository to the
Agent application's persistent global instructions.

## Expected Result

- The my-config repository is available locally and `Agent/AGENTS.md` is readable.
- The Agent application's supported global instruction entry point tells the Agent to read that file before every task.
- Existing global and project-specific instructions remain intact.
- Shared conventions continue to come from this Git checkout, so future pulls update them without maintaining a second copy.

## Installation Procedure

1. Locate the checkout containing this document and resolve its absolute path. Do not assume that the directory is named `my-config` when an existing checkout uses another path.
2. If no checkout exists, verify that `~/my-config` is unused, then clone `git@github.com:ddrccw/my-config.git` there. If SSH access is unavailable, use `https://github.com/ddrccw/my-config.git`. Do not overwrite an existing path.
3. Read `Agent/AGENTS.md` and the repository-root `AGENTS.md` before making changes. Inspect Git status before pulling or editing. Preserve local changes; update the checkout only when it can be done safely.
4. Identify the persistent global instruction entry point supported by the installed Agent application. Inspect existing configuration and product documentation when necessary instead of guessing a filename.
5. Preserve the existing instruction file. Add one reference to the absolute path of `Agent/AGENTS.md`; do not copy the shared rules into another file. Use the application's native include mechanism when available. Otherwise, add this instruction with the real path substituted:

   ```text
   Before starting any task, read <MY_CONFIG_CHECKOUT>/Agent/AGENTS.md and follow
   its shared cross-machine conventions. Continue to read the target project's
   AGENTS.md for project-specific requirements.
   ```

6. Avoid duplicate references. If an existing reference points to an obsolete checkout, update it only after confirming that the new shared file is readable.
7. Do not put machine-specific paths, credentials, session data, or application caches into this repository. Do not commit or push installation changes unless the user separately authorizes those Git operations.

## Verification

After installation:

1. Confirm that the referenced `Agent/AGENTS.md` exists and is readable.
2. Confirm that the global instruction entry point contains exactly one active reference to it and that existing instructions were preserved.
3. Start a fresh Agent session, or reload instructions using the application's supported method.
4. Ask the fresh session to identify the shared documentation-language and Git-commit conventions. Treat correct identification as the functional check.
5. Report the global instruction file changed, the shared file referenced, any backup created, verification results, and any work left for the user. Do not print secrets or unrelated local configuration.

## Updating or Removing the Installation

To update the shared conventions, pull the my-config checkout and reload the
Agent instructions. To remove the installation, delete only the reference added
by this procedure. Do not delete the checkout, the global instruction file, or
unrelated instructions unless the user explicitly requests it.
