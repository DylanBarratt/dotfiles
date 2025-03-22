local awful = require("awful")
local gears = require("gears")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

local programs = require("programs")
local volumeKeys = require("keymaps.volume")

local modkey = "Mod4"

local top_bar_height = screen.primary.mywibox and screen.primary.mywibox.height or 0

---@class Program
---@field class string
---@field name string
---
---@param program Program
local function openOrFocus(program)
	local clients = {}
	local matcher = function(c)
		return c.class == program.class
	end

	for c in awful.client.iterate(matcher) do
		table.insert(clients, c)
	end

	if #clients > 0 then
		local current = client.focus
		for i, c in ipairs(clients) do
			if c == current then
				local next_client = clients[i % #clients + 1] -- Cycle to next
				next_client:jump_to()
				return
			end
		end
		clients[1]:jump_to() -- If no match, go to the first one
	else
		awful.spawn(program.name)
	end
end

local globalkeys = gears.table.join(
	volumeKeys.up,
	volumeKeys.down,
	volumeKeys.mute,

	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),

	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),

	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),

	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),

	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Program keybindings
	-- rofi
	awful.key({ modkey }, "space", function()
		awful.spawn.with_shell("rofi -show drun")
	end, { description = "open a terminal", group = "launcher" }),
	-- terminal
	awful.key({ modkey }, "t", function()
		openOrFocus(programs.terminal)
	end, { description = "open a terminal", group = "launcher" }),
	-- browser
	awful.key({ modkey }, "b", function()
		openOrFocus(programs.browser)
	end, { description = "Open or focus " .. programs.browser.name, group = "launcher" }),
	-- notes
	awful.key({ modkey }, "n", function()
		openOrFocus(programs.notes)
	end, { description = "Open or focus " .. programs.notes.name, group = "launcher" }),

	-- Tools keybindings
	-- flameshot (screenshot)
	awful.key({ modkey, "Shift" }, "s", function()
		awful.spawn.with_shell("flameshot gui")
	end, { description = "screenshot", group = "tools" }),

	--restart
	awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),

	awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
	awful.key({ modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	-- awful.key({ modkey }, "x",
	--   function()
	--     awful.prompt.run {
	--       prompt       = "Run Lua code: ",
	--       textbox      = awful.screen.focused().mypromptbox.widget,
	--       exe_callback = awful.util.eval,
	--       history_path = awful.util.get_cache_dir() .. "/history_eval"
	--     }
	--   end,
	--   { description = "lua execute prompt", group = "awesome" }),

	-- Menubar
	-- awful.key({ modkey }, "p", function() menubar.show() end,
	--   { description = "show the menubar", group = "launcher" }),

	-- Brightness
	awful.key({}, "XF86MonBrightnessUp", function()
		awful.spawn("brightnessctl set +10%")
	end, { description = "increase brightness", group = "brightness" }),
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.spawn("brightnessctl set 10%-")
	end, { description = "decrease brightness", group = "brightness" })
)

local clientkeys = gears.table.join(
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey, "Shift" }, "c", function(c)
		c:kill()
	end, { description = "close", group = "client" }),

	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),

	-- window manipulation
	-- Move window to left half
	awful.key({ modkey, "Shift" }, "Left", function(c)
		c:geometry({
			x = 0,
			y = top_bar_height,
			width = screen.primary.geometry.width / 2,
			height = screen.primary.geometry.height - top_bar_height,
		})
	end, { description = "Move to left half", group = "layout" }),

	-- Move window to right half
	awful.key({ modkey, "Shift" }, "Right", function(c)
		c:geometry({
			x = screen.primary.geometry.width / 2,
			y = top_bar_height,
			width = screen.primary.geometry.width / 2,
			height = screen.primary.geometry.height - top_bar_height,
		})
	end, { description = "Move to right half", group = "layout" }),

	-- Move window to top half
	awful.key({ modkey, "Shift" }, "Up", function(c)
		c:geometry({ x = 0, y = 0, width = screen.primary.geometry.width, height = screen.primary.geometry.height / 2 })
	end, { description = "Move to top half", group = "layout" }),

	-- Move window to bottom half
	awful.key({ modkey, "Shift" }, "Down", function(c)
		c:geometry({
			x = 0,
			y = screen.primary.geometry.height / 2,
			width = screen.primary.geometry.width,
			height = screen.primary.geometry.height / 2,
		})
	end, { description = "Move to bottom half", group = "layout" }),

	-- Move window to top-left corner
	awful.key({ modkey, "Control" }, "Left", function(c)
		c:geometry({
			x = 0,
			y = 0,
			width = screen.primary.geometry.width / 2,
			height = screen.primary.geometry.height / 2,
		})
	end, { description = "Move to top-left corner", group = "layout" }),

	-- Move window to top-right corner
	awful.key({ modkey, "Control" }, "Right", function(c)
		c:geometry({
			x = screen.primary.geometry.width / 2,
			y = 0,
			width = screen.primary.geometry.width / 2,
			height = screen.primary.geometry.height / 2,
		})
	end, { description = "Move to top-right corner", group = "layout" }),

	-- Move window to bottom-left corner
	awful.key({ modkey, "Control" }, "Down", function(c)
		c:geometry({
			x = 0,
			y = screen.primary.geometry.height / 2,
			width = screen.primary.geometry.width / 2,
			height = screen.primary.geometry.height / 2,
		})
	end, { description = "Move to bottom-left corner", group = "layout" }),

	-- Move window to bottom-right corner
	awful.key({ modkey, "Control", "Shift" }, "Right", function(c)
		c:geometry({
			x = screen.primary.geometry.width / 2,
			y = screen.primary.geometry.height / 2,
			width = screen.primary.geometry.width / 2,
			height = screen.primary.geometry.height / 2,
		})
	end, { description = "Move to bottom-right corner", group = "layout" })
)

local clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

root.keys(globalkeys)

return {
	globalkeys = globalkeys,
	clientkeys = clientkeys,
	clientbuttons = clientbuttons,
}
