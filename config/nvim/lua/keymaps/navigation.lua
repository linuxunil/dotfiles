-- Navigation operations keymaps

-- ============================================================================
-- CORE NAVIGATION AND EDITING
-- ============================================================================

-- Basic keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })
vim.keymap.set('n', '<leader>q', function()
  vim.diagnostic.setloclist()
end, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Buffer navigation
vim.keymap.set('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })

-- Diagnostic navigation
vim.keymap.set('n', '<leader>dn', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Next diagnostic' })

vim.keymap.set('n', '<leader>dp', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Previous diagnostic' })

-- ============================================================================
-- WINDOW MANAGEMENT
-- ============================================================================

-- Window management
vim.keymap.set('n', '<leader>wsd', '<C-w>s', { desc = 'Split window below' })
vim.keymap.set('n', '<leader>wsr', '<C-w>v', { desc = 'Split window right' })
vim.keymap.set('n', '<leader>wd', '<C-w>c', { desc = 'Delete window' })

-- ============================================================================
-- BUFFER OPERATIONS
-- ============================================================================

-- Buffer operations
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })

-- ============================================================================
-- JUMP OPERATIONS
-- ============================================================================

-- Jump operations
vim.keymap.set('n', '<leader>jj', '<cmd>Telescope jumplist<cr>', { desc = 'Jump list' })
vim.keymap.set('n', '<leader>jm', '<cmd>Telescope marks<cr>', { desc = 'Marks' })

-- ============================================================================
-- FLASH NAVIGATION
-- ============================================================================

-- Flash navigation
vim.keymap.set({ 'n', 'x', 'o' }, 'gs', function()
  require('flash').jump()
end, { desc = 'Flash' })

vim.keymap.set({ 'n', 'x', 'o' }, 'gS', function()
  require('flash').treesitter()
end, { desc = 'Flash Treesitter' })

-- Register groups with which-key (deferred until which-key loads)
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require('which-key').add {
      { '<leader>w', group = '[W]indow' },
      { '<leader>b', group = '[B]uffers' },
      { '<leader>j', group = '[J]ump' },
    }
  end,
})
