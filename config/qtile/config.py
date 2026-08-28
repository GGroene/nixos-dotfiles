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
import os
from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, hook, Screen
from libqtile.lazy import lazy
# from qtile_extras import widget
import colors
import time

mod = "mod4"  # aka Windows key
mod1 = "mod1"  # alt key
# terminal = "alacritty -e tmux"
terminal = "alacritty"
# filemanager = "thunar"
filemanager = "pcmanfm"
color = colors.Dracula

sticky_windows = []


@lazy.function
def toggle_sticky_windows(qtile, window=None):
    if window is None:
        window = qtile.current_screen.group.current_window
    if window in sticky_windows:
        sticky_windows.remove(window)
    else:
        sticky_windows.append(window)
    return window


@hook.subscribe.setgroup
def move_sticky_windows():
    for window in sticky_windows:
        window.togroup()
    return


@hook.subscribe.client_killed
def remove_sticky_windows(window):
    if window in sticky_windows:
        sticky_windows.remove(window)

# Below is an example how to make zen pic-in-pic windows automatically sticky.


@hook.subscribe.client_managed
def auto_sticky_windows(window):
    info = window.info()
    if (info['wm_class'] == ['Toolkit', 'zen']
            and info['name'] == 'Picture-in-Picture'):
        sticky_windows.append(window)


keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),
    Key([mod], "period", lazy.next_screen(),
        desc="Move focus to next monitor"),
    Key([mod], "comma", lazy.prev_screen(),
        desc="Move focus to previous monitor"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows in Column Mode. If current window is on the edge of screen
    # and direction will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        lazy.layout.shrink().when(layout="monadtall"),
        desc="Columns: Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        lazy.layout.grow().when(layout="monadtall"),
        desc="Columns: Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        lazy.layout.grow().when(layout="monadwide"),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(),
        lazy.layout.shrink().when(layout="monadwide"),
        desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "f", lazy.window.toggle_fullscreen(),
        desc="Toggle focused window to fullscreen"),
    Key([mod], "t", lazy.window.toggle_floating(),
        desc="Toggle focused window to floating"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "control"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift", "control"], "l", lazy.spawn(
        "i3lock"), desc="Lock screen"),
    Key([mod, "shift"], "b", lazy.hide_show_bar(), desc="Toggles the bar"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.spawn(
        "rofi -show power -modi power:rofi-power-menu"),
        desc="Shutdown Qtile"),
    Key([mod, "shift"], "Return", lazy.spawn("rofi -show drun"),
        desc="Spawn a command using a prompt widget"),

    # CUSTOM
    Key([], "XF86AudioRaiseVolume", lazy.spawn(
        "pactl set-sink-volume 0 +1%"), desc='Volume Up'),
    Key([], "XF86AudioLowerVolume", lazy.spawn(
        "pactl set-sink-volume 0 -1%"), desc='volume down'),
    Key([], "XF86AudioMute", lazy.spawn(
        "pactl set-sink-mute @DEFAULT_SINK@ toggle"), desc='Volume Mute'),
    Key([], "XF86AudioPlay", lazy.spawn(
        "playerctl play-pause"), desc='playerctl'),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"),
        desc='playerctl'),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc='playerctl'),
    Key([], "XF86MonBrightnessUp", lazy.spawn(
        "brightnessctl s 5%+"), desc='brightness UP'),
    Key([], "XF86MonBrightnessDown", lazy.spawn(
        "brightnessctl s 5%-"), desc='brightness Down'),

    # Misc keybinds
    Key([], "Print", lazy.spawn(
        "printclip"), desc='Copy screenshot'),
    Key([mod], "Print", lazy.spawn(
        f"maim -s /home/gg/Pictures/Screenshots/screenshot_{time.time()}.png"), desc='Save screenshot'),
    Key([mod], "s", toggle_sticky_windows(),
        desc="Toggle state of sticky for current window"),
    Key([mod, "control"], "f", lazy.spawn("pcmanfm"), desc=""),
    Key([mod, "shift"], "f", lazy.spawn("firefox -fullscreen"), desc=""),
    Key([mod], "d", lazy.spawn("scrcpy -m 1024"), desc=""),
    Key([mod], "b", lazy.spawn("firefox"), desc=""),
    Key([mod, "shift"], "d", lazy.spawn("discord"), desc=""),
]

# Add help key
launcher = "rofi -show run -matching fuzzy"
keys_str = ""
for key in keys:
    keypress = key.modifiers + [key.key]
    keypress_str = "-".join(keypress)
    keys_str += keypress_str + ": " + key.desc + "\n"

help_desc = "Show qtile keys in rofi"
help_key = "slash"
keys_str += f"{mod}-{help_key}: {help_desc}"


def get_launcher_command(s, prompt, launcher):
    return {
        "shell": True,
        "cmd": f"echo -en '{s}' | {launcher} -dmenu -p '{prompt}'",
    }


keys.extend(
    [
        Key(
            [mod],
            help_key,
            lazy.spawn(**get_launcher_command(keys_str,
                       "Qtile keys", launcher)),
            desc=help_desc,
        ),
    ]
)
#   Be careful modifying this, otherwise qtile config will break
# groups = [Group(f"{i+1}", label="") for i in range(9)]
groups = [Group(f"{i+1}", label=i+1) for i in range(9)]
# groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc="Switch to & move focused window to group {}".format(
                    i.name),
            ),
        ]
    )

layout_theme = {
    "border_focus": color[6],
    "border_normal": color[9],
    "border_width": 2,
    "margin": 4,
}

layouts = [
    layout.Columns(
        **layout_theme,
        border_on_single=True,
        fair=True,
    ),
    layout.Max(
        **{k: v for k, v in layout_theme.items()
            if k not in {"border_width", "margin"}},
        border_width=0,
        margin=0,
    ),
    layout.MonadTall(
        **{k: v for k, v in layout_theme.items()
            if k not in {"border_width", "margin"}},
        border_width=1,
        margin=0,
        ratio=0.5,
    ),
    layout.MonadWide(
        **{k: v for k, v in layout_theme.items()
            if k not in {"border_width", "margin"}},
        border_width=1,
        margin=0,
        ratio=0.5,
    ),
    layout.Floating(
        **layout_theme,
    ),
    # # Try more layouts by unleashing below layouts
    # layout.TreeTab(
    #     ,**{k: v for k, v in layout_theme.items()
    #          if k not in {"border_width","margin"}},
    #     border_width = 0,
    #     margin = 0,
    # ),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(
    #     **layout_theme,
    #     margin = 4,
    #     border_width = 2,
    # ),
    # layout.Tile(
    #     **layout_theme,
    #     margin = 4,
    #     border_width = 2,
    # ),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = {
    # "font": "IBM Plex Mono Medium",
    "font": "JetBrainsMono Nerd Font Bold",
    "fontsize": 14,
    "padding": 2,

    "background": color[9],
    # "background": "#000000",
    "foreground": color[1],
}

deco = {
    "decorations": [
        # RectDecoration(
        #   colour=color[1], radius=6, filled=True, group=True, clip=True),
        # RectDecoration(
        #   colour=color[0], radius=0, filled=False, group=True, clip=True,
        #   line_colour=color[6], line_width=1)
        # BorderDecoration(
        #   colour=color[6], group=True, margin_y=2, padding_y=0,
        #   border_width=[0,0,2,0])
        # BorderDecoration(
        #   colour=color[6], border_width=[0,0,1,0])
    ],
    # "decorations": [
    #     RectDecoration(
    #       colour=color[2], radius=8, filled=True, group=True, clip=True)
    # ],
}

spacer_length = {"length": 8, }

sep_defaults = {
    "foreground": color[6],
    "linewidth": 1,
    "padding": 16,
    "size_percent": 50,
}

extension_defaults = [widget_defaults.copy()]


def open_launcher():
    qtile.cmd_spawn("rofi -show drun")
#   qtile.cmd_spawn("menu")


def open_power():
    qtile.cmd_spawn("rofi -show power -modi power:rofi-power-menu")


def open_btop():
    qtile.cmd_spawn("alacritty --hold -e btop")


def open_pavu():
    qtile.cmd_spawn("pavucontrol-qt")


def init_widgets_list():
    widgets_list = [
        widget.GroupBox(
            **deco,
            borderwidth=2,
            highlight_method='border',
            active=color[5],  # Active workspaces number color
            block_highlight_text_color=None,  # Current workspace number color
            inactive=color[7],  # Empty workspace number
            this_current_screen_border=color[4],  # Number background color
            this_screen_border=color[8],
            other_current_screen_border=color[4],
            other_screen_border=color[8],
            urgent_border=color[3],
            rounded=True,
            disable_drag=True,
            markup=True,
            fmt='<span weight="ultrabold">{}</span>',
        ),

        widget.Sep(
            **sep_defaults,
        ),
        #
        # widget.Spacer(
        #     **spacer_length,
        #     ),

        # widget.CurrentLayoutIcon(
        #     **deco,
        #     scale=0.5,
        # ),

        widget.CurrentLayout(
            **deco,
        ),

        widget.Sep(
            **sep_defaults,
        ),
        #
        # widget.Spacer(
        #     **spacer_length,
        #     ),

        widget.WindowName(
            **deco,
            format="{name}",
            empty_group_string='Desktop',
        ),

        widget.Sep(
            **sep_defaults,
        ),
        #
        # widget.Spacer(
        #     **spacer_length,
        #     ),

        widget.CPU(
            **deco,
            format='CPU:({load_percent:.1f}%/{freq_current}GHz)',
            margin=0,
            mouse_callbacks={'Button1': open_btop},
        ),

        widget.Sep(
            **sep_defaults,
        ),
        #
        # widget.Spacer(
        #     **spacer_length,
        #     ),

        widget.Memory(
            **deco,
            format='RAM:({MemUsed:.1f}GB/{MemTotal:.0f}GB)',
            measure_mem='G',
            mouse_callbacks={'Button1': open_btop},
        ),

        widget.Sep(
            **sep_defaults,
        ),

        # widget.Spacer(
        #     **spacer_length,
        #     ),

        widget.Systray(
            **deco,
            icon_size=18,
            padding=1,
        ),

        # widget.Sep(
        #     **sep_defaults,
        #     ),
        #
        # widget.Spacer(
        #     **spacer_length,
        #     ),

        # widget.Image(
        #     **deco,
        #     filename = '~/.config/qtile/Assets/Bar-Icons/brightness.svg',
        #     margin_y = 3,
        #     scale = True,
        #     ),
        #
        # widget.Backlight(
        #     **deco,
        #     backlight_name='intel_backlight'
        #     ),

        widget.Sep(
            **sep_defaults,
        ),
        #
        # widget.Spacer(
        #     **spacer_length,
        #     ),

        # widget.Image(
        #     **deco,
        #     filename='~/.config/qtile/Assets/Bar-Icons/volume.svg',
        #     margin_y=3,
        #     scale=True,
        #     mouse_callbacks={'Button1': open_pavu},
        # ),

        # widget.Volume(
        #     **deco,
        # ),
        #
        # widget.Sep(
        #     **sep_defaults,
        # ),
        #
        # widget.Spacer(
        #     **spacer_length,
        #     ),

        # widget.Image(
        #     **deco,
        #     filename='~/.config/qtile/Assets/Bar-Icons/calendar.svg',
        #     margin_y=4,
        #     margin_x=3,
        #     scale=True,
        # ),

        widget.Clock(
            **deco,
            format='%a %d/%m/%y',  # Here you can change timezone
            padding=0,
        ),

        widget.Sep(
            **sep_defaults,
        ),
        #
        # widget.Spacer(
        #     **spacer_length,
        #     ),

        # widget.Image(
        #     **deco,
        #     filename='~/.config/qtile/Assets/Bar-Icons/clock.svg',
        #     margin_y=4,
        #     margin_x=3,
        #     scale=True,
        # ),

        widget.Clock(
            **deco,
            format='%H:%M ',
            padding=0,
        ),

        # widget.Spacer(
        #     **spacer_length,
        #     ),
        #
        # widget.Image(
        #     **deco,
        #     filename = '~/.config/qtile/Assets/Bar-Icons/power.svg',
        #     margin_y = 3,
        #     margin_x = 0,
        #     scale = True,
        #     mouse_callbacks = {'Button1': open_power},
        #     ),
    ]
    return widgets_list


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1


def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    del widgets_screen2[10:12]
    return widgets_screen2


def init_widgets_screen3():
    widgets_screen3 = init_widgets_list()
    del widgets_screen3[6:12]
    del widgets_screen3[10:17]
    return widgets_screen3


def init_screens():
    return [
        Screen(
            top=bar.Bar(
                widgets=init_widgets_screen1(),
                size=24,
                # margin = [2,2,0,2], # [N E S W]
                margin=[0, 0, 0, 0],  # [N E S W]
                # background = "#00000000"
            ),
        ),
        Screen(
            top=bar.Bar(
                widgets=init_widgets_screen2(),
                size=24,
                # margin = [2,2,0,2], # [N E S W]
                margin=[0, 0, 0, 0],  # [N E S W]
                # background = "#00000000"
            ),
        ),
        # Screen(
        #     top = bar.Bar(
        #         widgets=init_widgets_screen3(),
        #         size=24,
        #         margin = [0,0,0,0], # [N E S W]
        #     )
        # ),
    ]


if __name__ in ["config", "__main__"]:
    screens = init_screens()
    widget_list = init_widgets_list()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
# This basically puts your mouse in the center on the screen after you
# switch to another workspace
cursor_warp = False
floating_layout = layout.Floating(
    border_focus=color[6],
    border_normal=color[2],
    border_width=2,
    float_rules=[
        # Run the utility of `xprop` to see the
        # wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="steam"),  # steam
        Match(wm_class="blueman-manager"),  # blueman-manager
        Match(wm_class="sxiv"),  # sxiv
        Match(wm_class=".blueman-manager-wrapped"),  # blueman-manager
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)

# some other imports
# stuff


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/nixos-dotfiles/qtile/scripts/autostart.sh')
    subprocess.run(home)


auto_fullscreen = True
focus_on_window_activation = "smart"  # or focus
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
