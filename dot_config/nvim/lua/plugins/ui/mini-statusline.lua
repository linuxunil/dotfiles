-- lua/plugins/ui/mini-statusline.lua
return {
  "echasnovski/mini.statusline",
  lazy = false,
  opts = {
    use_icons = true,
    -- Content sections
    content = {
      -- Active statusline
      active = function()
        return {
          { section = "mode", icon = "" },
          { section = "git", icon = "" },
          { section = "fileinfo", icon = "󰈙" },
          { section = "diagnostics", icon = "󰒡" },
          { section = "location", icon = "󰆞" },
        }
      end,
    },
  },
}
