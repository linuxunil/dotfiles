return {
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    config = function(_, opts)
      require('flash').setup(opts)
      
      -- Flash navigation keybinds
      vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
        require('flash').jump()
      end, { desc = 'Flash' })
      
      vim.keymap.set({ 'n', 'x', 'o' }, 'S', function()
        require('flash').treesitter()
      end, { desc = 'Flash Treesitter' })
    end,
  },
}
