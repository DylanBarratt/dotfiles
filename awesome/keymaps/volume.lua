local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")

-- Store the active notification ID
local current_notification_id = nil

-- Function to get volume and show notification
local function show_volume(icon)
  awful.spawn.easy_async_with_shell("pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1 {print $5}' | tr -d '%'",
    function(stdout)
      awful.spawn.easy_async_with_shell(
        "pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}'",
        function(stdout_mute)
          local volume = tonumber(stdout) or 0
          local is_muted = stdout_mute:match("yes") and true or false
          local volume_text = "<span font='Sans Bold 20' rise='5000'>" ..
              (is_muted and " " or icon .. "  " .. volume .. "%") .. "</span>"

          -- Update existing notification without destroying it
          local notification = naughty.notify({
            title = nil,
            text = volume_text,
            timeout = 1, -- Resets timeout properly
            position = "bottom_middle",
            shape = gears.shape.rounded_rect,
            app_name = "Volume",
            fg = "#ffffff",
            bg = "#000000aa",
            replaces_id = current_notification_id -- Update notification in place
          })

          -- Store the notification ID
          current_notification_id = notification.id
        end)
    end)
end

-- Function to increase volume (limits to 100%)
local function increase_volume()
  awful.spawn.easy_async_with_shell("pactl get-sink-volume @DEFAULT_SINK@ | awk 'NR==1 {print $5}' | tr -d '%'",
    function(stdout)
      local volume = tonumber(stdout) or 0
      if volume < 100 then
        awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%")
      else
        awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ 100%")
      end
      show_volume(" ")
    end)
end

-- Function to decrease volume
local function decrease_volume()
  awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%", false)
  show_volume("")
end

-- Function to toggle mute
local function toggle_mute()
  awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle", false)
  show_volume(" ")
end

return {
  -- Volume Up
  up = awful.key({}, "XF86AudioRaiseVolume", function()
    increase_volume()
  end, { description = "Increase volume (max 100%)", group = "custom" }),

  -- Volume Down
  down = awful.key({}, "XF86AudioLowerVolume", function()
    decrease_volume()
  end, { description = "Decrease volume", group = "custom" }),

  -- Mute Toggle
  mute = awful.key({}, "XF86AudioMute", function()
    toggle_mute()
  end, { description = "Mute/unmute volume", group = "custom" })
}
