# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import subprocess
import psutil
from typing import List  # noqa: F401

from libqtile import bar, layout, widget, hook, qtile
from libqtile.widget.battery import Battery, BatteryState
from libqtile.config import (
    Click,
    Drag,
    Group,
    Key,
    KeyChord,
    Match,
    Screen,
    DropDown,
    ScratchPad,
)
from libqtile.lazy import lazy


def get_group(group_name):
    for group in groups:
        if group.name == group_name:
            return group
    return None


def focus_master(qtile):
    cur = qtile.current_layout.clients.current_client
    master = qtile.current_layout.clients[0]
    last = qtile.current_layout.group.focus_history[-2]

    if cur == master:
        return qtile.current_layout.group.focus(last)

    return qtile.current_layout.group.focus(master)


def swap_master(qtile):
    cur = qtile.current_layout.clients.current_client
    master = qtile.current_layout.clients[0]

    qtile.current_layout.clients.swap(cur, master, 0)
    return qtile.current_layout.group.focus(qtile.current_layout.clients[0])


def toscreen(qtile, group_name):
    """Sticky screen focus group."""
    for i, group in enumerate(qtile.groups):
        if group_name == group.name:
            screen_affinity = get_group(group_name).screen_affinity
            if (
                qtile.current_screen == group.screen
                or qtile.current_screen.index == screen_affinity
            ):
                return qtile.current_screen.set_group(qtile.groups[i])
            elif group.screen is None and screen_affinity is None:
                return qtile.current_screen.set_group(qtile.groups[i])
            elif qtile.current_screen.index == screen_affinity:
                return qtile.current_screen.set_group(qtile.groups[i])
            elif (
                qtile.current_screen.index != screen_affinity
                and screen_affinity is not None
            ):
                qtile.cmd_to_screen(screen_affinity)
                return qtile.current_screen.set_group(qtile.groups[i])
            else:
                qtile.cmd_to_screen(group.screen.index)
                return qtile.current_screen.set_group(qtile.groups[i])
                # qtile.cmd_spawn("notify-send '%s'" % "test")

    # if group_name == qtile.current_screen.group.name:
    #     return qtile.current_screen.set_group(qtile.current_screen.previous_group)
    # for i, group in enumerate(qtile.groups):
    #     if group_name == group.name:
    #         return qtile.current_screen.set_group(qtile.groups[i])


mod = "mod4"
alt = "mod1"
shift = "shift"
ctrl = "control"

terminal = "kitty"
editor = terminal + " --title nvim zsh -c nvim"

colors = {
    "red": "#E06C75",
    "dark_red": "#BE5046",
    "green": "#98C379",
    "yellow": "#E5C07B",
    "dark_yellow": "#D19A66",
    "blue": "#61AFEF",
    "purple": "#C678DD",
    "cyan": "#56B6C2",
    "white": "#ABB2BF",
    "dark_white": "#979EAB",
    "black": "#282C34",
    "comment_grey": "#5C6370",
    "gutter_fg_grey": "#4B5263",
    "cursor_grey": "#2C323C",
    "special_grey": "#3B4048",
    "vertsplit": "#21252B",
}

keys = [
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod, shift], "h", lazy.layout.shrink_main()),
    Key([mod, shift], "l", lazy.layout.grow_main()),
    Key([mod, shift], "j", lazy.layout.shuffle_down()),
    Key([mod, shift], "k", lazy.layout.shuffle_up()),
    Key([mod], "h", lazy.layout.shrink()),
    Key([mod], "l", lazy.layout.grow()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod, shift], "n", lazy.layout.reset()),
    Key([mod], "m", lazy.layout.maximize()),
    Key([mod, ctrl], "Return", lazy.layout.flip()),
    Key([mod], "space", lazy.function(focus_master)),
    Key([mod, shift], "space", lazy.function(swap_master)),
    # Focus windows
    # Key([mod], "h", lazy.layout.left()),
    # Key([mod], "l", lazy.layout.right()),
    # Key([mod], "j", lazy.layout.down()),
    # Key([mod], "k", lazy.layout.up()),
    # # Move windows
    # Key([mod, shift], "h", lazy.layout.shuffle_left()),
    # Key([mod, shift], "l", lazy.layout.shuffle_right()),
    # Key([mod, shift], "j", lazy.layout.shuffle_down()),
    # Key([mod, shift], "k", lazy.layout.shuffle_up()),
    # # Resize windows
    # Key([mod, ctrl], "h", lazy.layout.grow_left()),
    # Key([mod, ctrl], "l", lazy.layout.grow_right()),
    # Key([mod, ctrl], "j", lazy.layout.grow_down()),
    # Key([mod, ctrl], "k", lazy.layout.grow_up()),
    # Key([mod, shift, ctrl], "h", lazy.layout.swap_column_left()),
    # Key([mod, shift, ctrl], "l", lazy.layout.swap_column_right()),
    # Key([mod], "n", lazy.layout.normalize()),
    # Key([mod], "m", lazy.layout.toggle_split()),
    # Key(
    #     [mod, ctrl],
    #     "Return",
    #     lazy.layout.toggle_split(),
    #     desc="Toggle between split and unsplit sides of stack",
    # ),
    Key([mod, ctrl], "space", lazy.window.toggle_floating()),
    Key([mod, ctrl], "n", lazy.window.toggle_minimize()),
    Key([mod, ctrl], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "u", lazy.next_urgent()),
    # Focus screens
    Key([mod], "o", lazy.next_screen()),
    Key([mod], "i", lazy.prev_screen()),
    Key([mod], "b", lazy.hide_show_bar()),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod, shift], "Return", lazy.spawn(editor), desc="Launch editor"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, shift], "Tab", lazy.prev_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, ctrl], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, ctrl], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key(
        [mod],
        "r",
        lazy.spawn("rofi -show combi"),
        desc="Spawn a command using a prompt widget",
    ),
    Key(
        [],
        "XF86AudioPlay",
        lazy.spawn("playerctl play-pause"),
        desc="playerctl play-pause",
    ),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop"), desc="playerctl stop"),
    Key(
        [],
        "XF86AudioPrev",
        lazy.spawn("playerctl previous"),
        desc="playerctl play-pause",
    ),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="playerctl play-pause"),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%"),
        desc="Lower volume",
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%"),
        desc="Raise volume",
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
        desc="Mute volume",
    ),
    Key(
        [],
        "XF86AudioMicMute",
        lazy.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
        desc="Mute microphone",
    ),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.function(toscreen, i.name),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, ctrl],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, shift],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, shift], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
            Key(
                [mod, shift, ctrl],
                i.name,
                lazy.group.switch_groups(i.name),
                desc="Move current group to {}".format(i.name),
            ),
        ]
    )

groups.extend(
    [
        Group(
            "chat",
            label=" ",
            persist=False,
            init=False,
            matches=[Match(wm_class=["slack"])],
            screen_affinity=1,
        ),
        Group(
            "www",
            label=" ",
            layout="max",
            persist=False,
            init=False,
            matches=[Match(wm_class=["qutebrowser", "firefox"])],
            screen_affinity=0,
        ),
        Group(
            "edit",
            label=" ",
            persist=False,
            init=False,
            matches=[Match(title=["nvr"]), Match(wm_class=["nvr"])],
            screen_affinity=0,
        ),
        Group(
            "file",
            label=" ",
            persist=False,
            init=False,
            matches=[Match(title=["vifm"]), Match(wm_class=["vifm"])],
        ),
    ]
)
groups.append(
    ScratchPad(
        "scratchpad",
        [
            DropDown(
                "term",
                terminal,
                x=0,
                width=0.998,
                height=0.45,
                warp_pointer=False,
                on_focus_lost_hide=True,
            ),
            DropDown("spotify", "spotify", height=0.8, warp_pointer=False),
        ],
    )
)

layout_defaults = dict(
    border_focus=colors["blue"],
    border_normal=colors["comment_grey"],
    border_focus_stack=colors["green"],
    border_normal_stack=colors["comment_grey"],
    border_on_single=True,
    border_width=2,
)

keys.extend(
    [
        # Key([mod], "s", lazy.group["chat"].toscreen()),
        Key([mod], "s", lazy.function(toscreen, "chat")),
        Key([mod, shift], "s", lazy.window.togroup("chat", switch_group=True)),
        # Key([mod], "w", lazy.group["www"].toscreen()),
        Key([mod], "w", lazy.function(toscreen, "www")),
        Key([mod, shift], "w", lazy.window.togroup("www", switch_group=True)),
        # Key([mod], "e", lazy.group["edit"].toscreen()),
        Key([mod], "e", lazy.function(toscreen, "edit")),
        Key([mod, shift], "e", lazy.window.togroup("edit", switch_group=True)),
        Key([mod], "f", lazy.function(toscreen, "file")),
        Key([mod, shift], "f", lazy.window.togroup("file", switch_group=True)),
        Key([mod], "grave", lazy.group["scratchpad"].dropdown_toggle("term")),
        KeyChord(
            [mod],
            "x",
            [
                Key([mod], "x", lazy.qtilecmd()),
                Key([mod], "s", lazy.group["scratchpad"].dropdown_toggle("spotify")),
            ],
        ),
    ]
)

layouts = [
    layout.MonadTall(
        border_focus=colors["blue"],
        border_normal=colors["comment_grey"],
        new_client_position="top",
        ratio=0.6,
    ),
    layout.MonadWide(
        border_focus=colors["blue"],
        border_normal=colors["comment_grey"],
        new_client_position="top",
    ),
    layout.Columns(
        **layout_defaults,
        num_columns=1,
        split=False,
        name="max",
    ),
]

widget_defaults = dict(
    font="MesloLGM Nerd Font",
    fontsize=14,
    padding=3,
    foreground=colors["white"],
)
extension_defaults = widget_defaults.copy()


class MyBattery(Battery):
    def build_string(self, status):
        if self.layout is not None:
            if (
                status.state == BatteryState.DISCHARGING
                and status.percent < self.low_percentage
            ):
                self.layout.colour = self.low_foreground
            else:
                self.layout.colour = self.foreground
        if status.state == BatteryState.DISCHARGING:
            if status.percent > 0.75:
                char = " "
            elif status.percent > 0.45:
                char = " "
            else:
                char = " "
        elif status.percent >= 1 or status.state == BatteryState.FULL:
            char = " "
        elif status.state == BatteryState.EMPTY or status.percent == 0:
            char = " "
        else:
            char = " "
        return self.format.format(char=char, percent=status.percent)

    def restore(self):
        self.format = "{char}"
        self.font = widget_defaults.font
        self.timer_setup()

    def button_press(self, x, y, button):
        self.format = "{percent:2.0%}"
        self.font = widget_defaults.font
        self.timer_setup()
        self.timeout_add(1, self.restore)


battery = MyBattery(
    format="{char}",
    low_foreground=colors["red"],
    show_short_text=False,
    low_percentage=0.12,
    foreground=colors["white"],
    notify_below=12,
)

screens = [
    Screen(
        top=bar.Bar(
            [
                # widget.CurrentLayout(),
                widget.CurrentLayoutIcon(scale=0.8),
                widget.GroupBox(
                    highlight_method="block",
                    rounded=False,
                    spacing=0,
                    this_current_screen_border=colors["blue"],
                    other_screen_border=colors["dark_yellow"],
                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": (colors["red"], colors["white"]),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Systray(),
                battery,
                widget.Spacer(length=2),
                widget.Clock(format=" %H:%M  %d.%m.%Y"),
            ],
            24,
            background=colors["black"],
            margin=2,
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                # widget.CurrentLayoutIcon(scale=0.8),
                widget.GroupBox(
                    highlight_method="block",
                    rounded=False,
                    spacing=0,
                    this_current_screen_border=colors["blue"],
                    other_screen_border=colors["dark_yellow"],
                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": (colors["red"], colors["white"]),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Clock(format=" %H:%M  %d.%m.%Y"),
            ],
            24,
            background=colors["black"],
            margin=2,
        )
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    **layout_defaults,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="arandr"),
        Match(wm_class="Cisco AnyConnect Secure Mobility Client"),
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


@hook.subscribe.startup_once
def autostart():
    processes = [["dunst"], ["sh -c './.fehbg'"], ["flameshot"]]

    for p in processes:
        subprocess.Popen(p)


@hook.subscribe.screen_change
def set_screens(event):
    subprocess.run(["autorandr", "--change"])
    qtile.restart()


@hook.subscribe.client_new
def _swallow(window):
    pid = window.window.get_net_wm_pid()
    ppid = psutil.Process(pid).ppid()
    cpids = {c.window.get_net_wm_pid(): wid for wid, c in window.qtile.windows_map.items()}
    for i in range(5):
        if not ppid:
            return
        if ppid in cpids:
            parent = window.qtile.windows_map.get(cpids[ppid])
            parent.minimized = True
            window.parent = parent
            return
        ppid = psutil.Process(ppid).ppid()


@hook.subscribe.client_killed
def _unswallow(window):
    if hasattr(window, 'parent'):
        window.parent.minimized = False
