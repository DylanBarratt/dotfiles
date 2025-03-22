local awful = require("awful")
local wibox = require("wibox")

-- Create a widget with the Wi-Fi icon
local wifi_widget = wibox.widget {
  {
    text   = "  ",
    widget = wibox.widget.textbox,
  },
  widget = wibox.container.margin,
  right = 5,
  left = 5,
}

-- Add a click event to open 'nmtui'
wifi_widget:buttons(
  awful.button({}, 1, function()
    awful.spawn("wezterm -e nmtui", false)
  end)
)

return wifi_widget
