-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
    },
    opts = {
      -- Formatting
      goimports = 'gopls',
      gofmt = 'gofumpt',
      -- LSP
      lsp_cfg = false,
      lsp_on_attach = false,
      -- Inlay
      lsp_inlay_hints = {
        enable = true,
        show_parameter_hints = true,
        parameter_hints_prefix = '󰊕 ',
      },
      --Debug
      dap_debug_keymap = false,
    },
    ft = 'go',
  },
}
