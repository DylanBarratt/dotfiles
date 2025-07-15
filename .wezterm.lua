local wezterm = require("wezterm")

local config = wezterm.config_builder()

local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"
if is_windows then
	config.default_domain = "WSL:Ubuntu"
	config.font = wezterm.font("IosevkaTerm Nerd Font", { weight = "Regular", italic = false })
else
	config.font = wezterm.font("IosevkaTerm Nerd Font", { weight = "Regular", italic = false })
end
config.default_cwd = wezterm.home_dir

config.font_size = 14
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.hide_mouse_cursor_when_typing = true

local keys = {
	{
		key = "t",
		mods = "CTRL",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "w",
		mods = "CTRL",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
}

for i = 1, 8 do
	-- CTRL+ALT + number to activate that tab
	table.insert(keys, {
		key = tostring(i),
		mods = "CTRL",
		action = wezterm.action.ActivateTab(i - 1),
	})
end

config.keys = keys

-- TAB BAR
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 64
config.tab_bar_at_bottom = true
config.colors = {
	tab_bar = {
		background = "#eff1f5",
		active_tab = {
			bg_color = "#eff1f5",
			fg_color = "#4c4f69",

			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#acb0be",
			fg_color = "#4c4f69",

			intensity = "Half",
		},
		new_tab = {
			bg_color = "#eff1f5",
			fg_color = "#eff1f5",
		},
	},
}

local process_icons = {
	["git"] = wezterm.nerdfonts.dev_git,
	["nvim"] = "",
	["vim"] = wezterm.nerdfonts.dev_vim,
	["yarn"] = "",
	["sam"] = "",
}
-- Return the Tab's current working directory
local function get_cwd(tab)
	return tab.active_pane.current_working_dir.file_path or ""
end

-- Remove all path components and return only the last value
local function remove_abs_path(path)
	return path:match("([^/]+/[^/]+)$")
end

-- Return the pretty path of the tab's current working directory
local function get_display_cwd(tab)
	local current_dir = get_cwd(tab)
	local HOME_DIR = string.format("file://%s", os.getenv("HOME"))
	return current_dir == HOME_DIR and "~/" or remove_abs_path(current_dir)
end

-- Pretty format the tab title
local function format_title(tab)
	local cwd = get_display_cwd(tab)

	local active_title = tab.active_pane.title

	local icon = process_icons[active_title]

	return (icon == nil) and string.format("%s", cwd) or string.format(" %s  %s ", icon, cwd)
end

-- Returns manually set title (from `tab:set_title()` or `wezterm cli set-tab-title`) or creates a new one
local function get_tab_title(tab)
	local title = tab.tab_title
	if title and #title > 0 then
		return title
	end
	return format_title(tab)
end

-- On format tab title events, override the default handling to return a custom title
-- Docs: https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
---@diagnostic disable-next-line: unused-local, redefined-local
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = get_tab_title(tab)

	if tab.is_active then
		return {
			{ Text = title },
		}
	end
	return title
end)

config.color_scheme = "Catppuccin Latte"

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
