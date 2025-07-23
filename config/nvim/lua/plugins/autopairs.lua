-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local npairs = require('nvim-autopairs')
    npairs.setup({
      enable_check_bracket_line = false,
      ignored_next_char = '[%w%.]',
      enable_moveright = true,
      enable_afterquote = true,
      check_ts = true,
      map_bs = true,  -- Map backspace
      map_c_h = true, -- Map ctrl-h to backspace
    })
    
    -- Add specific rule for swallowing words
    local Rule = require('nvim-autopairs.rule')
    npairs.add_rule(Rule('(', ')', 'all')
      :with_move(function(opts)
        return opts.char == ')'
      end)
      :use_key(')')
    )
  end,
}
