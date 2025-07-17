# Repository Structure

Clean, organized Ansible configuration for system management.

## Directory Layout

```
├── Taskfile.yml              # Task runner (go-task) configuration
├── setup.yml                 # Single Ansible playbook with tags
├── ansible.cfg               # Ansible configuration
├── hosts                     # Inventory file
├── .gitignore                # Git ignore rules
├── README.md                 # Main documentation
│
├── scripts/                  # Utility scripts
│   ├── migration-backup.sh   # Pre-migration backup
│   └── nix-cleanup.sh        # Nix removal script
│
├── dotfiles/                 # Configuration files
│   ├── shell/
│   │   ├── zshrc             # Main shell configuration
│   │   └── aliases           # Task and system aliases
│   ├── git/
│   │   └── gitconfig         # Git configuration
│   ├── nvim/
│   │   └── init.lua          # Neovim configuration
│   ├── terminal/
│   │   ├── ghostty/config    # Ghostty terminal (macOS)
│   │   ├── alacritty/        # Alacritty terminal (Linux)
│   │   └── zellij/config.kdl # Terminal multiplexer
│   └── wm/                   # Window managers
│       ├── yabai/yabairc     # macOS tiling WM
│       ├── skhd/skhdrc       # macOS hotkeys
│       ├── hyprland/         # Linux Wayland compositor
│       └── i3/config         # Linux X11 window manager
│
└── docs/                     # Documentation
    ├── MIGRATION.md          # Nix → Ansible migration guide
    ├── PROJECT_SETUP.md      # Project creation guide
    └── STRUCTURE.md          # This file
```

## File Purposes

### Core Files
- **Taskfile.yml**: Task runner configuration with all automation
- **setup.yml**: Single Ansible playbook with tags for modular execution
- **ansible.cfg**: Ansible settings (inventory, callbacks, etc.)
- **hosts**: Machine inventory (local, macos, linux, homelab)

### Scripts
- **migration-backup.sh**: Complete backup before migration
- **nix-cleanup.sh**: Safe Nix removal for clean migration

### Dotfiles
- **shell/**: Shell configuration and aliases
- **git/**: Git configuration
- **nvim/**: Neovim editor configuration
- **terminal/**: Terminal emulator configurations
- **wm/**: Window manager configurations

### Documentation
- **README.md**: Main usage guide
- **MIGRATION.md**: Migration from Nix guide
- **PROJECT_SETUP.md**: Project creation guide
- **STRUCTURE.md**: Repository organization

## Design Principles

1. **Single Source of Truth**: One playbook (`setup.yml`) with tags
2. **Task-Based**: Use Task runner for all operations
3. **Modular**: Tags allow selective execution
4. **Cross-Platform**: Works on macOS and Linux
5. **Simple**: No complex templating or logic
6. **Maintainable**: Clear structure, easy to modify

## Tag System

The setup.yml playbook uses tags for modular execution:

- `base`: Essential CLI tools
- `dev`: Development environment
- `gui`: GUI applications
- `platform`: OS-specific configuration
- `macos`: macOS-specific tasks
- `linux`: Linux-specific tasks
- `dotfiles`: Configuration file linking
- `shell`: Shell enhancement setup
- `all`: Everything for current platform

## Usage Patterns

```bash
# Full setup
task all

# Incremental setup
task base
task dev
task gui

# Platform-specific
task macos
task linux

# Maintenance
task clean
task update
task status
```

This structure provides maximum simplicity while maintaining full functionality.