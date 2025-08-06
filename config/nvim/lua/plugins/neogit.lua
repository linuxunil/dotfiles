return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    integrations = {
      telescope = true,
      diffview = true,
    },
    kind = 'tab',
    disable_line_numbers = true,
    -- Use your catppuccin theme
    highlight = {
      italic = true,
      bold = true,
      underline = true,
    },
    -- Auto refresh after git operations
    auto_refresh = true,
    -- Remember settings per project
    use_per_project_settings = true,
    -- Show recent commits in status
    status = {
      recent_commit_count = 10,
    },
    -- Configure signs to match your style
    signs = {
      hunk = { '󰐖', '󰍴' }, -- Plus/minus
      item = { '󰅂', '󰅀' }, -- Chevron right/down
      section = { '󰅂', '󰅀' }, -- Chevron right/down
    },
  },
  config = function(_, opts)
    require('neogit').setup(opts)
    
    -- Neogit operations
    vim.keymap.set('n', '<leader>Gg', function()
      require('neogit').open()
    end, { desc = 'Open Neo[g]it' })
    
    vim.keymap.set('n', '<leader>Gc', function()
      require('neogit').open { 'commit' }
    end, { desc = 'Git [c]ommit' })
    
    vim.keymap.set('n', '<leader>Gl', function()
      require('neogit').open { 'log' }
    end, { desc = 'Git [l]og' })
    
    vim.keymap.set('n', '<leader>Gf', function()
      require('neogit').open { kind = 'floating' }
    end, { desc = 'Git [f]loating window' })
  end,
}
