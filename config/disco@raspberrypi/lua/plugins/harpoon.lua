return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  config = function(_, opts)
    local harpoon = require 'harpoon'
    harpoon:setup(opts)

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

    -- Register which-key groups
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        require('which-key').add {
          { '<leader>h', group = '[H]arpoon' },
          { 'gh', group = 'Harpoon' },
        }
      end,
    })
  end,
}
