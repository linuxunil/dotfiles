 return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- high priority for colorschemes
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
      })
      vim.cmd.colorscheme("catppuccin")
    end,
}
