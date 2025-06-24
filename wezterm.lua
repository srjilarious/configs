local wezterm = require 'wezterm';

return {
  -- Disable the default Ctrl+Tab and Ctrl+Shift+Tab bindings
  -- disable_default_key_bindings = true,

  font = wezterm.font "DejaVuSansMono Nerd Font Mono",

  -- Key bindings for cycling through tabs with Super+Tab and Shift+Super+Tab
  keys = {
    {
      key = "Tab",
      mods = "SUPER",
      action = wezterm.action{ActivateTabRelative=1},
    },
    {
      key = "Tab",
      mods = "SHIFT|SUPER",
      action = wezterm.action{ActivateTabRelative=-1},
    },
    -- Disable ctrl/ctrl+Shift Tab so nvim can use it.
    {
      key = "Tab",
      mods = "CTRL",
      action = wezterm.action.DisableDefaultAssignment
    },
    {
      key = "Tab",
      mods = "CTRL|SHIFT",
      action = wezterm.action.DisableDefaultAssignment
    },
    -- Toggle the visibility of the tab bar
    -- {
    --   key = "t", -- You can change 't' to any preferred key
    --   mods = "ALT|SUPER",
    --   action = "ToggleShowTabBar",
    -- },
  },

  -- hide_tab_bar_if_only_one_tab = true,
  enable_tab_bar = false,
  -- tab_bar_at_bottom = true,
  use_fancy_tab_bar = true,
  automatically_reload_config = true,
}
