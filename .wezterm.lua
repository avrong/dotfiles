local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Appearance
config.color_scheme = 'OneHalfDark'

config.window_padding = {
  left = 5,
  right = 5,
  top = 0,
  bottom = 0,
}

config.window_frame = {
  font = wezterm.font { family ='Roboto' },
  font_size = 13
}

-- config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
-- config.integrated_title_button_style = 'MacOsNative'

-- Font
config.font = wezterm.font 'Fira Code'
config.font_size = 13

-- UI
config.hide_tab_bar_if_only_one_tab = true

-- Default window size
config.initial_rows = 30
config.initial_cols = 100

-- Disable updates
config.check_for_updates = false

return config
