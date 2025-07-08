-- lua/plugins/editing/oil.lua
return {
  "stevearc/oil.nvim",
  lazy = false,
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      -- Add git status icons
      columns = {
        "icon",
        "git",
      },
      view_options = {
        -- By default, hidden files are not shown
        show_hidden = false,
      },
      -- Set up keymaps for the oil buffer
      keymaps = {
        ["g."] = "actions.toggle_hidden",
      },
    })

    -- Keymap to open oil, replacing the old snacks explorer keymap
    vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "Open parent directory" })
  end,
}