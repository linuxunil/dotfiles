-- lua/custom/conform-config.lua
-- Extend kickstart's conform.nvim configuration with project-specific formatters

local conform = require('conform')

-- Extend formatters_by_ft with our additional formatters
local additional_formatters = {
  go = { 'goimports', 'gofmt' },
  python = { 'ruff_fix', 'ruff_format' },
  lua = { 'stylua' },
  markdown = { 'prettier' },
}

-- Merge with existing formatters_by_ft
local current_formatters = conform.formatters_by_ft or {}
for ft, formatters in pairs(additional_formatters) do
  current_formatters[ft] = formatters
end

-- Update conform configuration
conform.setup({
  formatters_by_ft = current_formatters,
  -- Keep existing options from kickstart
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
})