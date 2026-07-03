local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.disable_default_key_bindings = true

local act = wezterm.action

config.keys = {
	{ key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
	{ key = "n", mods = "CMD", action = act.SpawnWindow },
	{ key = "q", mods = "CMD", action = act.QuitApplication },
	{ key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "+", mods = "CMD", action = act.IncreaseFontSize },
	{ key = "-", mods = "CMD", action = act.DecreaseFontSize },
}
config.window_padding = {
	left = 0,
	right = 0,
	top = 2,
	bottom = 0,
}
config.color_scheme = "Catppuccin Mocha"

--config.colors = {
--	foreground = "#CBE0F0",
--	background = "#011423",
--	cursor_bg = "#47FF9C",
--	cursor_border = "#47FF9C",
--	cursor_fg = "#011423",
--	selection_bg = "#033259",
--	selection_fg = "#CBE0F0",
--	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
--	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
--}

config.font = wezterm.font("Hack Nerd Font")
config.font_size = 19

config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.75
config.macos_window_background_blur = 10

return config