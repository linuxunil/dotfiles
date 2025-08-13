# .zprofile - Shell login profile
# Set zsh config dir
# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Initialize mise if available
if command -v mise &> /dev/null; then
    eval "$(mise activate zsh)"
fi

