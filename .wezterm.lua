-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = wezterm.config_builder()
local act = wezterm.action 

-- Appearance

local scheme = wezterm.get_builtin_color_schemes()['OneHalfDark']
scheme.scrollbar_thumb = "lightblue"

config.color_schemes = {
  ['OneHalfDarkCustom'] = scheme,
}

config.color_scheme = 'OneHalfDarkCustom'
config.font = wezterm.font 'Cascadia Mono'
config.font_size = 10.0
config.enable_scroll_bar = true
config.min_scroll_bar_height = "1cell"
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
    label = 'Nushell',
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

-- Tab Title
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
    if tab.is_active then
      return {
        { Text = title },
      }
    end
    return title
  end
)

-- Return the configuration to wezterm
return config
