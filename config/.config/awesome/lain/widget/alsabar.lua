
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013, Luke Bonham                     
      * (c) 2013, Rman                            
                                                  
--]]

local helpers        = require("lain.helpers")
local awful          = require("awful")
local naughty        = require("naughty")
local wibox          = require("wibox")
local math           = { modf   = math.modf }
local string         = { format = string.format,
                         match  = string.match,
                         rep    = string.rep }
local type, tonumber = type, tonumber

-- ALSA volume bar
-- lain.widget.alsabar

local function factory(args)
    local alsabar = {
        colors = {
            background = "#000000",
            mute       = "#EB8F8F",
            unmute     = "#A4CE8A"
        },

        _current_level = 0,
        _mute          = "off"
    }

    local args       = args or {}
    local timeout    = args.timeout or 5
    local settings   = args.settings or function() end
    local width      = args.width or 63
    local height     = args.height or 1
    local ticks      = args.ticks or false
    local ticks_size = args.ticks_size or 7

    alsabar.cmd                 = args.cmd or "amixer"
    alsabar.channel             = args.channel or "Master"
    alsabar.togglechannel       = args.togglechannel
    alsabar.colors              = args.colors or alsabar.colors
    alsabar.followtag           = args.followtag or false
    alsabar.notification_preset = args.notification_preset

    if not alsabar.notification_preset then
        alsabar.notification_preset      = {}
        alsabar.notification_preset.font = "Monospace 10"
    end

    local format_cmd = string.format("%s get %s", alsabar.cmd, alsabar.channel)

    if alsabar.togglechannel then
        format_cmd = { awful.util.shell, "-c", string.format("%s get %s; %s get %s",
        alsabar.cmd, alsabar.channel, alsabar.cmd, alsabar.togglechannel) }
    end

    alsabar.bar = wibox.widget {
        forced_height    = height,
        forced_width     = width,
        color            = alsabar.colors.unmute,
        background_color = alsabar.colors.background,
        margins          = 1,
        paddings         = 1,
        ticks            = ticks,
        ticks_size       = ticks_size,
        widget           = wibox.widget.progressbar
    }

    alsabar.tooltip = awful.tooltip({ objects = { alsabar.bar } })

    function alsabar.update(callback)
        helpers.async(format_cmd, function(mixer)
            local volu, mute = string.match(mixer, "([%d]+)%%.*%[([%l]*)")

            if not volu or not mute then return end

            if volu ~= alsabar._current_level or mute ~= alsabar._mute then
                alsabar._current_level = tonumber(volu)
                alsabar.bar:set_value(alsabar._current_level / 100)
                if alsabar._current_level == 0 or mute == "off" then
                    alsabar._mute = mute
                    alsabar.tooltip:set_text("[Muted]")
                    alsabar.bar.color = alsabar.colors.mute
                else
                    alsabar._mute = "on"
                    alsabar.tooltip:set_text(string.format("%s: %s", alsabar.channel, volu))
                    alsabar.bar.color = alsabar.colors.unmute
                end

                volume_now = {
                    level  = alsabar._current_level,
                    status = alsabar._mute
                }

                settings()

                if type(callback) == "function" then callback() end
            end
        end)
    end

    function alsabar.notify()
        alsabar.update(function()
            local preset = alsabar.notification_preset

            if alsabar._mute == "on" then
                preset.title = string.format("%s - Muted", alsabar.channel)
            else
                preset.title = string.format("%s - %s%%", alsabar.channel, alsabar._current_level)
            end

            int = math.modf((alsabar._current_level / 100) * awful.screen.focused().mywibox.height)
            preset.text = string.format("[%s%s]", string.rep("|", int),
                          string.rep(" ", awful.screen.focused().mywibox.height - int))

            if alsabar.followtag then preset.screen = awful.screen.focused() end

            if not alsabar.notification then
                alsabar.notification = naughty.notify {
                    preset  = preset,
                    destroy = function() alsabar.notification = nil end
                }
            else
                naughty.replace_text(alsabar.notification, preset.title, preset.text)
            end
        end)
    end

    helpers.newtimer(string.format("alsabar-%s-%s", alsabar.cmd, alsabar.channel), timeout, alsabar.update)

    return alsabar
end

return factory
