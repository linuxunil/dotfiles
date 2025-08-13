-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local npairs = require 'nvim-autopairs'
    local ts_conds = require 'nvim-autopairs.ts-conds'
    npairs.setup {
      enable_check_bracket_line = false,
      ignored_next_char = '[%w%.]',
      enable_moveright = true,
      enable_afterquote = true,
      check_ts = true,
      map_bs = true, -- Map backspace
      map_c_h = true, -- Map ctrl-h to backspace
      ts_config = {
        lua = { 'string' }, -- it will not add a pair on that treesitter node
        javascript = { 'template_string' },
        java = false, -- don't check treesitter on java
        go = { 'string', 'comment' }, -- Don't add pairs in Go strings/comments
        python = { 'string', 'comment' }, -- Don't add pairs in Python strings/comments
        yaml = { 'string' }, -- Don't add pairs in YAML strings
        markdown = { 'code_block' }, -- Don't add pairs in markdown code blocks
      },
    }

    -- Add specific rule for swallowing words
    local Rule = require 'nvim-autopairs.rule'
    npairs.add_rule(Rule('(', ')', 'all'):with_move(function(opts)
      return opts.char == ')'
    end):use_key ')')

    -- Treesitter-based custom rules
    npairs.add_rules {
      -- press % => %% only while inside a comment or string
      Rule('%', '%', 'lua'):with_pair(ts_conds.is_ts_node { 'string', 'comment' }),
      -- press $ => $$ only when NOT inside a function
      Rule('$', '$', 'lua'):with_pair(ts_conds.is_not_ts_node { 'function' }),
      -- Add backticks for Go (useful for raw strings)
      Rule('`', '`', 'go'):with_pair(ts_conds.is_not_ts_node { 'string', 'comment' }),
      -- Add triple quotes for Python docstrings
      Rule('"""', '"""', 'python'):with_pair(ts_conds.is_not_ts_node { 'string' }),
      -- Add single quotes in YAML only outside of strings
      Rule("'", "'", 'yaml'):with_pair(ts_conds.is_not_ts_node { 'string' }),
    }
  end,
}
