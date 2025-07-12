-- lua/custom/plugins/init.lua
-- Modern minimal plugin stack

return {
  -- Colorscheme
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup({ contrast = 'hard' })
      vim.cmd.colorscheme 'gruvbox'
    end,
  },

  -- Directory editing (revolutionary workflow)
  {
    'stevearc/oil.nvim',
    keys = {
      { '<leader>e', '<cmd>Oil<cr>', desc = 'File manager' },
    },
    config = function()
      require('oil').setup({
        view_options = {
          show_hidden = true,
        },
      })
    end,
  },

  -- Modern motion (better than leap)
  {
    'folke/flash.nvim',
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
    },
    opts = {},
  },

  -- Quick file switching
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>a', function() require('harpoon'):list():add() end, desc = 'Add to harpoon' },
      { '<leader>h', function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end, desc = 'Harpoon menu' },
      { '<leader>1', function() require('harpoon'):list():select(1) end, desc = 'Harpoon 1' },
      { '<leader>2', function() require('harpoon'):list():select(2) end, desc = 'Harpoon 2' },
      { '<leader>3', function() require('harpoon'):list():select(3) end, desc = 'Harpoon 3' },
      { '<leader>4', function() require('harpoon'):list():select(4) end, desc = 'Harpoon 4' },
    },
    config = function()
      require('harpoon'):setup()
    end,
  },

  -- Undo visualization
  {
    'mbbill/undotree',
    keys = {
      { '<leader>u', vim.cmd.UndotreeToggle, desc = 'Undo tree' },
    },
  },

  -- Git integration (minimal but essential)
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end,
  },

  -- Clean statusline
  {
    'echasnovski/mini.statusline',
    config = function()
      require('mini.statusline').setup()
    end,
  },

  -- Telescope performance boost
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require('telescope').load_extension('fzf')
    end,
  },
}
