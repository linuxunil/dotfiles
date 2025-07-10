# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a **kickstart-modular.nvim** configuration - a modular fork of kickstart.nvim that provides a starting point for Neovim configuration. The architecture follows a layered approach:

**Core Structure:**
- `init.lua` - Entry point, loads core modules in order
- `lua/options.lua` - Basic Neovim options
- `lua/keymaps.lua` - Basic keymaps and autocommands
- `lua/lazy-bootstrap.lua` - Lazy.nvim plugin manager setup
- `lua/lazy-plugins.lua` - Plugin specifications and configuration
- `lua/custom/` - User customizations and extensions

**Plugin Architecture:**
- Built on **lazy.nvim** plugin manager with lazy loading
- Uses modular plugin loading via `require 'kickstart.plugins.X'`
- Custom plugins loaded via `{ import = 'custom.plugins' }`
- Plugins are organized by functionality (LSP, UI, utilities, etc.)

**Key Design Patterns:**
- **Modular configuration**: Each plugin in its own file
- **Lazy loading**: Plugins load on-demand via keys, events, filetypes
- **Extensible**: Custom configurations extend rather than replace kickstart
- **Documentation-driven**: Every setting has explanatory comments

## Development Commands

**Plugin Management:**
```bash
# Check plugin status
nvim +Lazy

# Update all plugins
nvim +Lazy update

# Clean unused plugins
nvim +Lazy clean
```

**Configuration Testing:**
```bash
# Check health of configuration
nvim +checkhealth

# Test specific plugin health
nvim +checkhealth telescope
nvim +checkhealth lsp
```

**Maintenance:**
```bash
# Validate Lua syntax
luacheck lua/

# Check for configuration issues
nvim --headless +checkhealth +qall
```

## Key Configuration Areas

### Custom Configuration (`lua/custom/`)

**File Structure:**
- `init.lua` - Loads all custom modules
- `options.lua` - Project-specific options (includes mise setup)
- `keymaps.lua` - Project-specific keymaps with external tool integration
- `autocommands.lua` - Language-specific and project-specific autocmds
- `plugins/init.lua` - Custom plugin specifications

**Custom Plugins Notable Features:**
- **Gruvbox theme** with hard contrast
- **Mini.nvim ecosystem** for UI components (tabline, file explorer, etc.)
- **Harpoon v2** for quick file navigation
- **Leap.nvim** for fast cursor movement
- **Neotest** for Go/Python testing
- **Obsidian.nvim** for note-taking

### Development Environment Integration

**External Tools (configured in keymaps):**
- **mise** - Development environment management (`<leader>m*` commands)
- **lazygit** - Git interface via zellij (`<leader>gg`)
- **lazysql** - Database interface via zellij (`<leader>db`)
- **zellij** - Terminal multiplexer integration

**Language Support:**
- **Go**: Uses tabs, 100-char line limit, golangci-lint + goimports
- **Python**: 4 spaces, 88-char limit (ruff), .venv detection
- **SQL**: 2 spaces, schema navigation shortcuts
- **Markdown**: Spell checking, 80-char wrapping

**Project Detection:**
- Auto-detects project type via `.mise.toml`, `Makefile`, `go.mod`, `pyproject.toml`
- Sets appropriate `makeprg` and development commands
- Configures PATH for mise shims

## Plugin Configuration Guidelines

**When adding new plugins:**
1. Add to `lua/custom/plugins/init.lua` for project-specific plugins
2. Use lazy loading with appropriate triggers (keys, events, filetypes)
3. Group related plugins by functionality
4. Document the purpose and key bindings

**Plugin categories already established:**
- **UI & Colorscheme** (priority 1000)
- **Essential Mini Modules** (priority 600-700)
- **File & Buffer Management**
- **Motion & Navigation**
- **Testing**
- **LSP Enhancements**

## Common Development Workflows

**File Navigation:**
- `<leader>e` - Mini.files explorer
- `<leader>sf` - Telescope frecency (recent files)
- `<leader>a` - Add to Harpoon, `<C-e>` - Harpoon menu
- `<leader>p*` - Project-specific file shortcuts (README, schema, config, etc.)

**Code Actions:**
- `<leader>f` - Format buffer (manual)
- `<leader>ca` - LSP code actions
- `<leader>tn` - Run nearest test
- `<leader>mt` - Run all tests via mise

**Git Operations:**
- `<leader>gg` - LazyGit in zellij
- `<leader>h*` - Git hunk operations via gitsigns
- `]g` / `[g` - Navigate git hunks

**External Tool Integration:**
- Uses zellij for terminal multiplexing
- Integrates with mise for language tooling
- Supports both make and mise-based projects

## Special Considerations

**Performance Optimizations:**
- Large file detection disables heavy features
- Lazy loading reduces startup time
- Mini.nvim modules are lightweight alternatives

**Environment Setup:**
- Requires mise in PATH for development tools
- Assumes zellij as terminal multiplexer
- Requires external tools: lazygit, lazysql, ripgrep, fd-find

**Philosophy:**
- Unix Philosophy: Small, focused tools
- Plain text configuration
- Composable external tools
- No lock-in to specific implementations