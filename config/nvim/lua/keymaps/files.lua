-- File and Harpoon operations keymaps

-- ============================================================================
-- FILES OPERATIONS
-- ============================================================================

-- File operations
vim.keymap.set('n', '<leader><leader>', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope git_files<cr>', { desc = '[Files] in [G]it' })
vim.keymap.set('n', '<leader>fn', '<cmd>enew<CR>', { desc = 'New file' })

-- ============================================================================
-- HARPOON OPERATIONS
-- ============================================================================

-- Harpoon operations (deferred until harpoon loads)
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    local harpoon = require 'harpoon'
    -- Core harpoon functionality
    vim.keymap.set('n', 'gha', function()
      harpoon:list():add()
    end, { desc = 'Add file to harpoon' })
    vim.keymap.set('n', 'ghe', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Toggle harpoon menu' })

    -- Quick navigation
    vim.keymap.set('n', 'gh1', function()
      harpoon:list():select(1)
    end, { desc = 'Navigate to file 1' })
    vim.keymap.set('n', 'gh2', function()
      harpoon:list():select(2)
    end, { desc = 'Navigate to file 2' })
    vim.keymap.set('n', 'gh3', function()
      harpoon:list():select(3)
    end, { desc = 'Navigate to file 3' })
    vim.keymap.set('n', 'gh4', function()
      harpoon:list():select(4)
    end, { desc = 'Navigate to file 4' })

    -- Previous & next
    vim.keymap.set('n', 'ghh', function()
      harpoon:list():prev()
    end, { desc = 'Previous harpoon file' })
    vim.keymap.set('n', 'ghl', function()
      harpoon:list():next()
    end, { desc = 'Next harpoon file' })
  end,
})

-- Register groups with which-key (deferred until which-key loads)
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    require('which-key').add {
      { '<leader>f', group = '[F]iles' },
      { '<leader>h', group = '[H]arpoon' },
      { '<leader>p', group = '[P]rojects' },
    }
  end,
})
