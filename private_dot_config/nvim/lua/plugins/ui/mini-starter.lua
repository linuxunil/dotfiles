-- lua/plugins/ui/mini-starter.lua
return {
  "echasnovski/mini.starter",
  lazy = false,
  config = function()
    local starter = require("utils.starter").get_theme()
    require("mini.starter").setup({
      header = starter.header,
      items = starter.items,
      footer = starter.quote,
    })
  end,
}
