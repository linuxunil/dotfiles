# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a standardized Ansible-based system configuration management repository that uses:
- Ansible Galaxy collections for community-maintained modules
- Standard Ansible roles structure for better organization
- Go-task as the primary interface for user commands
- Cross-platform support (macOS and Fedora/RedHat)
- Proper inventory structure for easy machine declaration

## Key Commands

### Setup and Installation
```bash
task install-deps  # Install Ansible Galaxy collections
task base          # Install essential CLI tools (zsh, git, neovim, etc.)
task dev           # Install development tools (containers, languages, databases)
task dotfiles      # Configure dotfiles and shell
task gui           # Install GUI applications
task all           # Complete setup for current platform
task bootstrap     # Quick setup for new machines (recommended)
```

### Development and Maintenance
```bash
task check         # Validate Ansible playbook syntax
task dry-run       # Preview changes without applying
task test          # Safe test run with --check flag
task clean         # Clean broken symlinks
task update        # Update package managers (brew/apt)
task status        # Show what's installed
task maintenance   # Run full system maintenance
```

### Testing Commands
```bash
task test-dev         # Test dev role with Molecule (containerized testing)
task test-dev-quick   # Quick test of dev role (converge + verify only)
task test-dev-verify  # Run verification tests only
task test-dev-clean   # Clean up dev role test containers
task test-all-roles   # Test all roles with Molecule
```

### Information Commands
```bash
task inventory    # Show Ansible inventory
task facts        # Gather and display system facts
```

## Architecture

### Standardized Ansible Structure
- `site.yml` is the main playbook that includes all roles
- `requirements.yml` defines Galaxy collections dependencies
- Uses community collections:
  - `community.general` for package management (homebrew, flatpak)
  - `ansible.posix` for POSIX utilities
  - `community.docker` for container management

### Directory Structure
```
├── site.yml           # Main playbook
├── requirements.yml   # Galaxy dependencies
├── ansible.cfg        # Ansible configuration
├── Taskfile.yml       # Go-task configuration
├── inventory/         # Inventory files
│   └── hosts.yml     # Host definitions
├── roles/            # Standard Ansible roles
│   ├── base/         # Core system packages
│   ├── dev/          # Development tools (with Molecule testing)
│   ├── gui/          # GUI applications
│   ├── package_manager/ # Package manager setup
│   ├── dotfiles/     # Configuration management
│   └── shell/        # Shell configuration
├── dotfiles/         # Configuration files
│   ├── shell/        # Shell configs (zshrc, aliases)
│   ├── git/          # Git configuration
│   ├── nvim/         # Neovim configuration
│   ├── terminal/     # Terminal configs
│   └── wm/           # Window manager configs
├── tasks/            # Common Ansible tasks
└── *.yml             # Individual playbooks (base.yml, dev.yml, etc.)
```

### Role Structure
Each role follows Ansible best practices:
```
roles/rolename/
├── tasks/main.yml      # Main tasks
├── defaults/main.yml   # Default variables
├── vars/main.yml       # Role variables
├── files/              # Static files
├── templates/          # Jinja2 templates
└── handlers/main.yml   # Event handlers
```

### Task Runner Integration
- All operations go through `task` command (go-task)
- Taskfile.yml defines all available commands
- Shell aliases are set up for quick access (e.g., `dot-base` → `task base`)

## Development Guidelines

### Installing Dependencies
Always run `task install-deps` first to ensure Galaxy collections are installed.

### Adding New Packages
1. Edit the appropriate role's `defaults/main.yml` to add packages
2. Update the role's `tasks/main.yml` if new logic is needed
3. Use community collections for package management:
   - `community.general.homebrew` for macOS
   - `ansible.builtin.apt` for Debian/Ubuntu
   - `ansible.builtin.dnf` for Fedora/RedHat
   - `community.general.flatpak` for GUI apps on Linux
4. Test with `task dry-run` before applying

### Managing Dotfiles
1. **Edit dotfiles directly** in the `dotfiles/` directory (e.g., `dotfiles/shell/zshrc`)
2. **Add new dotfiles** by updating `roles/dotfiles/defaults/main.yml` to include the symlink
3. **Never modify dotfiles with Ansible** - they should be static files managed by Git
4. The dotfiles role only handles symlinking, not content modification

### Creating New Roles
1. Create role structure: `mkdir -p roles/newrole/{tasks,defaults,vars}`
2. Add role to `site.yml` with appropriate tags
3. Follow Ansible best practices for idempotency

### Testing Changes
Always test Ansible changes before applying:
```bash
task check      # Syntax validation
task dry-run    # Preview all changes
task test       # Safe test run
```

## Platform Considerations

- **macOS**: Uses Homebrew (via `community.general.homebrew`)
- **Fedora**: Uses DNF package manager, includes RPM Fusion repositories
- **Debian/Ubuntu**: Uses APT package manager
- **Linux GUI**: Uses Flatpak for cross-distribution GUI applications
- Platform detection is automatic via Ansible facts
- GUI applications only installed on systems with displays
- Container runtime: Podman (cross-platform)
- Python management: UV (modern Python package manager)

## Key Ansible Collections Used

- **community.general**: Package managers (homebrew, flatpak), system utilities
- **ansible.posix**: File operations, system configuration
- **community.docker**: Container management (works with Podman)
- **ansible.builtin**: Core Ansible functionality

## Testing and Quality Assurance

### Molecule Testing
The dev role includes comprehensive Molecule testing for containerized validation:
- **Full test suite**: `task test-dev` - runs create, converge, verify, destroy
- **Quick testing**: `task test-dev-quick` - converge and verify only
- **Verification only**: `task test-dev-verify` - run tests on existing container
- **Cleanup**: `task test-dev-clean` - destroy test containers
- **Direct script**: `./test-dev-role.sh [scenario]` - alternative test runner

### Python/UV Environment
- Uses UV for Python package management and virtual environments
- Dev dependencies managed in `pyproject.toml`:
  - `ansible-lint` for linting playbooks
  - `molecule[podman]` for containerized testing
  - `yamllint` for YAML validation
- Install dev dependencies: `uv sync --dev`

### Linting and Validation
```bash
task check         # Ansible syntax validation
uv run ansible-lint site.yml  # Lint playbooks
uv run yamllint .  # Validate YAML syntax
```

## Best Practices

1. **Idempotency**: All tasks should be safe to run multiple times
2. **Tags**: Use tags consistently for selective execution
3. **Variables**: Define defaults in `defaults/main.yml`, override in `vars/`
4. **Testing**: Always use `--check` mode before applying changes
5. **Collections**: Prefer community collections over shell commands