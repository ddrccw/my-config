# Authorship: Human-AI collaboration
# AI-Assisted-By: OpenAI Codex
# Updated: 2026-09-06

# Optional tool directories shared by all hosts (including Entware).
typeset -U path
[[ -d /opt/sbin ]] && path=(/opt/sbin $path)
[[ -d /opt/bin ]] && path=(/opt/bin $path)



# Brew
if [[ `uname -m` == 'arm64' ]] && [ -x "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -d "/usr/local/Cellar/gnu-getopt/1.1.6/bin" ]; then
  export PATH="/usr/local/Cellar/gnu-getopt/1.1.6/bin:$PATH"
fi
export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# export MANPATH="/usr/local/man:$MANPATH"
export COCOAPODS_DISABLE_STATS=true
export COCOAPODS_DISABLE_DETERMINISTIC_UUIDS=YES

# rust
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

command -v rbenv >/dev/null 2>&1 && eval "$(rbenv init -)"

if command -v pyenv 1>/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -d "$HOME/.jenv/bin" ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
fi
command -v jenv >/dev/null 2>&1 && eval "$(jenv init -)"

# Added by Windsurf
if [ -d "$HOME/.codeium/windsurf/bin" ]; then
  export PATH="$HOME/.codeium/windsurf/bin:$PATH"
fi

# brew install pnpm
if [ -d "$HOME/Library/pnpm" ]; then
  export PNPM_HOME="$HOME/Library/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi
# pnpm end

# sdkman
if [ -d "$HOME/.sdkman/bin" ]; then
  #THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# Added by CodeBuddy
if [ -d "$HOME/.codebuddy/bin" ]; then export PATH="$HOME/.codebuddy/bin:$PATH"; fi

# User-local executables shared by command-line tools.
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"


# Machine-only overrides; .zsh_profile is deprecated.
if [[ -f "$HOME/.zshenv.local" ]]; then
  source "$HOME/.zshenv.local"
elif [[ -f "$HOME/.zsh_profile" ]]; then
  source "$HOME/.zsh_profile"
fi
true
