local awful = require 'awful'
local gears = require 'gears'
local wibox = require 'wibox'
local lain = require 'lain'
local theme_assets = require 'beautiful.theme_assets'
local xresources = require 'beautiful.xresources'
local dpi = xresources.apply_dpi

local gfs = require 'gears.filesystem'
local themes_path = gfs.get_themes_dir()

local theme = {}
local modkey = 'Mod4'

local colors = {
  red = '#E06C75',
  dark_red = '#BE5046',
  green = '#98C379',
  yellow = '#E5C07B',
  dark_yellow = '#D19A66',
  blue = '#61AFEF',
  purple = '#C678DD',
  cyan = '#56B6C2',
  white = '#ABB2BF',
  dark_white = '#979EAB',
  black = '#282C34',
  comment_grey = '#5C6370',
  gutter_fg_grey = '#4B5263',
  cursor_grey = '#2C323C',
  special_grey = '#3B4048',
  vertsplit = '#21252B',
}

theme.font = 'MesloLGM Nerd Font 11'

theme.bg_normal = '#282c34'
theme.bg_focus = '#282c34'
theme.bg_urgent = '#be5046'
theme.bg_minimize = '#444444'
theme.bg_systray = theme.bg_normal

theme.fg_normal = '#979eab'
theme.fg_focus = '#abb2bf'
theme.fg_urgent = '#abb2bf'
theme.fg_minimize = '#abb2bf'

theme.useless_gap = dpi(0)
theme.border_width = dpi(2)
theme.border_normal = '#21252b'
theme.border_focus = '#5c6370'
theme.border_marked = '#be5046'

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.taglist_fg_focus = colors.blue
theme.taglist_fg_empty = colors.comment_grey
theme.taglist_fg_urgent = colors.red
theme.taglist_bg_urgent = colors.black
theme.taglist_fg_occupied = colors.dark_white
theme.taglist_fg_volatile = colors.purple

theme.notification_font = theme.font
theme.notification_bg = theme.bg_normal
theme.notification_fg = theme.fg_normal
theme.notification_border_width = theme.border_width
theme.notification_border_color = theme.border_focus
theme.notification_icon_size = dpi(64)
theme.notification_max_width = dpi(600)
theme.notification_max_height = dpi(300)

-- Generate taglist squares:
-- local taglist_square_size = dpi(4)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. 'default/submenu.png'
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. 'default/titlebar/close_normal.png'
theme.titlebar_close_button_focus = themes_path .. 'default/titlebar/close_focus.png'

theme.titlebar_minimize_button_normal = themes_path .. 'default/titlebar/minimize_normal.png'
theme.titlebar_minimize_button_focus = themes_path .. 'default/titlebar/minimize_focus.png'

theme.titlebar_ontop_button_normal_inactive = themes_path .. 'default/titlebar/ontop_normal_inactive.png'
theme.titlebar_ontop_button_focus_inactive = themes_path .. 'default/titlebar/ontop_focus_inactive.png'
theme.titlebar_ontop_button_normal_active = themes_path .. 'default/titlebar/ontop_normal_active.png'
theme.titlebar_ontop_button_focus_active = themes_path .. 'default/titlebar/ontop_focus_active.png'

theme.titlebar_sticky_button_normal_inactive = themes_path .. 'default/titlebar/sticky_normal_inactive.png'
theme.titlebar_sticky_button_focus_inactive = themes_path .. 'default/titlebar/sticky_focus_inactive.png'
theme.titlebar_sticky_button_normal_active = themes_path .. 'default/titlebar/sticky_normal_active.png'
theme.titlebar_sticky_button_focus_active = themes_path .. 'default/titlebar/sticky_focus_active.png'

theme.titlebar_floating_button_normal_inactive = themes_path .. 'default/titlebar/floating_normal_inactive.png'
theme.titlebar_floating_button_focus_inactive = themes_path .. 'default/titlebar/floating_focus_inactive.png'
theme.titlebar_floating_button_normal_active = themes_path .. 'default/titlebar/floating_normal_active.png'
theme.titlebar_floating_button_focus_active = themes_path .. 'default/titlebar/floating_focus_active.png'

theme.titlebar_maximized_button_normal_inactive = themes_path .. 'default/titlebar/maximized_normal_inactive.png'
theme.titlebar_maximized_button_focus_inactive = themes_path .. 'default/titlebar/maximized_focus_inactive.png'
theme.titlebar_maximized_button_normal_active = themes_path .. 'default/titlebar/maximized_normal_active.png'
theme.titlebar_maximized_button_focus_active = themes_path .. 'default/titlebar/maximized_focus_active.png'

theme.wallpaper = themes_path .. 'default/background.png'

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path .. 'default/layouts/fairhw.png'
theme.layout_fairv = themes_path .. 'default/layouts/fairvw.png'
theme.layout_floating = themes_path .. 'default/layouts/floatingw.png'
theme.layout_magnifier = themes_path .. 'default/layouts/magnifierw.png'
theme.layout_max = themes_path .. 'default/layouts/maxw.png'
theme.layout_fullscreen = themes_path .. 'default/layouts/fullscreenw.png'
theme.layout_tilebottom = themes_path .. 'default/layouts/tilebottomw.png'
theme.layout_tileleft = themes_path .. 'default/layouts/tileleftw.png'
theme.layout_tile = themes_path .. 'default/layouts/tilew.png'
theme.layout_tiletop = themes_path .. 'default/layouts/tiletopw.png'
theme.layout_spiral = themes_path .. 'default/layouts/spiralw.png'
theme.layout_dwindle = themes_path .. 'default/layouts/dwindlew.png'
theme.layout_cornernw = themes_path .. 'default/layouts/cornernww.png'
theme.layout_cornerne = themes_path .. 'default/layouts/cornernew.png'
theme.layout_cornersw = themes_path .. 'default/layouts/cornersww.png'
theme.layout_cornerse = themes_path .. 'default/layouts/cornersew.png'

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({}, 1, function(t)
    t:view_only()
  end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
  end),
  awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
  end)
)

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal('request::activate', 'tasklist', { raise = true })
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list { theme = { width = 250 } }
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)

local mytextclock = wibox.widget.textclock ' %H:%M  %d.%m.%Y'
mytextclock:set_font(theme.font)
local month_calendar = awful.widget.calendar_popup.month {}
function month_calendar.call_calendar(self, offset, position, screen)
  screen = awful.screen.focused()
  awful.widget.calendar_popup.call_calendar(self, offset, position, screen)
end
month_calendar:attach(mytextclock, 'tc')

local logout_menu_widget = require 'awesome-wm-widgets.logout-menu-widget.logout-menu'

function theme.at_screen_connect(s)
  -- Each screen has its own tag table.
  awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

  s.quake = lain.util.quake {
    app = awful.util.terminal,
    argname = '--name=%s',
    height = 0.4,
    border = 2,
  }

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))
  s.mylayoutbox = wibox.container.margin(s.mylayoutbox, 5, 5, 5, 5)

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
  }

  -- Create the wibox
  s.mywibox = awful.wibar { position = 'top', screen = s, height = 28 }

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    expand = 'none',
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mylayoutbox,
      s.mytaglist,
      s.mypromptbox,
    },
    {
      mytextclock,
      layout = wibox.layout.fixed.horizontal,
    },
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      wibox.widget.systray(),
      wibox.container.margin(
        logout_menu_widget {
          onlock = function()
            awful.spawn.with_shell 'i3lock -c 282c34'
          end,
        },
        3,
        3,
        3,
        3
      ),
    },
  }
end

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
