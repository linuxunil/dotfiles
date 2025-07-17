# macOS Migration: Nix → Ansible

Safe migration strategy from Nix configuration to Ansible system management.

## Migration Strategy

### **Option 1: Clean Slate (Recommended)**
Complete fresh start with maximum cleanliness.

### **Option 2: Gradual Migration** 
Keep Nix running while testing Ansible.

### **Option 3: Parallel Systems**
Run both systems side-by-side temporarily.

---

## Option 1: Clean Slate Migration (Recommended)

### **Phase 1: Backup Everything**
```bash
# 1. Backup current dotfiles
mkdir -p ~/migration-backup/$(date +%Y%m%d)
cp ~/.zshrc ~/migration-backup/$(date +%Y%m%d)/
cp ~/.gitconfig ~/migration-backup/$(date +%Y%m%d)/
cp -r ~/.config ~/migration-backup/$(date +%Y%m%d)/

# 2. Export current package list
brew list > ~/migration-backup/$(date +%Y%m%d)/brew-packages.txt
brew list --cask > ~/migration-backup/$(date +%Y%m%d)/brew-casks.txt

# 3. Export current settings
defaults read > ~/migration-backup/$(date +%Y%m%d)/macos-defaults.plist

# 4. Backup important data
# - SSH keys (~/.ssh/)
# - GPG keys (~/.gnupg/)
# - Application data you care about
```

### **Phase 2: Clean Nix Removal**
```bash
# 1. Stop Nix services
sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
sudo rm /Library/LaunchDaemons/org.nixos.nix-daemon.plist

# 2. Remove Nix store and profiles
sudo rm -rf /nix
sudo rm -rf ~/.nix-*
sudo rm -rf ~/.local/state/nix
sudo rm -rf ~/.cache/nix

# 3. Clean shell configuration
# Remove Nix lines from ~/.zshrc
sed -i.bak '/nix/d' ~/.zshrc
sed -i.bak '/NIX_/d' ~/.zshrc

# 4. Remove Nix users and groups
sudo dscl . -delete /Groups/nixbld
for i in $(seq 1 32); do
  sudo dscl . -delete /Users/_nixbld$i 2>/dev/null || true
done

# 5. Clean up PATH
# Edit ~/.zshrc to remove Nix paths
```

### **Phase 3: Fresh Ansible Setup**
```bash
# 1. Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Install Ansible
brew install ansible

# 3. Install Task
brew install go-task/tap/go-task

# 4. Clone/setup Ansible configuration
cd ~/.nix/ansible  # or wherever you have it

# 5. Run full setup
task all
```

---

## Option 2: Gradual Migration

### **Phase 1: Test Ansible Alongside Nix**
```bash
# 1. Keep Nix running
# 2. Install Ansible via Homebrew (separate from Nix)
brew install ansible go-task/tap/go-task

# 3. Test Ansible setup with different tags
task base --dry-run    # See what would be installed
task dev --dry-run     # Check development tools
task gui --dry-run     # Check GUI applications

# 4. Run Ansible for non-conflicting parts
task base              # Install base tools
# Skip overlapping packages
```

### **Phase 2: Gradual Replacement**
```bash
# 1. Stop using Nix for new packages
# 2. Let Ansible manage new installations
# 3. Gradually remove Nix packages you don't need
# 4. Eventually remove Nix entirely
```

---

## Option 3: Parallel Systems (Safest)

### **Setup**
```bash
# 1. Keep Nix as-is
# 2. Install Ansible via Homebrew
# 3. Use different prefixes/paths
# 4. Test thoroughly before switching
```

---

## Detailed Cleanup Procedures

### **Nix Complete Removal**
```bash
#!/bin/bash
# nix-cleanup.sh - Complete Nix removal

echo "🧹 Starting Nix cleanup..."

# Stop services
echo "Stopping Nix daemon..."
sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist 2>/dev/null || true
sudo rm -f /Library/LaunchDaemons/org.nixos.nix-daemon.plist

# Remove Nix store
echo "Removing Nix store..."
sudo rm -rf /nix

# Remove user data
echo "Removing user Nix data..."
rm -rf ~/.nix-*
rm -rf ~/.local/state/nix
rm -rf ~/.cache/nix

# Remove users and groups
echo "Removing Nix users..."
sudo dscl . -delete /Groups/nixbld 2>/dev/null || true
for i in $(seq 1 32); do
  sudo dscl . -delete /Users/_nixbld$i 2>/dev/null || true
done

# Clean shell config
echo "Cleaning shell configuration..."
if [[ -f ~/.zshrc ]]; then
  cp ~/.zshrc ~/.zshrc.pre-cleanup
  grep -v -E "(nix|NIX_)" ~/.zshrc > ~/.zshrc.tmp
  mv ~/.zshrc.tmp ~/.zshrc
fi

# Clean synthetic.conf
echo "Cleaning synthetic.conf..."
sudo sed -i.bak '/nix/d' /etc/synthetic.conf 2>/dev/null || true

echo "✅ Nix cleanup complete!"
echo "💡 Reboot recommended to ensure all changes take effect"
```

### **Homebrew Cleanup (if needed)**
```bash
# Clean Homebrew completely
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

# Reinstall fresh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### **Application Data Migration**
```bash
# Important data to preserve:
# - SSH keys: ~/.ssh/
# - GPG keys: ~/.gnupg/
# - Git config: ~/.gitconfig
# - Shell history: ~/.zsh_history
# - Application preferences you care about

# Copy to safe location before cleanup
mkdir -p ~/safe-backup
cp -r ~/.ssh ~/safe-backup/
cp -r ~/.gnupg ~/safe-backup/
cp ~/.gitconfig ~/safe-backup/
cp ~/.zsh_history ~/safe-backup/
```

---

## Migration Checklist

### **Pre-Migration**
- [ ] Backup all important data
- [ ] Export current package lists
- [ ] Document current system state
- [ ] Test Ansible setup in VM/container
- [ ] Ensure you have admin access

### **During Migration**
- [ ] Stop Nix services
- [ ] Remove Nix completely
- [ ] Clean shell configuration
- [ ] Install fresh Homebrew
- [ ] Install Ansible + Task
- [ ] Run Ansible setup

### **Post-Migration**
- [ ] Verify all tools work
- [ ] Restore important data
- [ ] Test development workflow
- [ ] Update documentation
- [ ] Remove backup files (after confirming)

---

## Rollback Plan

If something goes wrong:

```bash
# 1. Restore dotfiles from backup
cp ~/migration-backup/$(date +%Y%m%d)/.zshrc ~/
cp ~/migration-backup/$(date +%Y%m%d)/.gitconfig ~/

# 2. Reinstall Nix
curl -L https://nixos.org/nix/install | sh

# 3. Restore Nix configuration
# (if you have it backed up)
```

---

## Recommended Approach

**For your situation, I recommend Option 1 (Clean Slate):**

1. ✅ **Complete fresh start**
2. ✅ **No conflicts between systems**
3. ✅ **Cleaner final result**
4. ✅ **Easier to maintain**
5. ✅ **Matches your simplicity goals**

**Timeline:**
- **Weekend project**: 2-4 hours total
- **Backup**: 30 minutes
- **Cleanup**: 30 minutes  
- **Fresh setup**: 1-2 hours
- **Testing/tweaking**: 1 hour

The clean slate approach aligns perfectly with your goal of escaping Nix complexity!