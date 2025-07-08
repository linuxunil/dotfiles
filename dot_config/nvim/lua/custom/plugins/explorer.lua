-- lua/custom/plugins/explorer.lua
return {
  {
    'echasnovski/snack.nvim',
    config = function()
      require('snack').setup()

      -- Per user request, map to <leader>e
      vim.keymap.set('n', '<leader>e', require('snack').toggle, { desc = 'Toggle file [E]xplorer' })
    end
  }
}
