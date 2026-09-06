<!--
Authorship: Human-AI collaboration
AI-Assisted-By: OpenAI Codex
Updated: 2026-09-06
-->

# Configuration Sync

Synchronize development environment configurations across different platforms.

## macOS/Linux Installation

Install all configurations directly:

```bash
curl https://raw.githubusercontent.com/ddrccw/my-config/master/install.sh | bash
```

Or clone and run manually:

```bash
git clone git@github.com:ddrccw/my-config.git
cd my-config
chmod +x install.sh
./install.sh
```

## Windows Installation

### One-liner Installation (Recommended)

Install directly from PowerShell:

```powershell
iex (iwr "https://raw.githubusercontent.com/ddrccw/my-config/master/install.ps1" -UseBasicParsing).Content
```

Or from Command Prompt:

```cmd
powershell -ExecutionPolicy Bypass -Command "iex (iwr 'https://raw.githubusercontent.com/ddrccw/my-config/master/install.ps1' -UseBasicParsing).Content"
```

### Manual Installation

For Windows users with PowerShell:

```powershell
git clone git@github.com:ddrccw/my-config.git
cd my-config
./install.ps1
```

Or using HTTPS:

```powershell
git clone https://github.com/ddrccw/my-config.git
cd my-config
./install.ps1
```

### Windows Prerequisites

- **Git**: Download from [git-scm.com](https://git-scm.com/download/win)
- **GVim** (optional): For vim configuration and plugins

## What Gets Configured

### macOS/Linux (install.sh)
- **tmux**: Terminal multiplexer configuration and plugins
- **vim**: Editor configuration and plugins
- **zsh**: Shell configuration
- **git**: Version control settings
- **lldb**: Debugger configuration
- **aria2**: Download manager settings
- **pip**: Python package manager configuration

### Windows (install.ps1)
- **git**: Version control settings (`.gitconfig`, `.gitignore_global`)
- **vim/gvim**: Editor configuration and plugins (`.vimrc`, `.vim`)
- **PowerShell**: Profile configuration (if available)

## Important Notes

⚠️ **Warning**: These scripts will overwrite existing local configurations. Backups are created automatically where possible.

- The installation will create symbolic links to the configuration files
- Existing configurations are backed up with `.backup` extension
- Run the scripts from any directory - they will handle paths automatically

## Platform Differences

The Windows PowerShell script (`install.ps1`) focuses on cross-platform tools and skips Unix-specific configurations like tmux and zsh, making it suitable for Windows development environments.

## QNAP NAS Installation

Use the existing checkout instead of `install.sh`. The NAS installer does not
clone repositories, install plugins, or change the login shell. By default it
only installs Git configuration and global ignore rules:

```sh
sh install-nas.sh --dry-run
sh install-nas.sh
```

Existing files, directories, and symlinks are moved into a private
`~/.my-config-backup.*` directory before replacement. Already-correct links are
left in place. Keep this checkout at its installed path; moving it breaks links.
To restore a configuration, remove its installed symlink and move the matching
backup entry back to its original location. The installer prints backup paths.

The installer writes a local `~/.gitconfig` entry that includes the shared
`.gitconfig` using an absolute path, then loads
optional `~/.gitconfig.local` last. The shared Git configuration finds Vim through PATH.
Do not put credentials in this repository. Use
`git config --file ~/.gitconfig.local KEY VALUE` for machine-only overrides;
shared changes belong in the root `.gitconfig`. If the checkout moves, rerun the
installer. For rollback, remove the generated Git entry and restore its backup;
for linked files, remove the link and restore the corresponding backup.

Zsh is optional and requires an installed `zsh` executable:

```sh
sh install-nas.sh --zsh --dry-run
sh install-nas.sh --zsh
```

This links the shared root `.zshenv`, `.zprofile`, and `.zshrc` directly.
The shared configuration adds Entware directories (`/opt/bin`, `/opt/sbin`)
when present and initializes optional tools only when available.
Existing custom Shell settings are backed up, but are not automatically merged;
copy needed environment settings to `~/.zshenv.local`, loaded by the shared
`.zshenv` for every Zsh session. Use `~/.zprofile.local` for login-shell settings
and `~/.zshrc.local` for interactive-shell settings. Keep these files outside
the checkout; they are also ignored by Git.
`~/.zsh_profile` is deprecated and is loaded at the end of `.zshenv` only when
`~/.zshenv.local` does not exist. Move its settings to the appropriate `.local`
files and remove the old file after migration. If `.zshenv.local` already exists,
merge any needed settings into it; the two files are never loaded together.
Missing optional `~/.local/bin/env` is skipped on every platform. macOS and
Windows retain their existing installation entry points. Vim, tmux, and aria2 are not installed by
this NAS script.

For an isolated installation check, create a temporary directory and pass
`--target DIRECTORY`; the script does not change `HOME`.

Configuration should be shared across platforms whenever possible. Prefer
capability checks and machine-local overrides; introduce platform-specific
configuration directories only when shared configuration cannot handle the difference.

## Repository privacy

This repository is hosted on GitHub. Treat all committed content as public:
never include passwords, tokens, API keys, private keys, or other sensitive
information in configuration, documentation, or commit messages. Use environment
variables or machine-local files outside the checkout, and review staged changes
before committing. Example values must be placeholders.

Repository working conventions are maintained in [AGENTS.md](AGENTS.md).

## Shared Agent Conventions

Cross-machine Agent conventions are maintained in
[Agent/AGENTS.md](Agent/AGENTS.md) and synchronized with this repository. See
[Agent/README.md](Agent/README.md) for setup and synchronization instructions,
or give [Agent/INSTALL.md](Agent/INSTALL.md) directly to an Agent to install
my-config and connect the shared conventions.
