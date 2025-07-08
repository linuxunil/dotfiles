-- lua/plugins/core/luasnip.lua
return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
  },
  keys = {
    { "<tab>", function() require("luasnip").jump(1) end, mode = "i" },
    { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
    { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
  },
}
