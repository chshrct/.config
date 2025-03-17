local wezterm = require("wezterm")
local act = wezterm.action
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- padding
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}


-- color scheme
config.color_scheme_dirs = { "F:/projects/.dotfiles/wezterm/colors" }
config.color_scheme = "kanagawa-dragon"

-- term
config.front_end = "OpenGL"
config.max_fps = 144
config.animation_fps = 1
config.term = "xterm-256color"

-- shell
config.default_prog = { "pwsh", "-NoLogo" }

-- font
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 10

-- cursor
config.force_reverse_video_cursor = true
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500

-- window
config.window_decorations = "NONE | RESIZE"
config.window_background_opacity = 0.9

--tab bar
config.hide_tab_bar_if_only_one_tab = true

-- keymaps
config.keys = {
  {
    key = " ",
    mods = "CTRL",
    action = act.SendKey({
      key = " ",
      mods = "CTRL",
    }),
  },
  {
    key = "h",
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action.SplitPane({
      direction = "Right",
      size = { Percent = 50 },
    }),
  },
  {
    key = "v",
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action.SplitPane({
      direction = "Down",
      size = { Percent = 50 },
    }),
  },
  {
    key = "U",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Left", 5 }),
  },
  {
    key = "I",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Down", 5 }),
  },
  {
    key = "O",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Up", 5 }),
  },
  {
    key = "P",
    mods = "CTRL|SHIFT",
    action = act.AdjustPaneSize({ "Right", 5 }),
  },
  { key = "9", mods = "CTRL", action = act.PaneSelect },
  {
    key = "O",
    mods = "CTRL|ALT",
    -- toggling opacity
    action = wezterm.action_callback(function(window, _)
      local overrides = window:get_config_overrides() or {}
      if overrides.window_background_opacity == 1.0 then
        overrides.window_background_opacity = 0.9
      else
        overrides.window_background_opacity = 1.0
      end
      window:set_config_overrides(overrides)
    end),
  },
}

return config
