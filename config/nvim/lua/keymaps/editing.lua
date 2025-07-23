-- Editing operations keymaps

-- ============================================================================
-- EDITING OPERATIONS
-- ============================================================================

-- Mini.move operations
vim.keymap.set('n', '<leader>mk', function()
  require('mini.move').move_line('up')
end, { desc = 'Move line up' })

vim.keymap.set('n', '<leader>mj', function()
  require('mini.move').move_line('down')
end, { desc = 'Move line down' })

-- Register groups with which-key (deferred until which-key loads)
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require('which-key').add({
      { '<leader>m', group = '[M]ove' },
    })
  end,
})