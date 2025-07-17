#!/bin/bash
# macOS Bootstrap Script
# Quick setup for new macOS machines

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on macOS
check_macos() {
    if [[ "$(uname)" != "Darwin" ]]; then
        log_error "This script is designed for macOS only!"
        exit 1
    fi
    log_success "Running on macOS $(sw_vers -productVersion)"
}

# Install Command Line Tools if not present
install_xcode_tools() {
    log_info "Checking for Xcode Command Line Tools..."
    
    if ! xcode-select -p &>/dev/null; then
        log_info "Installing Xcode Command Line Tools..."
        xcode-select --install
        
        # Wait for installation to complete
        log_info "Please complete the Xcode Command Line Tools installation in the dialog, then press any key to continue..."
        read -n 1 -s
        
        # Verify installation
        if ! xcode-select -p &>/dev/null; then
            log_error "Xcode Command Line Tools installation failed!"
            exit 1
        fi
    fi
    
    log_success "Xcode Command Line Tools are installed"
}

# Install Homebrew if not present
install_homebrew() {
    log_info "Checking for Homebrew..."
    
    if ! command -v brew &>/dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ -f "/opt/homebrew/bin/brew" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    else
        log_info "Updating Homebrew..."
        brew update
    fi
    
    log_success "Homebrew is ready"
}

# Install essential tools via Homebrew
install_essentials() {
    log_info "Installing essential tools..."
    
    local tools=(
        "git"
        "ansible"
        "go-task"
        "gh"
    )
    
    for tool in "${tools[@]}"; do
        if ! brew list "$tool" &>/dev/null; then
            log_info "Installing $tool..."
            brew install "$tool"
        else
            log_info "$tool is already installed"
        fi
    done
    
    log_success "Essential tools installed"
}

# Configure Git if needed
configure_git() {
    log_info "Configuring Git..."
    
    if [[ -z "$(git config --global user.name 2>/dev/null || true)" ]]; then
        echo -n "Enter your Git username: "
        read -r git_username
        git config --global user.name "$git_username"
    fi
    
    if [[ -z "$(git config --global user.email 2>/dev/null || true)" ]]; then
        echo -n "Enter your Git email: "
        read -r git_email
        git config --global user.email "$git_email"
    fi
    
    # Set some sensible defaults
    git config --global init.defaultBranch main
    git config --global pull.rebase true
    git config --global fetch.prune true
    
    log_success "Git configured"
}

# Clone or update the dotfiles repository
setup_dotfiles() {
    local repo_url="https://github.com/linuxunil/nix-config.git"
    local dotfiles_dir="$HOME/.config/dotfiles"
    
    log_info "Setting up dotfiles..."
    
    if [[ -d "$dotfiles_dir" ]]; then
        log_info "Updating existing dotfiles..."
        cd "$dotfiles_dir"
        git pull origin main
    else
        log_info "Cloning dotfiles repository..."
        mkdir -p "$(dirname "$dotfiles_dir")"
        git clone "$repo_url" "$dotfiles_dir"
        cd "$dotfiles_dir"
    fi
    
    log_success "Dotfiles repository ready at $dotfiles_dir"
}

# Run Ansible setup
run_ansible_setup() {
    local setup_type="${1:-bootstrap}"
    local dotfiles_dir="$HOME/.config/dotfiles"
    
    log_info "Running Ansible setup ($setup_type)..."
    
    cd "$dotfiles_dir/ansible"
    
    # Install Ansible dependencies
    log_info "Installing Ansible dependencies..."
    ansible-galaxy collection install -r requirements.yml
    
    # Run the appropriate setup
    case "$setup_type" in
        "minimal")
            task base
            ;;
        "bootstrap")
            task bootstrap
            ;;
        "full")
            task all
            ;;
        *)
            log_warning "Unknown setup type: $setup_type. Running bootstrap..."
            task bootstrap
            ;;
    esac
    
    log_success "Ansible setup complete!"
}

# Display next steps
show_next_steps() {
    log_success "Bootstrap complete! 🎉"
    echo
    log_info "Next steps:"
    echo "  • Restart your terminal to use the new shell configuration"
    echo "  • Run 'task gui' to install GUI applications"
    echo "  • Run 'task all' for a full setup"
    echo "  • Configure your GitHub CLI with 'gh auth login'"
    echo
    log_info "Available commands:"
    echo "  • task --list    - Show all available tasks"
    echo "  • task status    - Check installed tools"
    echo "  • task info      - Show system information"
    echo
    log_info "Dotfiles location: $HOME/.config/dotfiles"
}

# Main execution
main() {
    local setup_type="${1:-bootstrap}"
    
    echo "🚀 macOS Bootstrap Script"
    echo "========================="
    echo
    
    log_info "Setup type: $setup_type"
    echo
    
    check_macos
    install_xcode_tools
    install_homebrew
    install_essentials
    configure_git
    setup_dotfiles
    run_ansible_setup "$setup_type"
    show_next_steps
}

# Help function
show_help() {
    echo "macOS Bootstrap Script"
    echo
    echo "Usage: $0 [setup_type]"
    echo
    echo "Setup types:"
    echo "  minimal    - Only base tools (git, curl, etc.)"
    echo "  bootstrap  - Base + development tools (default)"
    echo "  full       - Complete setup with GUI apps"
    echo
    echo "Examples:"
    echo "  $0              # Run bootstrap setup"
    echo "  $0 minimal      # Minimal setup"
    echo "  $0 full         # Full setup"
}

# Handle arguments
if [[ $# -gt 0 ]]; then
    case "$1" in
        "-h"|"--help"|"help")
            show_help
            exit 0
            ;;
        *)
            main "$1"
            ;;
    esac
else
    main
fi