return {
  'stevearc/oil.nvim',
  lazy = false,
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>e', '<cmd>Oil<cr>', desc = 'Open Oil (current dir)' },
    { '<leader>E', '<cmd>Oil .<cr>', desc = 'Open Oil (cwd)' },
  },
  opts = {
    -- Oil will take over directory buffers (e.g. `vim .`or `:e src/`)
    default_file_explorer = true,
    -- Columns to show in oil buffer
    columns = {
      'icon',
    },
    -- Send deleted files to the trash instead of permanently deleting them
    delete_to_trash = true,
    -- Skip confirmation for simple operations
    skip_confirm_for_simple_edits = false,
    -- Watch filesystem for changes
    watch_for_changes = false,
    constrain_cursor = 'editable',
    -- View options
    view_options = {
      show_hidden = false,
      natrual_order = true,
      case_insensitive = false,
      sort = {
        { 'type', 'asc' },
        { 'name', 'asc' },
      },
    },
  },
}
