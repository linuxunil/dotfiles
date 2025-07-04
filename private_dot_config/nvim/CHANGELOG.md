# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2025-07-03

### Added
- **Modern Theming**: Introduced `tokyonight` as the primary colorscheme and created a matching cyberpunk theme for the Ghostty terminal.
- **Custom Starter Page**: Designed a unique, cyberpunk-themed starter page with custom ASCII art and themed text.
- **Session Management**: Integrated `mini.sessions` to automatically save and restore sessions.
- **Project Management**: Added `project.nvim` for dedicated project management and easy switching between projects.
- **Snippet Engine**: Implemented `luasnip` and integrated it with the completion engine to enable snippet expansion.
- **Enhanced Navigation**: Added `flash.nvim` for superior in-file navigation.
- **Modern UI**: Integrated `noice.nvim` for a cohesive and modern UI for messages and the command line.
- **Documentation**: Created `GEMINI.md` to store user preferences and project context for the Gemini agent.
- **Changelog**: Created this `CHANGELOG.md` to document historical changes.

### Changed
- **Plugin Modernization**:
  - Replaced `lualine` and `bufferline` with `mini.statusline` and `mini.tabline`.
  - Replaced `alpha-nvim` with `mini.starter`.
  - Replaced `iamcco/markdown-preview.nvim` with `toppair/peek.nvim`.
  - Replaced `mini.jump` with `flash.nvim`.
- **Configuration Refactoring**:
  - Restructured the `lua/` directory, moving core files to `lua/core/` and utilities to `lua/utils/`.
  - Consolidated all `<leader>` keymaps into `which-key.lua`.
  - Removed redundant configurations and default values across multiple plugins.
- **Documentation Overhaul**: Updated all markdown documentation to reflect the new plugins, keybindings, and project structure.

### Removed
- **Redundant Plugins**: Removed `lualine`, `bufferline`, `alpha-nvim`, `iamcco/markdown-preview.nvim`, and `mini.jump`.
- **Redundant Configurations**: Removed duplicate and unused configuration files.

## [1.0.0] - Initial Version

- Initial setup of the Neovim configuration with a focus on Go, Python, and Zig development.
- Basic plugin setup with `lazy.nvim`, `catppuccin`, `lualine`, `bufferline`, and other core plugins.
- Initial documentation structure with cheatsheets for each language.
