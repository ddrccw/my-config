
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