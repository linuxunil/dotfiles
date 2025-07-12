-- lua/custom/autocommands.lua
-- Essential autocommands only

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

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

-- Terminal specific settings
autocmd('TermOpen', {
  group = augroup('TerminalSettings', { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.cmd('startinsert')
  end,
  desc = "Terminal specific settings"
})

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
