-- Which-key plugin configuration
-- Provides a popup with available keybindings

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      preset = 'modern',
      delay = 300,
      
      win = {
        border = 'rounded',
        padding = { 1, 2 },
        wo = {
          winblend = 10,
        },
      },
      
      layout = {
        width = { min = 20 },
        spacing = 4,
      },
      
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
        },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      
      -- Only register non-vim navigation groups here
      -- All other keybindings are registered in custom/which-key-keymaps.lua
      wk.add({
        -- ===== COMMON NAVIGATION =====
        { ']', group = 'Next ⏭️' },
        { '[', group = 'Previous ⏮️' },
        { 'g', group = 'Go to 🎯' },
        { 'z', group = 'Fold 📁' },
        
        -- ===== DYNAMIC EXTENSIONS =====
        { '<leader>1', hidden = true },
        { '<leader>2', hidden = true },
        { '<leader>3', hidden = true },
        { '<leader>4', hidden = true },
        { '<leader>5', hidden = true },
        { '<leader>6', hidden = true },
        { '<leader>7', hidden = true },
        { '<leader>8', hidden = true },
        { '<leader>9', hidden = true },
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et