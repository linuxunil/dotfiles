-- lua/custom/autocommands.lua
-- Project-specific autocommands

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ===== GENERAL BEHAVIORS =====

-- Highlight on yank (already in kickstart but worth keeping)
autocmd('TextYankPost', {
  group = augroup('YankHighlight', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
  desc = "Highlight yanked text"
})

-- Return to last edit position when opening files
autocmd('BufReadPost', {
  group = augroup('LastPosition', { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "Return to last edit position"
})

-- Auto-create directories when saving a file
autocmd('BufWritePre', {
  group = augroup('AutoCreateDir', { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
  desc = "Create parent directories when saving"
})

-- Auto-resize splits when terminal is resized
autocmd('VimResized', {
  group = augroup('AutoResize', { clear = true }),
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
  desc = "Auto-resize splits on terminal resize"
})

-- ===== LANGUAGE SPECIFIC =====

-- Go configuration
autocmd('FileType', {
  group = augroup('GoSettings', { clear = true }),
  pattern = 'go',
  callback = function()
    -- Go uses tabs, not spaces
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    
    -- Manual formatting keybind will be in keymaps
    -- Format on commit via mise/git hooks
  end,
  desc = "Go specific settings"
})

-- Python configuration (with ruff)
autocmd('FileType', {
  group = augroup('PythonSettings', { clear = true }),
  pattern = 'python',
  callback = function()
    -- Python uses 4 spaces
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    
    -- Set colorcolumn at 88 (ruff's default line length)
    vim.opt_local.colorcolumn = "88"
    
    -- Manual formatting via <leader>f or git hooks with ruff
    
    -- Configure virtual environment detection for uv
    if vim.fn.isdirectory('.venv') == 1 then
      vim.env.VIRTUAL_ENV = vim.fn.getcwd() .. '/.venv'
      vim.env.PATH = vim.env.VIRTUAL_ENV .. '/bin:' .. vim.env.PATH
    end
  end,
  desc = "Python specific settings with ruff/uv"
})

-- SQL configuration
autocmd('FileType', {
  group = augroup('SQLSettings', { clear = true }),
  pattern = { 'sql', 'mysql', 'plsql' },
  callback = function()
    -- SQL uses 2 spaces (common convention)
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    
    -- SQL keywords uppercase
    vim.opt_local.formatoptions:append('r')
  end,
  desc = "SQL specific settings"
})

-- Markdown configuration
autocmd('FileType', {
  group = augroup('MarkdownSettings', { clear = true }),
  pattern = { 'markdown', 'md' },
  callback = function()
    -- Enable spell checking
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
    
    -- Wrap at 80 characters
    vim.opt_local.textwidth = 80
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end,
  desc = "Markdown specific settings"
})

-- Org mode configuration
autocmd('FileType', {
  group = augroup('OrgSettings', { clear = true }),
  pattern = 'org',
  callback = function()
    -- Better folding display
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = 'nc'
    
    -- Spell checking
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
  end,
  desc = "Org mode specific settings"
})

-- YAML configuration
autocmd('FileType', {
  group = augroup('YAMLSettings', { clear = true }),
  pattern = { 'yaml', 'yml' },
  callback = function()
    -- YAML uses 2 spaces
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
  desc = "YAML specific settings"
})

-- ===== PROJECT SPECIFIC =====

-- Automatically set makeprg based on project type
autocmd('BufEnter', {
  group = augroup('ProjectMakeprg', { clear = true }),
  pattern = '*',
  callback = function()
    -- Only set if we're in a project root
    if vim.fn.filereadable('.mise.toml') == 1 then
      vim.opt_local.makeprg = 'mise test'
    elseif vim.fn.filereadable('Makefile') == 1 then
      vim.opt_local.makeprg = 'make'
    elseif vim.fn.filereadable('go.mod') == 1 then
      vim.opt_local.makeprg = 'go build ./...'
    elseif vim.fn.filereadable('pyproject.toml') == 1 then
      vim.opt_local.makeprg = 'uv run pytest'
    end
  end,
  desc = "Set makeprg based on project type"
})

-- Terminal specific settings
autocmd('TermOpen', {
  group = augroup('TerminalSettings', { clear = true }),
  callback = function()
    -- Disable line numbers in terminal
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    
    -- Start in insert mode
    vim.cmd('startinsert')
  end,
  desc = "Terminal specific settings"
})

-- ===== PERFORMANCE =====

-- Disable certain features in large files
autocmd('BufReadPre', {
  group = augroup('LargeFile', { clear = true }),
  callback = function()
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
    if ok and stats and stats.size > max_filesize then
      vim.b.large_file = true
      vim.opt_local.eventignore = 'all'
      vim.opt_local.undofile = false
      vim.opt_local.swapfile = false
      vim.opt_local.loadplugins = false
    end
  end,
  desc = "Optimize for large files"
})
