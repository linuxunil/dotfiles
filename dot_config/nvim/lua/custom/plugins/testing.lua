-- lua/custom/plugins/testing.lua
return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-go',
      'nvim-neotest/neotest-python',
      'nvim-neotest/neotest-zig',
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-go'),
          require('neotest-python')({
            dap = { justMyCode = false },
          }),
          require('neotest-zig'),
        },
      })
        -- Example keymaps
      vim.keymap.set('n', '<leader>tt', function() require('neotest').run.run() end, { desc = "Run nearest test" })
      vim.keymap.set('n', '<leader>tf', function() require('neotest').run.run(vim.fn.expand('%')) end, { desc = "Run tests in current file" })
      vim.keymap.set('n', '<leader>ts', function() require('neotest').summary.toggle() end, { desc = "Toggle test summary" })
      vim.keymap.set('n', '<leader>to', function() require('neotest').output.open({ enter = true }) end, { desc = "Show test output" })
    end,
  },
}