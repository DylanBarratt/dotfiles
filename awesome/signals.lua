local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

client.connect_signal("request::titlebars", function(c)
  local titlebar = awful.titlebar(c)

  local icon_widget = wibox.widget {
    {
      widget = wibox.widget.imagebox,
      image = c.icon,
      resize = true,
    },
    left = 5,
    widget = wibox.container.margin
  }

  local close_button = wibox.widget {
    {
      text = " ",
      font = "JetBrainsMono Nerd Font 12", -- Set a Nerd Font or similar
      align = "center",
      valign = "center",
      widget = wibox.widget.textbox
    },
    right = 10,
    widget = wibox.container.margin
  }
  close_button:buttons(
    awful.button({}, 1, function()
      c:kill()
    end)
  )

  -- Set up layout
  titlebar:setup {
    {
      icon_widget,
      margins = 5,
      widget = wibox.container.margin
    },
    nil,
    {
      close_button,
      widget = wibox.container.margin
    },
    layout = wibox.layout.align.horizontal
  }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
