local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "tokyonight_night"
config.font = wezterm.font_with_fallback({ "JetBrains Mono", "Fira Code", "Maple Mono NF" })
config.bold_brightens_ansi_colors = true

config.window_background_opacity = 0.9
config.macos_window_background_blur = 20
config.window_decorations = "RESIZE"
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.font_size = 14.0

config.keys = {
  {
    key = "F11",
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = "l",
    mods = "CTRL|SHIFT",
    action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
  },
  {
    key = "F",
    mods = "SHIFT|CTRL",
    action = wezterm.action.Search({ CaseInSensitiveString = "" }),
  },
}


-- config.cell_width = 0.9
-- config.line_height = 1.2

return config
