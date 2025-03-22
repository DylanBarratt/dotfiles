local awful = require("awful")
local wibox = require("wibox")

local bluetoothWidget = wibox.widget {
  {
    text   = "󰂯 ",
    widget = wibox.widget.textbox,
  },
  widget = wibox.container.margin,
  right = 5,
  left = 5,
}

bluetoothWidget:buttons(
  awful.button({}, 1, function()
    awful.spawn("blueberry", false)
  end)
)

return bluetoothWidget
