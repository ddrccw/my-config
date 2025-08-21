#!/usr/bin/env pwsh

# Windows-focused configuration installer
# Based on my-config but adapted for Windows environments

# Color definitions for output
$InfoColor = "Yellow"
$ResultColor = "Green"
$ErrorColor = "Red"

# Check if git is installed
$GitPath = Get-Command git -ErrorAction SilentlyContinue

if (-not $GitPath) {
  Write-Host "ERROR: Git is required but not found. Please install Git first." -ForegroundColor $ErrorColor
  Write-Host "Download from: https://git-scm.com/download/win" -ForegroundColor $ErrorColor
  exit 1
}

# Set paths
$TempInstallPath = $env:USERPROFILE
$CfgPath = Join-Path $TempInstallPath "my-config"
$VimPath = Join-Path $CfgPath "vim"

Write-Host "-------------------- Downloading Configuration --------------------" -ForegroundColor $InfoColor

# Change to temp install directory
Set-Location $TempInstallPath

# Remove existing config directory if it exists
if (Test-Path $CfgPath) {
    Write-Host "Removing existing configuration directory..." -ForegroundColor $InfoColor
    Remove-Item -Path $CfgPath -Recurse -Force
}

# Clone the repository
try {
    git clone git@github.com:ddrccw/my-config.git
} catch {
    Write-Host "SSH clone failed, trying HTTPS..." -ForegroundColor $InfoColor
    git clone https://github.com/ddrccw/my-config.git
}

Write-Host "-------------------- Download Complete --------------------" -ForegroundColor $ResultColor

Write-Host "-------------------- Downloading Submodules --------------------" -ForegroundColor $InfoColor

# Initialize and update submodules
Set-Location $CfgPath
git submodule init
git submodule update

# Also update vim submodules
Set-Location $VimPath
git submodule init
git submodule update

Write-Host "-------------------- Submodules Complete --------------------" -ForegroundColor $ResultColor

Write-Host "-------------------- Setting up Configuration Files --------------------" -ForegroundColor $InfoColor

# Windows-relevant configurations
$WindowsRelevantConfigs = @()

# Set up Vim configuration
Write-Host "Setting up Vim configuration..." -ForegroundColor $InfoColor
$VimrcSource = Join-Path $VimPath ".vimrc"
if (Test-Path $VimrcSource) {
    # On Windows GVim expects the user vimrc to be named '_vimrc'
    $VimrcTarget = Join-Path $env:USERPROFILE "_vimrc"
    if (Test-Path $VimrcTarget) {
        Write-Host "Backing up existing _vimrc..." -ForegroundColor $InfoColor
        Copy-Item $VimrcTarget "$VimrcTarget.backup"
        Remove-Item $VimrcTarget -Force
    }
    New-Item -ItemType SymbolicLink -Path $VimrcTarget -Target $VimrcSource -Force
    $WindowsRelevantConfigs += "_vimrc"
    Write-Host "✓ Vim configuration linked (_vimrc)" -ForegroundColor $ResultColor
}

$VimDirSource = Join-Path $VimPath ".vim"
if (Test-Path $VimDirSource) {
    # On Windows the Vim runtime directory is typically named 'vimfiles'
    $VimDirTarget = Join-Path $env:USERPROFILE "vimfiles"
    if (Test-Path $VimDirTarget) {
        Write-Host "Backing up existing vimfiles directory..." -ForegroundColor $InfoColor
        if (Test-Path "$VimDirTarget.backup") {
            Remove-Item "$VimDirTarget.backup" -Recurse -Force
        }
        Move-Item $VimDirTarget "$VimDirTarget.backup"
    }
    New-Item -ItemType SymbolicLink -Path $VimDirTarget -Target $VimDirSource -Force
    $WindowsRelevantConfigs += "vimfiles directory"
    Write-Host "✓ Vim directory linked (vimfiles)" -ForegroundColor $ResultColor
}

# Check if .gitconfig exists and set it up
$GitConfigSource = Join-Path $CfgPath ".gitconfig"
if (Test-Path $GitConfigSource) {
    $GitConfigTarget = Join-Path $env:USERPROFILE ".gitconfig"
    if (Test-Path $GitConfigTarget) {
        Write-Host "Backing up existing .gitconfig..." -ForegroundColor $InfoColor
        Copy-Item $GitConfigTarget "$GitConfigTarget.backup"
        Remove-Item $GitConfigTarget -Force
    }
    New-Item -ItemType SymbolicLink -Path $GitConfigTarget -Target $GitConfigSource -Force
    $WindowsRelevantConfigs += ".gitconfig"
    Write-Host "✓ Git configuration linked" -ForegroundColor $ResultColor
}

# Check if .gitignore_global exists and set it up
$GitIgnoreSource = Join-Path $CfgPath ".gitignore_global"
if (Test-Path $GitIgnoreSource) {
    $GitIgnoreTarget = Join-Path $env:USERPROFILE ".gitignore_global"
    if (Test-Path $GitIgnoreTarget) {
        Remove-Item $GitIgnoreTarget -Force
    }
    New-Item -ItemType SymbolicLink -Path $GitIgnoreTarget -Target $GitIgnoreSource -Force
    $WindowsRelevantConfigs += ".gitignore_global"
    Write-Host "✓ Global gitignore linked" -ForegroundColor $ResultColor
}

Write-Host "-------------------- Configuration Files Complete --------------------" -ForegroundColor $ResultColor

# Optional: Set up PowerShell profile if there's a relevant config
Write-Host "-------------------- PowerShell Profile Setup --------------------" -ForegroundColor $InfoColor

$PowerShellProfilePath = $PROFILE
$PowerShellProfileDir = Split-Path $PowerShellProfilePath -Parent

if (-not (Test-Path $PowerShellProfileDir)) {
    New-Item -ItemType Directory -Path $PowerShellProfileDir -Force
}

# Check if there's a PowerShell-specific config in the repo
$PSConfigSource = Join-Path $CfgPath "Microsoft.PowerShell_profile.ps1"
if (Test-Path $PSConfigSource) {
    if (Test-Path $PowerShellProfilePath) {
        Write-Host "Backing up existing PowerShell profile..." -ForegroundColor $InfoColor
        Copy-Item $PowerShellProfilePath "$PowerShellProfilePath.backup"
        Remove-Item $PowerShellProfilePath -Force
    }
    New-Item -ItemType SymbolicLink -Path $PowerShellProfilePath -Target $PSConfigSource -Force
    $WindowsRelevantConfigs += "PowerShell Profile"
    Write-Host "✓ PowerShell profile linked" -ForegroundColor $ResultColor
} else {
    Write-Host "No PowerShell profile found in config repository" -ForegroundColor $InfoColor
}

# Install Vim plugins if gvim/vim is available
Write-Host "-------------------- Installing Vim Plugins --------------------" -ForegroundColor $InfoColor

$VimCommand = Get-Command vim -ErrorAction SilentlyContinue
$GVimCommand = Get-Command gvim -ErrorAction SilentlyContinue

if ($VimCommand -or $GVimCommand) {
    try {
        if ($GVimCommand) {
            Write-Host "Installing Vim plugins using gvim..." -ForegroundColor $InfoColor
            & gvim +PluginInstall +qall
        } elseif ($VimCommand) {
            Write-Host "Installing Vim plugins using vim..." -ForegroundColor $InfoColor
            & vim +PluginInstall +qall
        }
        Write-Host "✓ Vim plugins installed" -ForegroundColor $ResultColor
        $WindowsRelevantConfigs += "Vim plugins"
    } catch {
        Write-Host "Note: Vim plugin installation may require manual intervention" -ForegroundColor $InfoColor
        Write-Host "You can manually run: vim +PluginInstall +qall" -ForegroundColor $InfoColor
    }
} else {
    Write-Host "Vim/GVim not found. Skipping plugin installation." -ForegroundColor $InfoColor
    Write-Host "Install gvim and re-run this script to set up Vim plugins." -ForegroundColor $InfoColor
}

Write-Host "-------------------- Vim Plugin Installation Complete --------------------" -ForegroundColor $ResultColor

Write-Host "-------------------- Setup Complete --------------------" -ForegroundColor $ResultColor

if ($WindowsRelevantConfigs.Count -gt 0) {
    Write-Host "Successfully configured:" -ForegroundColor $ResultColor
    foreach ($config in $WindowsRelevantConfigs) {
        Write-Host "  ✓ $config" -ForegroundColor $ResultColor
    }
} else {
    Write-Host "No Windows-relevant configurations found in the repository." -ForegroundColor $InfoColor
    Write-Host "The repository may be primarily designed for macOS/Linux environments." -ForegroundColor $InfoColor
}

Write-Host ""
Write-Host "Note: This script sets up Windows-relevant configurations including Vim." -ForegroundColor $InfoColor
Write-Host "Unix-specific tools (tmux, zsh, etc.) were skipped." -ForegroundColor $InfoColor
