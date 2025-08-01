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
}
