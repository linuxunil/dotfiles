# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a domain-based Ansible system configuration management repository that uses:
- Domain-based architecture for clean separation of concerns
- OS-based multi-machine deployment (hera/macOS + athena/Linux)
- Cross-platform support with proper SSH connectivity
- Conditional dotfiles management (only for installed tools)
- Static configuration files managed by git
- Go-task as the primary interface for user commands

## Key Commands

### Domain Installation
```bash
task pkg base             # Install essential CLI tools
task pkg development      # Install development tools and languages  
task pkg gui              # Install GUI applications and desktop
task dot                  # Setup dotfiles symlinks only
task deps                 # Install Ansible Galaxy collections
```

### Development and Maintenance
```bash
task check          # Validate Ansible playbook syntax
task dry-run        # Preview changes without applying
task clean          # Clean broken symlinks in home directory
```

### Standalone Dotfiles Management
```bash
ansible-playbook dotfiles.yml    # Conditional dotfiles (only for installed tools)
```

## Architecture

### Domain-Based Structure
The repository is organized into three main domains:

#### Base Domain
Essential CLI tools for all machines:
- git, curl, wget, unzip, zip, htop, tree
- jq, bat, ripgrep, fzf, fd, neovim, gh, direnv, starship

#### Development Domain  
Programming languages and development tools:
- Languages: Go, Python, Zig (Ruby optional, disabled by default)
- Tools: go-task, lazygit, zoxide, zellij, uv, emacs, helix
- Containers: podman, podman-compose, ansible
- Language servers: zls (for Zig)

#### GUI Domain
Desktop applications and window management:
- **Common (both platforms)**: firefox, discord, obsidian, ghostty, goland, pycharm, zed
- **macOS-specific**: raycast
- **Linux-specific**: Full Hyprland desktop environment with catppuccin-macchiato theme

### Directory Structure
```
├── site.yml              # Main playbook
├── requirements.yml      # Ansible Galaxy collections
├── ansible.cfg          # Ansible configuration
├── Taskfile.yml         # Go-task configuration
├── dotfiles.yml         # Standalone dotfiles playbook
├── inventory/           # Ansible inventory files
│   ├── macos.yml        # macOS machine inventory
│   ├── linux.yml        # Linux machine inventory
│   └── hera.yml         # Specific machine configurations
├── machines/            # Machine template configurations
│   ├── macos.yml        # macOS machine configuration template
│   └── linux.yml        # Linux machine configuration template
├── domains/             # Domain roles
│   ├── base/            # Essential CLI tools
│   ├── development/     # Programming languages & dev tools
│   └── gui/             # GUI applications & desktop
├── playbooks/           # Reusable playbooks
│   └── dotfiles.yml     # Automated dotfiles symlink management
├── templates/           # Jinja2 templates (minimal usage)
│   ├── environment.j2   # Environment variables
│   ├── dev_aliases.j2   # Development aliases
│   └── *.j2             # GUI theming templates
└── config/              # Static configuration files (git-managed)
    ├── zsh/             # Shell configuration (zshrc)
    ├── git/             # Git configuration
    ├── nvim/            # Neovim configuration (kickstart-based)
    ├── zellij/          # Terminal multiplexer with development layouts
    ├── ghostty/         # Terminal emulator config
    ├── helix/           # Helix editor configuration
    ├── zed/             # Zed editor configuration
    ├── emacs/           # Emacs configuration files
    ├── jetbrains/       # JetBrains IDE settings
    ├── starship/        # Shell prompt configuration
    └── ...              # Other application configs
```

### Inventory vs Machines Structure

#### Inventory Files (`inventory/`)
Ansible inventory files that define actual deployment targets:
- `localhost.yml` - Local machine (auto-detects macOS/Linux)
- `macos.yml` - All macOS machines (if needed)
- `linux.yml` - All Linux machines (if needed)
- `hera.yml` - Remote macOS machine (SSH)

#### Machine Templates (`machines/`) - DEPRECATED
Configuration templates that define machine capabilities (information moved to inventory):
```yaml
# machines/macos.yml
domains: [base, development, gui]
languages: [go, python, zig]

# machines/linux.yml  
domains: [base, development, gui]
languages: [go, python, zig]
```

### Domain Role Structure
Each domain follows Ansible best practices:
```
domains/domainname/
├── tasks/main.yml         # Main tasks
├── tasks/languages/       # Language-specific tasks (development only)
├── defaults/main.yml      # Default variables
├── vars/Darwin.yml        # macOS-specific variables
├── vars/RedHat.yml        # Linux-specific variables
└── meta/main.yml          # Role metadata
```

## Development Guidelines

### Installing Dependencies
Always run `task deps` first to ensure Galaxy collections are installed.

### Domain Setup
- **Specific domain**: `task pkg base|development|gui`
- **All domains**: Run each domain task individually

### Adding New Packages
1. Edit the appropriate domain's `defaults/main.yml`
2. Add platform-specific packages in `vars/Darwin.yml` or `vars/RedHat.yml`
3. Test with `task dry-run`

### Managing Dotfiles
1. **Edit dotfiles directly** in the `config/` directory
2. **Conditional symlinking** - configs only linked for installed tools
3. **Tool detection** - automatically checks which tools are available
4. **Special files** (like `.zshenv`, `.zprofile`) are defined in `playbooks/dotfiles.yml`
5. **Never modify dotfiles with Ansible** - they are static files managed by Git
6. Run `task dot` to update symlinks
7. **Standalone conditional setup** via `ansible-playbook dotfiles.yml`

### Language Management
Languages are configured per machine in the machine declaration:
- **Enabled languages** are listed in the `languages` array
- **Language settings** are in the `language_setup` section
- **Ruby** is disabled by default but available when explicitly enabled

### Testing Changes
```bash
task check        # Syntax validation
task dry-run      # Preview changes
```

## Platform Considerations

- **macOS**: Uses Homebrew, includes Raycast
- **Linux**: Uses DNF + Flatpak, includes full Hyprland desktop
- **Theming**: Everything uses catppuccin-macchiato theme
- **Container Runtime**: Podman (cross-platform)
- **Python Management**: UV (modern Python package manager)
- **Shell**: Zsh with Starship prompt

## Key Features

### Automated Dotfiles Management
- **Dynamic discovery**: All directories in `config/` are automatically symlinked to `~/.config/`
- **Special files handling**: Shell files and other special locations defined in playbook
- **Static configuration**: All config files are git-managed, never generated
- **Catppuccin-macchiato theming**: Pre-configured across all applications

### Domain Dependencies
- Development domain depends on base domain
- GUI domain depends on base domain
- Clean separation allows selective installation

### Multi-Machine Architecture
- **OS-based deployment**: Configure all macOS or all Linux machines
- **SSH connectivity**: Remote deployment between hera ↔ athena
- **Conditional configs**: Only symlink configurations for installed tools
- **Cross-platform consistency**: Same software stack where possible
- **Platform-specific handling**: Homebrew vs DNF, Cask vs Flatpak

## Configuration Notes

### Neovim Setup
- Uses **kickstart.nvim** as the base configuration
- Located in `config/nvim/` with modern Lua-based setup
- Includes language servers, completion, and development tools
- Catppuccin theme pre-configured

### Zellij Development Layouts
- Multiple pre-configured development layouts in `config/zellij/layouts/`
- Language-specific layouts: `go-dev`, `python-dev`, `rust-dev`, `ts-dev`
- IDE-specific layouts: `goland-dev`, `pycharm-dev`, `zed-dev`, `helix-dev`
- Special purpose: `docker-dev`, `ansible-dev`, `general-dev`

### Tool Installation Improvements
- **Starship**: Cross-platform binary installer (works on both macOS and Linux)
- **Mise language management**: Idempotent with proper version checking
- **JetBrains Mono Nerd Font**: Enhanced font with icons and glyphs for terminals
- **Conditional tool configs**: Only symlink configs for actually installed tools

## Best Practices

1. **Simplicity**: Domain declarations are simple and readable
2. **Static Configuration**: All config files are git-managed, not generated
3. **Multi-machine deployment**: Same commands configure all machines of the same OS
4. **Conditional configuration**: Only install configs for tools that are present
5. **SSH connectivity**: Ensure proper key-based authentication between machines
6. **Testing**: Always validate changes with `task dry-run` before applying
7. **Dotfiles Organization**: Keep all application configs in `config/` directory

## Claude Code Guidance

### Working Method
- I want to do the actual implementation unless otherwise told.

### Important Notes
- The **README.md** appears outdated and refers to old task names and structure
- **CLAUDE.md** is the authoritative documentation for this repository
- Current task interface uses `task pkg <domain>` not the old `task base|dev|gui` pattern shown in README
- The `machines/` directory is deprecated - machine configuration is now in inventory files