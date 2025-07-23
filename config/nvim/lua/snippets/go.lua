local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s('ie', {
    t { 'if err != nil {', '\t' },
    i(1, 'return err'),
    t { '', '}' },
  }),

  s('iel', {
    t { 'if err != nil {', '\tlog.Error("Failed to ' },
    i(1, 'create server'),
    t { '", "error", err)', '\tos.Exit(1)', '}' },
  }),
}
