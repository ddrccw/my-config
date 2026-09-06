# Authorship: Human-AI collaboration
# AI-Assisted-By: OpenAI Codex
# Updated: 2026-09-06

# Fix for macOS path_helper (which runs after ~/.zshenv and resets PATH for login shells)
# This ensures that our version managers stay at the front of the PATH.

if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if command -v jenv 1>/dev/null 2>&1; then
  eval "$(jenv init -)"
fi


# Keep user-local executables ahead of system tools.
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)

# Machine-only overrides.
[[ -f "$HOME/.zprofile.local" ]] && source "$HOME/.zprofile.local"
true
