local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = "tokyonight_night"
config.font = wezterm.font_with_fallback({ "JetBrains Mono", "Fira Code", })
config.window_background_opacity = 1.0
config.window_decorations = "NONE"
config.enable_tab_bar = false
config.font_size = 12.0
config.max_fps = 60

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
