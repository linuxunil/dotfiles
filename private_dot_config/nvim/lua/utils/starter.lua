-- lua/utils/starter.lua
local M = {}

function M.get_theme()
  local function get_quote()
    local quotes = {
      "The future is already here – it's just not evenly distributed.", -- William Gibson
      "Cyberspace. A consensual hallucination experienced daily by billions of legitimate operators, in every nation.", -- William Gibson
      "When you want to get a point across, you can't be subtle.", -- Neal Stephenson, Snow Crash
      "The universe is a big place... If you want to survive, you'd better know the difference.", -- John Scalzi, Old Man's War
      "Information is a weapon. A blade that can be used against your enemies or turned against yourself.", -- Inspired by the genre
    }
    return '"' .. quotes[math.random(#quotes)] .. '"'
  end

  local header = {
    "██████╗  ██╗███████╗ ██████╗  ██████╗ ",
    "██╔══██╗ ██║██╔════╝██╔════╝ ██╔═══██╗",
    "██║  ██║ ██║███████╗██║      ██║   ██║",
    "██║  ██║ ██║╚════██║██║      ██║   ██║",
    "██████╔╝ ██║███████║╚██████╗ ╚██████╔╝",
    "╚═════╝  ╚═╝╚══════╝ ╚═════╝  ╚═════╝ ",
    "                                     ",
    "// BOOT SEQUENCE INITIATED...",
    "// NEURAL INTERFACE: [ONLINE]",
    "// MATRIX CONNECTION: [STABLE]",
  }

  local items = {
    { action = "Telescope find_files", name = "Query Local Filesystem", section = "ACCESS" },
    { action = "Telescope oldfiles", name = "Access Cached Files", section = "ACCESS" },
    { action = "Telescope live_grep", name = "Scan Datastreams (Grep)", section = "ACCESS" },
    { action = "e $MYVIMRC", name = "Edit Core Configuration", section = "SYSTEM" },
    { action = "Lazy", name = "Manage Plugins", section = "SYSTEM" },
    { action = "qa", name = "Jack Out", section = "SYSTEM" },
  }

  return {
    header = table.concat(header, "\n"),
    items = items,
    quote = get_quote(),
  }
end

return M
