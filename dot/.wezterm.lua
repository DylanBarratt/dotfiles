local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_prog = { "tmux" }

local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"
if is_windows then
	config.default_domain = "WSL:Ubuntu"
end
config.default_cwd = wezterm.home_dir

config.font = wezterm.font("IosevkaTermNerdFont", { weight = "Medium", italic = false })
config.font_size = 14
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.hide_tab_bar_if_only_one_tab = true

config.keys = {
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

config.color_scheme = "Catppuccin Latte"

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- and finally, return the configuration to wezterm
return config