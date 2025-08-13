return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  opts = {
    options = {
      mode = 'buffers',
      separator_style = 'thick', -- "slant", "padded_slant", "thick", "thin"
      always_show_bufferline = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      diagnostics = 'nvim_lsp',
      color_icons = true,
      offsets = {
        -- {
        --   filetype = 'neo-tree',
        --   text = 'File Explorer',
        --   text_align = 'center',
        -- },
      },
    },
  },
}
