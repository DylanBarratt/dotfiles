local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local textClock = wibox.widget {
  format = ' /  %b %d  %H:%M',
  widget = wibox.widget.textclock
}

-- local month_calendar = awful.widget.calendar_popup.month()
-- month_calendar:attach(textClockWidget, "tc")

local battery = require("theme.widgets.battery")
local logout = require("theme.widgets.logout-menu")
local wifi = require("theme.widgets.wifi")
local bluetooth = require("theme.widgets.bluetooth")

awful.screen.connect_for_each_screen(function(s)
  -- Each screen has its own tag table.
  awful.tag({ "1", "2" }, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      logout({}),
      s.mypromptbox,
    },
    {
      layout = wibox.layout.fixed.horizontal,
      textClock,
    },
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wifi,
      bluetooth,
      battery({ margin_left = 0, margin_right = 15 }),
    },
  }
end)
