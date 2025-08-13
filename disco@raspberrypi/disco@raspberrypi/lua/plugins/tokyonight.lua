return {
  { -- Tokyo Night colorscheme
    'folke/tokyonight.nvim',
    priority = 1000,
    enable = false,
    config = function()
      require('tokyonight').setup {
        style = 'night', -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
        },
      }
      -- Uncomment the line below to use Tokyo Night instead of Catppuccin
      -- vim.cmd.colorscheme("tokyonight")
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
