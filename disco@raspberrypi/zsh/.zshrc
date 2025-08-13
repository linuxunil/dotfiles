# Path configuration
export PATH="$PATH:$HOME/go/bin:$PATH"
if command -v brew 1>/dev/null 2>&1; then
	export PATH="/opt/homebrew/bin:$PATH"  # For Apple Silicon Macs
fi
export PATH="$HOME/.local/bin:$PATH"           # Personal scripts directory
export EDITOR="nvim"
export UV_PYTHON_PREFERENCE=only-managed
export UV_PROJECT_ENVIRONMENT=.venv
# History configuration
HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY          # Write timestamp to history
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicates first
setopt HIST_IGNORE_DUPS          # Ignore duplicated commands
setopt HIST_IGNORE_SPACE         # Ignore commands starting with space
setopt HIST_VERIFY               # Show command before executing from history
setopt SHARE_HISTORY             # Share history between sessions
setopt HIST_REDUCE_BLANKS	# Clean up spacing in history

# Directory navigation
setopt AUTO_CD                   # Change directory without cd command
setopt AUTO_PUSHD               # Push directories onto stack
setopt PUSHD_IGNORE_DUPS        # Don't push duplicates
setopt PUSHD_SILENT		# Reduce noise
setopt CORRECT_ALL                  # Correct typos in commands

# Completion system
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # Case-insensitive completion

# Prompt configuration
# PROMPT='%F{blue}%n@%m%f:%F{cyan}%~%f$ '

# Aliases (basic)
if command -v z 1>/dev/null 2>&1; then
	alias cd='z'
fi
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='rg --color=auto'
alias history='history -i'
alias g='git'
alias gs='git status'
alias gl='git log --oneline'
alias cat='bat'
alias less='bat --paging=always'
alias find='fd'

# Aliases (Neovim)
alias vim='nvim'
alias nv='nvim'
alias nvconf='nvim ~/.config/nvim/init.lua'

# Go-task (your primary command interface):
alias t='task'
alias tl='task --list'
alias tm='task macos'
alias tdev='task development'
alias tbase='task base'
alias tdry='task dry-run'
alias tcheck='task check'

# Aliases (zellij)
alias zj='zellij -l welcome'
alias jz='zellij'
alias za='zellij attach'
alias zl='zellij list-sessions'
alias zk='zellij kill-sessions'
alias zks='zellij kill-all-sessions'

# Aliases (UV)
alias uvr='uv run'
alias uvi='uv init'
alias uva='uv add'

# Aliases (containers)
alias p='podman'
alias pc='podman-compose'
alias pps='podman ps'
alias pi='podman images'
alias docker='podman'

# Environment variables
export LANG='en_US.UTF-8'      # Language setting
export LC_ALL='en_US.UTF-8'    # Locale setting

# macOS specific settings
export CLICOLOR=1              # Enable colored output for ls
export LSCOLORS=GxFxCxDxBxegedabagaced

# Homebrew configuration (if installed)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Node Version Manager (if installed)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Python configuration
if command -v uv 1>/dev/null 2>&1; then
	eval "$(uv generate-shell-completion zsh)"
fi

# Ruby configuration (if using rbenv)
if command -v rbenv 1>/dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

#Starship
if command -v starship 1>/dev/null 2>&1; then
	eval "$(starship init zsh)"
fi

# Zoxide
if command -v zoxide 1>/dev/null 2>&1; then
	eval "$(zoxide init zsh)"
fi

# Direnv
if command -v direnv 1>/dev/null 2>&1; then
	eval "$(direnv hook zsh)"
fi

# GH
if command -v gh 1>/dev/null 2>&1; then
	eval "$(gh completion -s zsh)"
fi

# FZF
if command -v fzf 1>/dev/null 2>&1; then
	source <(fzf --zsh)
fi
	eval "$(mise activate zsh)"
# Custom functions
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Load local configuration if it exists
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
# Launch Zellij
if [[ -z "$ZELLIJ" ]] && [[ -z "$SSH_CONNECTION" ]] && [[ -n "$DISPLAY" ]] && [[ "$TERM_PROGRAM" == "ghostty" ]]; then
	if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
	      zellij attach -c
	  else
	      zellij -l welcome
	  fi
	  if [[ "$ZELLIJ_AUTO_EXIT" == "TRUE" ]]; then
	      exit
	  fi
fi
export PATH=$PATH:$HOME/.local/opt/go/bin

# opencode
export PATH=/home/disco/.opencode/bin:$PATH
