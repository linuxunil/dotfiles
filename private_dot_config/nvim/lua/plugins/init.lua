-- lua/plugins/init.lua - Centralized Plugin Loader
-- This file organizes plugin loading by category and priority

return {
	-- ===== CORE FUNCTIONALITY (Load Early) =====
	-- Essential plugins that other plugins depend on
	{ import = "plugins.core.luasnip" }, -- Snippet engine
	{ import = "plugins.core.completion" }, -- Blink.cmp - completion engine
	{ import = "plugins.core.lsp" }, -- Language server protocol
	{ import = "plugins.core.formatting" }, -- Code formatting with conform
	{ import = "plugins.core.debugging" }, -- Debug adapter protocol

	-- ===== UI COMPONENTS (Load Immediately) =====
	-- UI plugins that affect visual appearance should load early
	{ import = "plugins.ui.theme" }, -- Catppuccin colorscheme
	{ import = "plugins.ui.mini-statusline" }, -- Minimal statusline
	{ import = "plugins.ui.mini-tabline" }, -- Modern bufferline
	{ import = "plugins.ui.telescope" }, -- Fuzzy finder
	{ import = "plugins.ui.mini-starter" }, -- Minimal starter screen
	{ import = "plugins.ui.noice" }, -- Modern UI for messages and cmdline
	{ import = "plugins.ui.visual" }, -- Visual enhancements

	-- ===== EDITING ENHANCEMENTS (Load on Demand) =====
	-- Plugins that enhance editing experience
	{ import = "plugins.editing.mini" }, -- Mini.nvim ecosystem
	{ import = "plugins.editing.flash" }, -- Modern navigation
	{ import = "plugins.editing.treesitter" }, -- Syntax highlighting & parsing
	{ import = "plugins.editing.git" }, -- Git integration

	-- ===== LANGUAGE-SPECIFIC (Load by Filetype) =====
	-- These plugins only load when working with specific languages
	{ import = "plugins.lang.go" }, -- Go development tools
	{ import = "plugins.lang.python" }, -- Python development tools
	{ import = "plugins.lang.zig" }, -- Zig development tools
	-- { import = "plugins.lang.web" },       -- JS/TS tools (future)

	-- ===== NOTES & DOCUMENTATION =====
	-- Writing and documentation tools
	{ import = "plugins.notes.markdown" }, -- Markdown editing & preview
	{ import = "plugins.notes.neorg" }, -- Advanced note-taking

	-- ===== TOOLS & UTILITIES (Load on Command/Key) =====
	-- Utility plugins that are used occasionally
	{ import = "plugins.tools.project" }, -- Project management
	{ import = "plugins.tools.snacks" }, -- Swiss-army knife utilities
	{ import = "plugins.tools.todo-comments" }, -- Todo comment management
	{ import = "plugins.tools.which-key" }, -- Keybinding help system
}

--[[
Plugin Loading Strategy:

1. CORE: Essential functionality that other plugins depend on
   - Loaded early to ensure dependencies are available
   - Includes LSP, completion, formatting, debugging

2. UI: Visual components that affect appearance
   - Loaded immediately for consistent visual experience
   - Includes theme, statusline, bufferline, telescope

3. EDITING: Enhancements to editing experience
   - Loaded on demand (VeryLazy, events, etc.)
   - Includes mini.nvim, treesitter, git integration

4. LANGUAGE: Language-specific tooling
   - Loaded by filetype for performance
   - Includes Go, Python, Zig specific tools

5. NOTES: Writing and documentation
   - Loaded when working with documentation
   - Includes Markdown and Neorg

6. TOOLS: Utilities and helpers
   - Loaded on command or keypress
   - Includes snacks, todo-comments, which-key

This organization ensures:
- Fast startup (only essential plugins load immediately)
- Good user experience (UI loads early)
- Efficient resource usage (language tools load only when needed)
- Clear separation of concerns (easy to maintain)
]]
