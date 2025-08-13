-- UI and toggle operations keymaps

-- ============================================================================
-- UI/TOGGLE OPERATIONS
-- ============================================================================

-- UI/Toggle operations
vim.keymap.set('n', '<leader>ul', '<cmd>set number!<CR>', { desc = 'Toggle line numbers' })
vim.keymap.set('n', '<leader>ur', '<cmd>set relativenumber!<CR>', { desc = 'Toggle relative numbers' })

-- Register groups with which-key (deferred until which-key loads)
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require('which-key').add({
      { '<leader>u', group = '[U]I/Toggle' },
    })
  end,
})