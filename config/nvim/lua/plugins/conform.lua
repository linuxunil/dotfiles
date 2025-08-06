return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        go = { 'gofumpt', 'goimports' },
        -- Conform can also run multiple formatters sequentially
        python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      formatters = {
        ruff_format = {
          command = function()
            -- Check if we're in a uv project
            local uv_lock = vim.fn.findfile('uv.lock', '.;')
            local pyproject = vim.fn.findfile('pyproject.toml', '.;')

            if uv_lock ~= '' or pyproject ~= '' then
              return 'uv'
            else
              return 'ruff'
            end
          end,
          args = function()
            -- Check if we're in a uv project
            local uv_lock = vim.fn.findfile('uv.lock', '.;')
            local pyproject = vim.fn.findfile('pyproject.toml', '.;')

            if uv_lock ~= '' or pyproject ~= '' then
              return { 'run', 'ruff', 'format', '--stdin-filename', '$FILENAME', '-' }
            else
              return { 'format', '--stdin-filename', '$FILENAME', '-' }
            end
          end,
          stdin = true,
        },
        ruff_organize_imports = {
          command = function()
            -- Check if we're in a uv project
            local uv_lock = vim.fn.findfile('uv.lock', '.;')
            local pyproject = vim.fn.findfile('pyproject.toml', '.;')

            if uv_lock ~= '' or pyproject ~= '' then
              return 'uv'
            else
              return 'ruff'
            end
          end,
          args = function()
            -- Check if we're in a uv project
            local uv_lock = vim.fn.findfile('uv.lock', '.;')
            local pyproject = vim.fn.findfile('pyproject.toml', '.;')

            if uv_lock ~= '' or pyproject ~= '' then
              return { 'run', 'ruff', 'check', '--select', 'I', '--fix', '--stdin-filename', '$FILENAME', '-' }
            else
              return { 'check', '--select', 'I', '--fix', '--stdin-filename', '$FILENAME', '-' }
            end
          end,
          stdin = true,
        },
      },
    },
    config = function(_, opts)
      require('conform').setup(opts)
      
      -- Code formatting keybind
      vim.keymap.set('n', '<leader>cf', function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end, { desc = 'Code [f]ormat' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
