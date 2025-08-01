-- Git operations keymaps

-- ============================================================================
-- GIT OPERATIONS
-- ============================================================================

-- Git hunk navigation
vim.keymap.set('n', ']h', function()
  local gitsigns = require 'gitsigns'
  if vim.wo.diff then
    vim.cmd.normal { ']c', bang = true }
  else
    gitsigns.nav_hunk 'next'
  end
end, { desc = 'Next git hunk' })

vim.keymap.set('n', '[h', function()
  local gitsigns = require 'gitsigns'
  if vim.wo.diff then
    vim.cmd.normal { '[c', bang = true }
  else
    gitsigns.nav_hunk 'prev'
  end
end, { desc = 'Previous git hunk' })

vim.keymap.set('n', ']H', function()
  require('gitsigns').nav_hunk 'last'
end, { desc = 'Last git hunk' })

vim.keymap.set('n', '[H', function()
  require('gitsigns').nav_hunk 'first'
end, { desc = 'First git hunk' })

-- Git operations
vim.keymap.set('n', '<leader>Gs', function()
  require('gitsigns').stage_hunk()
end, { desc = 'Git [s]tage hunk' })

vim.keymap.set('v', '<leader>Gs', function()
  require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
end, { desc = 'Git [s]tage hunk' })

vim.keymap.set('n', '<leader>Gr', function()
  require('gitsigns').reset_hunk()
end, { desc = 'Git [r]eset hunk' })

vim.keymap.set('v', '<leader>Gr', function()
  require('gitsigns').reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
end, { desc = 'Git [r]eset hunk' })

vim.keymap.set('n', '<leader>GS', function()
  require('gitsigns').stage_buffer()
end, { desc = 'Git [S]tage buffer' })

vim.keymap.set('n', '<leader>Gu', function()
  require('gitsigns').undo_stage_hunk()
end, { desc = 'Git [u]ndo stage hunk' })

vim.keymap.set('n', '<leader>GR', function()
  require('gitsigns').reset_buffer()
end, { desc = 'Git [R]eset buffer' })

vim.keymap.set('n', '<leader>Gp', function()
  require('gitsigns').preview_hunk()
end, { desc = 'Git [p]review hunk' })

vim.keymap.set('n', '<leader>Gb', function()
  require('gitsigns').blame_line()
end, { desc = 'Git [b]lame line' })

vim.keymap.set('n', '<leader>Gd', function()
  require('gitsigns').diffthis()
end, { desc = 'Git [d]iff against index' })

vim.keymap.set('n', '<leader>GD', function()
  require('gitsigns').diffthis '@'
end, { desc = 'Git [D]iff against last commit' })
-- Neogit operations
vim.keymap.set('n', '<leader>Gg', function()
  require('neogit').open()
end, { desc = 'Open Neo[g]it' })

vim.keymap.set('n', '<leader>Gc', function()
  require('neogit').open { 'commit' }
end, { desc = 'Git [c]ommit' })

vim.keymap.set('n', '<leader>Gl', function()
  require('neogit').open { 'log' }
end, { desc = 'Git [l]og' })

vim.keymap.set('n', '<leader>Gf', function()
  require('neogit').open { kind = 'floating' }
end, { desc = 'Git [f]loating window' })
-- Register groups with which-key (deferred until which-key loads)
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require('which-key').add {
      { '<leader>G', group = '[G]it' },
    }
  end,
})
