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


# Added by Antigravity CLI installer
export PATH="${HOME}/.local/bin:$PATH"
