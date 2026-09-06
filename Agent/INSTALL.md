<!--
Authorship: Human-AI collaboration
AI-Assisted-By: OpenAI Codex
Updated: 2026-09-06
-->

# Agent Installation Instructions

This document is intended to be given directly to an Agent. When the user asks
you to carry it out, install my-config for the current platform and connect the
shared conventions to the Agent application's persistent global instructions.

## Expected Result

- The my-config repository is installed locally and its supported configuration files are active.
- `Agent/AGENTS.md` is readable from the installed checkout.
- The Agent application's supported global instruction entry point tells the Agent to read that file before every task.
- Existing global and project-specific instructions remain intact.
- Shared conventions continue to come from this Git checkout, so future pulls update them without maintaining a second copy.

## Before Installation

1. Identify whether the machine runs macOS, Linux, Windows, or QNAP NAS.
2. Read the repository-root `README.md`, `AGENTS.md`, and `Agent/AGENTS.md` before making changes.
3. Locate an existing checkout and resolve its absolute path. Inspect its Git status and preserve local changes. If no checkout exists, verify that `~/my-config` is unused, then clone the repository:

   ```sh
   git clone git@github.com:ddrccw/my-config.git ~/my-config
   ```

   If SSH access is unavailable, use:

   ```sh
   git clone https://github.com/ddrccw/my-config.git ~/my-config
   ```

4. Inspect the selected installer before running it. The macOS/Linux and Windows installers recreate `~/my-config` and replace configuration paths in the user's home directory. Back up affected files and ensure the checkout has no uncommitted work before running either installer.

## Install my-config

Use the installer for the detected platform. Run only one of the following
workflows.

### macOS or Linux

The installer requires Git and tmux. It recreates `~/my-config`, initializes
submodules, links the supported dotfiles, and installs tmux and Vim plugins.
After completing the backup and clean-worktree checks above, run:

```sh
cd ~/my-config
chmod +x install.sh
./install.sh
```

### Windows

Run PowerShell with permission to create symbolic links. The installer requires
Git, recreates `%USERPROFILE%\my-config`, and configures the supported Git, Vim,
Zsh, and optional PowerShell files. After completing the backup and clean-worktree
checks above, run:

```powershell
Set-Location "$HOME\my-config"
.\install.ps1
```

### QNAP NAS

Use the existing checkout. Do not run `install.sh` or `install.ps1`. Preview the
default Git-only installation, review the output, and then apply it:

```sh
cd ~/my-config
sh install-nas.sh --dry-run
sh install-nas.sh
```

Add shared Zsh configuration only when requested and when `zsh` is installed:

```sh
sh install-nas.sh --zsh --dry-run
sh install-nas.sh --zsh
```

The NAS installer backs up replaced paths in a private
`~/.my-config-backup.*` directory. Record the backup path shown in its output.

## Connect the Shared Agent Conventions

1. Confirm the final checkout path after installation and verify that `Agent/AGENTS.md` is readable there.
2. Identify the persistent global instruction entry point supported by the installed Agent application. Inspect existing configuration and product documentation when necessary instead of guessing a filename.
3. Preserve the existing instruction file. Add one reference to the absolute path of `Agent/AGENTS.md`; do not copy the shared rules into another file. Use the application's native include mechanism when available. Otherwise, add this instruction with the real path substituted:

   ```text
   Before starting any task, read <MY_CONFIG_CHECKOUT>/Agent/AGENTS.md and follow
   its shared cross-machine conventions. Continue to read the target project's
   AGENTS.md for project-specific requirements.
   ```

4. Avoid duplicate references. If an existing reference points to an obsolete checkout, update it only after confirming that the new shared file is readable.
5. Do not put machine-specific paths, credentials, session data, or application caches into this repository. Do not commit or push installation changes unless the user separately authorizes those Git operations.

## Verification

After installation:

1. Confirm that the expected configuration links or files were installed and that any replaced paths have recoverable backups.
2. Confirm that the referenced `Agent/AGENTS.md` exists and is readable.
3. Confirm that the global instruction entry point contains exactly one active reference to it and that existing instructions were preserved.
4. Start a fresh Agent session, or reload instructions using the application's supported method.
5. Ask the fresh session to identify the shared documentation-language and Git-commit conventions. Treat correct identification as the functional check.
6. Report the platform workflow used, configuration installed, global instruction file changed, shared file referenced, backup locations, verification results, and any work left for the user. Do not print secrets or unrelated local configuration.

## Updating or Removing the Installation

To update the shared conventions, pull the my-config checkout and reload the
Agent instructions. To remove the installation, delete only the reference added
by this procedure. Do not delete the checkout, the global instruction file, or
unrelated instructions unless the user explicitly requests it.
