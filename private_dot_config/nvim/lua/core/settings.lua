-- lua/settings.lua (Enhanced with performance optimizations)
local opt = vim.opt
local g = vim.g

-- Leader key
g.mapleader = " "
g.maplocalleader = " "

-- ===== PERFORMANCE OPTIMIZATIONS =====
opt.lazyredraw = false -- Don't redraw during macros (can cause issues with modern plugins)
opt.ttyfast = true -- Fast terminal connection
opt.synmaxcol = 300 -- Limit syntax highlighting on long lines (performance)
opt.updatetime = 200 -- Faster completion and diagnostics
opt.timeoutlen = 300 -- Faster which-key popup

-- ===== UI IMPROVEMENTS =====
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.showmode = false
opt.cmdheight = 1
opt.pumheight = 10
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Better whitespace visualization
opt.list = true
opt.listchars = {
	tab = "→ ",
	trail = "·",
	nbsp = "␣",
	extends = "▶",
	precedes = "◀",
}
opt.fillchars = {
	eob = " ", -- Remove ~ from empty lines
	fold = " ",
	foldopen = "▾",
	foldsep = " ",
	foldclose = "▸",
}

-- ===== BEHAVIOR =====
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- ===== SEARCH =====
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- ===== COMPLETION =====
opt.completeopt = { "menu", "menuone", "noselect" }
opt.shortmess:append("c")

-- ===== INDENTATION =====
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.breakindent = true

-- ===== SPLITS =====
opt.splitbelow = true
opt.splitright = true

-- ===== FOLDING =====
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
opt.foldlevel = 99
opt.foldlevelstart = 99
