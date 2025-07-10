-- lua/custom/options.lua
-- Glimpse-specific options

local opt = vim.opt

-- Add mise to PATH for Go/Python tools
vim.env.PATH = vim.env.HOME .. '/.local/share/mise/shims:' .. vim.env.PATH

-- UI improvements
opt.relativenumber = true -- Show relative line numbers
opt.termguicolors = true  -- Better colors in terminal

-- Better search experience
opt.hlsearch = true
opt.incsearch = true

-- No backup files (using git)
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Persistent undo with custom directory
opt.undodir = vim.fn.stdpath('data') .. '/undo'
opt.undofile = true

-- Better completion experience
opt.completeopt = 'menuone,noselect,noinsert'
opt.pumheight = 10 -- Limit popup menu height

-- Always show tabline and global statusline
opt.showtabline = 2
opt.laststatus = 3

-- Faster key response
opt.timeoutlen = 300
opt.ttimeoutlen = 0

-- Better splits
opt.splitkeep = "screen"

-- Folding (using treesitter)
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

-- Column indicators
opt.colorcolumn = '100' -- Glimpse uses 100 char line limit for Go
opt.signcolumn = 'yes:1' -- Always show sign column with fixed width

-- Better diffs
opt.diffopt:append('linematch:60')

-- File specific settings will be handled by autocommands
