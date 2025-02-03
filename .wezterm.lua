-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = wezterm.config_builder()
local act = wezterm.action 

-- Appearance

config.color_scheme = 'OneHalfDark'
config.font = wezterm.font 'Cascadia Mono'
config.font_size = 10.0
config.enable_scroll_bar = true
config.show_close_tab_button_in_tabs = false

config.window_padding = {
  left = 5,
  right = 10,
  top = 5,
  bottom = 5
}

-- Execution
config.default_prog = { 'nu.exe' }

-- Functions
config.scrollback_lines = 16000

-- Launch Menu
config.launch_menu = {
  {
    label = 'NuShell',
    args = { 'nu.exe' }
  },
  {
    label = 'Ubuntu 22.04',
    args = { 'ubuntu2204.exe' }
  },
  {
    label = 'PowerShell',
    args = { 'powershell.exe', '-NoLogo' }
  },
  {
    label = 'CMD',
    args = { 'cmd.exe' }
  }
}

-- Keymap
config.keys = {
  -- Show launcher on Alt+L
  { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
  -- Rename tab with Ctrl+Shift+E
  {
    key = 'E',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}

-- Return the configuration to wezterm
return config
