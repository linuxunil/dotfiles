# System Configuration with Ansible + Task

Simple, maintainable system configuration using Ansible orchestrated by Task (Go-based task runner).

## Quick Start

### 🚀 One-line macOS Bootstrap
```bash
curl -fsSL https://raw.githubusercontent.com/linuxunil/nix-config/main/ansible/scripts/bootstrap-macos.sh | bash
```

### Manual Setup
```bash
# Install Task (if not already installed)
brew install go-task/tap/go-task  # macOS
# or: go install github.com/go-task/task/v3/cmd/task@latest

# Bootstrap new machine
task bootstrap

# Or step by step
task base    # Essential tools
task dev     # Development environment  
task gui     # GUI applications
task macos   # Platform-specific (or 'task linux')
```

## Task Commands

### **Setup Commands**
```bash
task base       # Essential CLI tools (git, curl, bat, ripgrep, fzf)
task dev        # Development tools (neovim, tmux, go, python, node)
task gui        # GUI apps (firefox, vscode, discord, obsidian)
task macos      # macOS-specific (podman, system preferences)
task linux      # Linux-specific (i3, docker, desktop environment)
task all        # Everything for current platform
```

### **Maintenance Commands**
```bash
task clean      # Remove broken symlinks and temp files
task update     # Update package managers (brew/apt)
task status     # Show what's installed vs missing
task info       # System information
```

### **Development Commands**
```bash
task check      # Validate Ansible syntax
task dry-run    # Show what would be done
task test       # Safe test run
task bootstrap  # Quick new machine setup
```

### **Utility Commands**
```bash
task backup-dotfiles    # Backup existing configs
task restore-dotfiles   # Restore from backup
task inventory         # Show Ansible inventory
task facts            # Display system facts
```

## Why Task?

**Perfect for Go developers:**
- ✅ **Go-based**: Fast, reliable, single binary
- ✅ **YAML syntax**: Familiar and readable
- ✅ **Dependencies**: Smart task dependencies (`deps`)
- ✅ **Platform detection**: Automatic OS/arch detection
- ✅ **File watching**: Only run when files change (`sources`)
- ✅ **Variables**: Built-in templating with `{{.VAR}}`
- ✅ **Includes**: Modular task organization

**Advanced Features Used:**
```yaml
# Dependencies - 'dev' runs 'base' first
dev:
  deps: [base]
  
# Platform-specific tasks
macos:
  platforms: [darwin]
  
# File change detection
base:
  sources:
    - "setup.yml"
    - "dotfiles/shell/*"
    
# Variables and templating
cmds:
  - echo "OS: {{.OS}}"
```

## Structure

```
├── Taskfile.yml         # Task runner configuration
├── setup.yml           # Single Ansible playbook with tags
├── ansible.cfg          # Ansible configuration
├── hosts               # Inventory file
├── scripts/            # Migration and utility scripts
├── dotfiles/           # Configuration files
│   ├── shell/          # Shell configuration
│   ├── git/            # Git configuration
│   ├── nvim/           # Neovim configuration
│   ├── terminal/       # Terminal configs
│   └── wm/             # Window manager configs
└── docs/               # Documentation
    ├── MIGRATION.md    # Migration guide
    └── PROJECT_SETUP.md # Project creation guide
```
├── Taskfile.yml         # Task definitions
├── setup.yml           # Single Ansible playbook
├── ansible.cfg          # Ansible configuration
├── hosts               # Inventory
└── dotfiles/           # Configuration files
    ├── shell/          # Shell configuration
    ├── git/            # Git configuration
    ├── nvim/           # Neovim configuration
    ├── terminal/       # Terminal configs
    └── wm/             # Window manager configs
```

## Examples

### **New Machine Setup**
```bash
# Quick bootstrap
task bootstrap

# Or manual control
task base && task dev && task gui && task macos
```

### **Development Workflow**
```bash
# Check what would change
task dry-run

# Update system
task update

# Check status
task status
```

### **Maintenance**
```bash
# Clean up
task clean

# Backup before changes
task backup-dotfiles

# Test configuration
task check
```

## Task vs Alternatives

| Tool | Pros | Cons |
|------|------|------|
| **Task** | Go-based, YAML, dependencies, fast | Need to install |
| Make | Universal, simple | Platform differences, cryptic syntax |
| Just | Rust-based, simple syntax | Less features than Task |
| Shell script | Zero dependencies | No advanced features |

**Task wins for Go developers** - familiar ecosystem, powerful features, excellent performance.

## Installation

```bash
# macOS
brew install go-task/tap/go-task

# Linux
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d

# Go install
go install github.com/go-task/task/v3/cmd/task@latest

# Verify
task --version
```

## Configuration

Task automatically detects:
- **OS**: `{{.OS}}` (darwin/linux)
- **Architecture**: `{{.ARCH}}` (amd64/arm64)
- **Platform-specific tasks**: Only run on correct OS

Perfect for cross-platform development workflows!