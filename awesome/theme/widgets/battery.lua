-------------------------------------------------
-- Battery Widget for Awesome Window Manager
-- Shows the battery status using the ACPI tool
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/battery-widget

-- @author Pavel Makhov
-- @copyright 2017 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local naughty = require("naughty")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local theme = require("theme.theme")

-- acpi sample outputs
-- Battery 0: Discharging, 75%, 01:51:38 remaining
-- Battery 0: Charging, 53%, 00:57:43 until charged

local battery_widget = {}
local function worker(user_args)
    local args = user_args or {}

    local margin_left = args.margin_left or 0
    local margin_right = args.margin_right or 0

    local position = args.notification_position or "top_right"
    local timeout = 5

    local level_widget = wibox.widget {
        font = theme.font,
        widget = wibox.widget.textbox
    }

    battery_widget = wibox.widget {
        level_widget,
        layout = wibox.layout.fixed.horizontal,
    }

    local notification
    local function show_battery_status()
        awful.spawn.easy_async([[bash -c 'acpi']],
            function(stdout, _, _, _)
                naughty.destroy(notification)
                notification = naughty.notify {
                    text = stdout,
                    title = "Battery status",
                    position = position,
                    timeout = 5, hover_timeout = 0.5,
                    width = 200,
                    screen = mouse.screen
                }
            end
        )
    end

    local batteryType
    watch("acpi -i", timeout,
        function(_, stdout)
            local battery_info = {}
            local capacities = {}
            for s in stdout:gmatch("[^\r\n]+") do
                -- Match a line with status and charge level
                local status, charge_str, _ = string.match(s, '.+: ([%a%s]+), (%d?%d?%d)%%,?(.*)')
                if status ~= nil then
                    -- Enforce that for each entry in battery_info there is an
                    -- entry in capacities of zero. If a battery has status
                    -- "Unknown" then there is no capacity reported and we treat it
                    -- as zero capactiy for later calculations.
                    table.insert(battery_info, { status = status, charge = tonumber(charge_str) })
                    table.insert(capacities, 0)
                end

                -- Match a line where capacity is reported
                local cap_str = string.match(s, '.+:.+last full capacity (%d+)')
                if cap_str ~= nil then
                    capacities[#capacities] = tonumber(cap_str) or 0
                end
            end

            local capacity = 0
            local charge = 0
            local status
            for i, batt in ipairs(battery_info) do
                if capacities[i] ~= nil then
                    if batt.charge >= charge then
                        status = batt.status -- use most charged battery status
                        -- this is arbitrary, and maybe another metric should be used
                    end

                    -- Adds up total (capacity-weighted) charge and total capacity.
                    -- It effectively ignores batteries with status "Unknown" as we
                    -- treat them with capacity zero.
                    charge = charge + batt.charge * capacities[i]
                    capacity = capacity + capacities[i]
                end
            end
            charge = charge / capacity

            if (status == 'Charging') then
                batteryType = "󰂄"
            elseif (charge >= 95) then
                batteryType = "󰁹"
            elseif (charge >= 90) then
                batteryType = "󰂂"
            elseif (charge >= 80) then
                batteryType = "󰂁"
            elseif (charge >= 70) then
                batteryType = "󰂀"
            elseif (charge >= 60) then
                batteryType = "󰁿"
            elseif (charge >= 50) then
                batteryType = "󰁾"
            elseif (charge >= 40) then
                batteryType = "󰁽"
            elseif (charge >= 30) then
                batteryType = "󰁼"
            elseif (charge >= 20) then
                batteryType = "󰁻"
            elseif (charge >= 10) then
                batteryType = "󰁺"
            else
                batteryType = "󰂃"
            end

            level_widget.text = string.format('%d%%  %s', charge, batteryType)
        end
    )

    battery_widget:connect_signal("button::press", function(_, _, _, button)
        if (button == 3) then show_battery_status() end
    end)
    battery_widget:connect_signal("mouse::leave", function() naughty.destroy(notification) end)

    return wibox.container.margin(battery_widget, margin_left, margin_right)
end

return setmetatable(battery_widget, { __call = function(_, ...) return worker(...) end })
