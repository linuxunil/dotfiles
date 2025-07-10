-- lua/custom/lint-config.lua
-- Extend kickstart's nvim-lint configuration with project-specific linters

local lint = require('lint')

-- Extend linters_by_ft with our additional linters
local additional_linters = {
  go = { 'golangcilint' },
  python = { 'ruff' },
  markdown = { 'markdownlint' },
}

-- Merge with existing linters_by_ft (kickstart may have set some defaults)
local current_linters = lint.linters_by_ft or {}
for ft, linters in pairs(additional_linters) do
  if current_linters[ft] then
    -- If kickstart already has linters for this filetype, append ours
    for _, linter in ipairs(linters) do
      table.insert(current_linters[ft], linter)
    end
  else
    -- If no existing linters, use ours
    current_linters[ft] = linters
  end
end

-- Update lint configuration
lint.linters_by_ft = current_linters