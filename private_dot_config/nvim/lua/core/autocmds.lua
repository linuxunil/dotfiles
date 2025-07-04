-- lua/autocmds.lua (Simplified - Essential Only)
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ===== ESSENTIAL EDITOR BEHAVIOR =====

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	group = "YankHighlight",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Auto-resize splits when window is resized
augroup("ResizeSplits", { clear = true })
autocmd("VimResized", {
	group = "ResizeSplits",
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Close some filetypes with <q>
augroup("CloseWithQ", { clear = true })
autocmd("FileType", {
	group = "CloseWithQ",
	pattern = { "help", "lspinfo", "man", "qf", "query", "trouble" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
	end,
})

-- Remove trailing whitespace on save
augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
	group = "TrimWhitespace",
	pattern = "*",
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- Auto-create parent directories when saving
augroup("AutoCreateDir", { clear = true })
autocmd("BufWritePre", {
	group = "AutoCreateDir",
	callback = function(event)
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- ===== REMOVED AUTOCMDS =====
-- The following autocmds were removed because they're handled by other systems:
--
-- ❌ PythonSettings - LSP handles language-specific settings
-- ❌ GoSettings - LSP handles language-specific settings
-- ❌ ZigSettings - LSP handles language-specific settings
-- ❌ PythonVenv - mise integration handles environment detection
-- ❌ GoModule - LSP/go.nvim handles project root detection
-- ❌ ZigBuild - LSP/zig-tools handles project detection
-- ❌ FormatOnSave - conform.nvim handles auto-formatting
--
-- This reduces autocmd overhead and eliminates conflicts between systems.
