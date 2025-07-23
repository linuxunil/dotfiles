-- Search operations keymaps

-- ============================================================================
-- SEARCH OPERATIONS
-- ============================================================================

-- Search operations
vim.keymap.set('n', '<leader>sh', '<cmd>Telescope help_tags<cr>', { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', '<cmd>Telescope keymaps<cr>', { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', '<cmd>Telescope find_files<cr>', { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', '<cmd>Telescope builtin<cr>', { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', '<cmd>Telescope grep_string<cr>', { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', '<cmd>Telescope live_grep<cr>', { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', '<cmd>Telescope diagnostics<cr>', { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', '<cmd>Telescope resume<cr>', { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', '<cmd>Telescope oldfiles<cr>', { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>sb', '<cmd>Telescope buffers<cr>', { desc = '[S]earch existing [B]uffers' })

vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>s/', function()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

vim.keymap.set('n', '<leader>sn', function()
  require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-- Register groups with which-key (deferred until which-key loads)
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require('which-key').add {
      { '<leader>s', group = '[S]earch' },
    }
  end,
})

