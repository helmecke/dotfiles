-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font = wezterm.font('MesloLGM Nerd Font Mono')
config.font_size = 10
config.color_scheme = 'OneDark (base16)'
--config.window_decorations = 'None'
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.use_dead_keys = false

config.window_frame = {
    font = wezterm.font('MesloLGM Nerd Font Mono'),
    font_size = 10,

    active_titlebar_bg = '#16181c',
    inactive_titlebar_bg = '#16181c',
}

config.colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = '#16181c',

    -- The active tab is the one that has focus in the window
    active_tab = {
      bg_color = '#282c34',
      fg_color = '#abb2bf',
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = '#1e2127',
      fg_color = '#7f848e',
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = '#1e2127',
      fg_color = '#61afef',

    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = '#16181c',
      fg_color = '#abb2bf',

    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = '#16181c',
      fg_color = '#61afef',

    },
  },
}
-- IMPORTANT: Sets WSL2 as the defualt when opening Wezterm
config.default_domain = 'WSL:Arch'

-- Finally, return the configuration to wezterm:
return config