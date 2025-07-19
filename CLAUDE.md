# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a domain-based Ansible system configuration management repository that uses:
- Domain-based architecture for clean separation of concerns
- Simple machine declarations for easy machine setup
- Cross-platform support (macOS and Linux)
- Static dotfiles managed by git
- Go-task as the primary interface for user commands

## Key Commands

### Machine Setup
```bash
task macos          # Configure complete macOS machine
task linux          # Configure complete Linux machine
task install-deps   # Install Ansible Galaxy collections
```

### Domain Installation
```bash
task base           # Install essential CLI tools
task development    # Install development tools and languages
task gui            # Install GUI applications and desktop
task dotfiles       # Setup dotfiles symlinks only
```

### Development and Maintenance
```bash
task check          # Validate Ansible playbook syntax
task dry-run        # Preview changes without applying
task clean          # Clean broken symlinks
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
├── machines/            # Machine declarations
│   ├── macos.yml        # macOS machine configuration
│   └── linux.yml        # Linux machine configuration
├── domains/             # Domain roles
│   ├── base/            # Essential CLI tools
│   ├── development/     # Programming languages & dev tools
│   └── gui/             # GUI applications & desktop
├── playbooks/           # Reusable playbooks
│   └── dotfiles.yml     # Dotfiles symlink management
├── templates/           # Jinja2 templates (minimal usage)
│   ├── environment.j2   # Environment variables
│   ├── dev_aliases.j2   # Development aliases
│   └── *.j2             # GUI theming templates
└── dotfiles/            # Static configuration files (git-managed)
    ├── shell/           # Shell configs (zshrc, aliases)
    ├── git/             # Git configuration
    ├── nvim/            # Neovim configuration
    ├── terminal/        # Terminal and multiplexer configs
    └── ...              # Other application configs
```

### Machine Declarations
Simple YAML files define what each machine type should have:

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
Always run `task install-deps` first to ensure Galaxy collections are installed.

### Machine Setup
- **macOS**: `task macos` 
- **Linux**: `task linux`
- **Specific domain**: `task base|development|gui`

### Adding New Packages
1. Edit the appropriate domain's `defaults/main.yml`
2. Add platform-specific packages in `vars/Darwin.yml` or `vars/RedHat.yml`
3. Test with `task dry-run`

### Managing Dotfiles
1. **Edit dotfiles directly** in the `dotfiles/` directory
2. **Add new dotfiles** by updating `playbooks/dotfiles.yml` symlink list
3. **Never modify dotfiles with Ansible** - they are static files managed by Git
4. Run `task dotfiles` to update symlinks

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

### Minimal Templating
- Templates only used for font customization and platform-specific environment variables
- Most configuration files are static and git-managed
- Catppuccin-macchiato theming is pre-configured

### Domain Dependencies
- Development domain depends on base domain
- GUI domain depends on base domain
- Clean separation allows selective installation

### Cross-Platform Consistency
- Same software stack across macOS and Linux (where possible)
- Platform-specific implementations handled transparently
- Consistent development environment

## Best Practices

1. **Simplicity**: Domain declarations are simple and readable
2. **Static Configuration**: Dotfiles are managed by git, not generated
3. **Platform Abstraction**: Same commands work across platforms
4. **Selective Installation**: Install only needed domains
5. **Testing**: Always validate changes before applying