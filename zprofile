# ln -s ~/Dropbox/Documents/DotFiles/zprofile ~/.zprofile

# Environment Variables and PATH Configuration
# =============================================
# This file is sourced for login shells only

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Use NVM for Node management
# ---------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Use GVM for Go management
# -------------------------
# export GOPRIVATE="github.com/Frameio"
# [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
# export GOPATH=~/go
# PATH=$GOPATH/bin:$PATH

# Export path for yarn
# --------------------
export PATH=$PATH:~/.yarn/bin

# Bun
# ---
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Use pyenv for Python management
# -----------------------------
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Additional PATH modifications
export PATH="/usr/local/sbin:$PATH"
