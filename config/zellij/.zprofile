# .zprofile - Login shell environment setup
# This file is sourced once at login before .zshrc
# Keep it minimal and fast - only essential environment variables

export ZDOTDIR="$HOME/.config/zsh"

# Core environment
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Default applications
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"
export TERMINAL="ghostty"
export PAGER="bat"

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Essential paths (login shell paths only)
export PATH="$HOME/.local/bin:$PATH"

# Platform-specific setup
case "$OSTYPE" in
  darwin*)
    # macOS Homebrew
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:$PATH"
    export HOMEBREW_NO_ANALYTICS=1
    export HOMEBREW_NO_INSECURE_REDIRECT=1
    export HOMEBREW_CASK_OPTS="--no-quarantine"
    
    # macOS specific paths
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:"
    ;;
  linux*)
    # Linux specific setup
    export QT_QPA_PLATFORM="wayland;xcb"
    export GDK_BACKEND="wayland,x11"
    export MOZ_ENABLE_WAYLAND=1
    export ELECTRON_OZONE_PLATFORM_HINT="wayland"
    ;;
esac

# Development environment setup
export GOPATH="$HOME/go"
export GOBIN="$HOME/go/bin"
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"

# Language tool paths
export PATH="$GOBIN:$PATH"
export PATH="$CARGO_HOME/bin:$PATH"

# Node.js
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"

# Python
export PYTHONDONTWRITEBYTECODE=1
export PIP_REQUIRE_VIRTUALENV=1
export UV_CACHE_DIR="$XDG_CACHE_HOME/uv"

# Security and privacy
export HISTCONTROL="ignoreboth:erasedups"
export LESSHISTFILE=-
export MYSQL_HISTFILE=/dev/null
export SQLITE_HISTORY=/dev/null

# Performance optimizations
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export DISABLE_AUTO_UPDATE=true

# GPG setup for commit signing
export GPG_TTY=$(tty)

# Ensure mise is in PATH early for language management
if [[ -d "$HOME/.local/bin" ]] && command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh --shims)"
fi
