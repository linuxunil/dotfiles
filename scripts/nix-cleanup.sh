#!/bin/bash
# Complete Nix removal script for macOS
# Run with: bash nix-cleanup.sh

set -e

echo "🧹 Nix Complete Cleanup Script"
echo "=============================="
echo ""
echo "This will completely remove Nix from your macOS system."
echo "Make sure you have backed up any important data!"
echo ""
read -p "Continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

echo ""
echo "📦 Creating backup..."
backup_dir="$HOME/nix-removal-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup_dir"

# Backup important files
if [[ -f ~/.zshrc ]]; then
    cp ~/.zshrc "$backup_dir/zshrc.backup"
    echo "✅ Backed up ~/.zshrc"
fi

if [[ -f ~/.bashrc ]]; then
    cp ~/.bashrc "$backup_dir/bashrc.backup"
    echo "✅ Backed up ~/.bashrc"
fi

if [[ -f ~/.bash_profile ]]; then
    cp ~/.bash_profile "$backup_dir/bash_profile.backup"
    echo "✅ Backed up ~/.bash_profile"
fi

echo "📁 Backup created at: $backup_dir"
echo ""

echo "🛑 Stopping Nix daemon..."
sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist 2>/dev/null || true
sudo rm -f /Library/LaunchDaemons/org.nixos.nix-daemon.plist
echo "✅ Nix daemon stopped"

echo ""
echo "🗂️ Removing Nix store and data..."
sudo rm -rf /nix
echo "✅ Removed /nix"

rm -rf ~/.nix-*
rm -rf ~/.local/state/nix 2>/dev/null || true
rm -rf ~/.cache/nix 2>/dev/null || true
echo "✅ Removed user Nix data"

echo ""
echo "👥 Removing Nix users and groups..."
sudo dscl . -delete /Groups/nixbld 2>/dev/null || true
for i in $(seq 1 32); do
    sudo dscl . -delete /Users/_nixbld$i 2>/dev/null || true
done
echo "✅ Removed Nix users and groups"

echo ""
echo "🧽 Cleaning shell configuration..."

# Clean ~/.zshrc
if [[ -f ~/.zshrc ]]; then
    # Remove Nix-related lines
    grep -v -E "(nix|NIX_|/nix/)" ~/.zshrc > ~/.zshrc.tmp || true
    mv ~/.zshrc.tmp ~/.zshrc
    echo "✅ Cleaned ~/.zshrc"
fi

# Clean ~/.bashrc
if [[ -f ~/.bashrc ]]; then
    grep -v -E "(nix|NIX_|/nix/)" ~/.bashrc > ~/.bashrc.tmp || true
    mv ~/.bashrc.tmp ~/.bashrc
    echo "✅ Cleaned ~/.bashrc"
fi

# Clean ~/.bash_profile
if [[ -f ~/.bash_profile ]]; then
    grep -v -E "(nix|NIX_|/nix/)" ~/.bash_profile > ~/.bash_profile.tmp || true
    mv ~/.bash_profile.tmp ~/.bash_profile
    echo "✅ Cleaned ~/.bash_profile"
fi

echo ""
echo "🔧 Cleaning system configuration..."

# Clean synthetic.conf
if [[ -f /etc/synthetic.conf ]]; then
    sudo cp /etc/synthetic.conf /etc/synthetic.conf.backup
    sudo sed -i.bak '/nix/d' /etc/synthetic.conf 2>/dev/null || true
    echo "✅ Cleaned /etc/synthetic.conf"
fi

# Remove Nix from /etc/shells
if [[ -f /etc/shells ]]; then
    sudo cp /etc/shells /etc/shells.backup
    sudo sed -i.bak '/nix/d' /etc/shells 2>/dev/null || true
    echo "✅ Cleaned /etc/shells"
fi

echo ""
echo "🎉 Nix removal complete!"
echo ""
echo "📋 Summary:"
echo "  - Nix daemon stopped and removed"
echo "  - /nix directory removed"
echo "  - User Nix data removed"
echo "  - Nix users and groups removed"
echo "  - Shell configurations cleaned"
echo "  - System configurations cleaned"
echo ""
echo "💾 Backups saved to: $backup_dir"
echo ""
echo "⚠️  IMPORTANT:"
echo "  1. Restart your terminal or run: exec zsh"
echo "  2. Reboot is recommended to ensure all changes take effect"
echo "  3. You can now install Ansible and run the new setup"
echo ""
echo "🚀 Next steps:"
echo "  brew install ansible go-task/tap/go-task"
echo "  cd ~/.nix/ansible && task all"