#!/usr/bin/env bash

set -euo pipefail

echo "🚀 Bootstrapping mise and Ansible environment..."

# Check if mise is already installed
if command -v mise >/dev/null 2>&1; then
    echo "✅ mise is already installed at $(which mise)"
    mise --version
else
    echo "📥 Installing mise..."
    curl https://mise.run | sh
    
    # Add to PATH for current session
    export PATH="$HOME/.local/bin:$PATH"
    
    # Add to shell profile
    if [ -n "${ZSH_VERSION:-}" ]; then
        SHELL_RC="$HOME/.zshrc"
    elif [ -n "${BASH_VERSION:-}" ]; then
        SHELL_RC="$HOME/.bashrc"
    else
        SHELL_RC="$HOME/.profile"
    fi
    
    if ! grep -q 'mise activate' "$SHELL_RC" 2>/dev/null; then
        echo 'eval "$(~/.local/bin/mise activate bash)"' >> "$SHELL_RC"
        echo "✏️  Added mise activation to $SHELL_RC"
    fi
    
    echo "✅ mise installed successfully!"
fi

# Install tools from mise.toml
echo "🛠️  Installing tools from mise.toml..."
mise install

echo ""
echo "🎉 Bootstrap complete!"
echo ""
echo "Next steps:"
echo "  1. Restart your shell or run: source ~/.zshrc"
echo "  2. Run: mise run setup"
echo "  3. Run: mise run unlock"
echo "  4. Run: mise run check"