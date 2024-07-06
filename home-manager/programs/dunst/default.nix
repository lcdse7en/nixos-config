{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      dunst
    ];
  };

  home.file.".config/dunst/dunstrc".text = ''
    # See dunst(5) for all configuration options

    [global]
        monitor = 0
        follow = none

        width = 300
        height = 300
        origin = top-right
        offset = 20x20
        scale = 0
        notification_limit = 20
        progress_bar = true
        progress_bar_height = 10
        progress_bar_frame_width = 0
        progress_bar_min_width = 125
        progress_bar_max_width = 250
        progress_bar_corner_radius = 4
        icon_corner_radius = 5
        indicate_hidden = yes
        transparency = 10
        separator_height = 2
        padding = 8
        horizontal_padding = 8
        text_icon_padding = 10
        frame_width = 3
        #frame_color = "#eba0ac"
        gap_size = 5
        separator_color = auto
        sort = yes
        font = mononoki Nerd Font 8
        line_height = 3
        markup = full
        format = "󰟪 %a\n<b>󰋑 %s</b>\n%b"
        alignment = left
        vertical_alignment = center
        show_age_threshold = 60
        ellipsize = middle
        ignore_newline = no
        stack_duplicates = true
        hide_duplicate_count = false
        show_indicators = yes
        icon_theme = "Tela-circle-dracula"
        icon_position = left
        min_icon_size = 32
        max_icon_size = 128
        icon_path = /usr/share/icons/Tela-circle-dracula/16/actions:/usr/share/icons/Tela-circle-dracula/16/apps:/usr/share/icons/Tela-circle-dracula/16/devices:/usr/share/icons/Tela-circle-dracula/16/mimetypes:/usr/share/icons/Tela-circle-dracula/16/panel:/usr/share/icons/Tela-circle-dracula/16/places:/usr/share/icons/Tela-circle-dracula/16/status
        sticky_history = yes
        history_length = 20
        dmenu = /usr/bin/rofi -dmenu -p dunst:
        browser = /usr/bin/xdg-open
        always_run_script = true
        title = Dunst
        class = Dunst
        corner_radius = 10
        ignore_dbusclose = false

        ### Wayland ###
        # These settings are Wayland-specific. They have no effect when using X11

        # Uncomment this if you want to let notications appear under fullscreen
        # applications (default: overlay)
        # layer = top

        # Set this to true to use X11 output on Wayland.
        force_xwayland = false

        ### Legacy

        # Use the Xinerama extension instead of RandR for multi-monitor support.
        # This setting is provided for compatibility with older nVidia drivers that
        # do not support RandR and using it on systems that support RandR is highly
        # discouraged.
        #
        # By enabling this setting dunst will not be able to detect when a monitor
        # is connected or disconnected which might break follow mode if the screen
        # layout changes.
        force_xinerama = false

        ### mouse

        # Defines list of actions for each mouse event
        # Possible values are:
        # * none: Don't do anything.
        # * do_action: Invoke the action determined by the action_name rule. If there is no
        #              such action, open the context menu.
        # * open_url: If the notification has exactly one url, open it. If there are multiple
        #             ones, open the context menu.
        # * close_current: Close current notification.
        # * close_all: Close all notifications.
        # * context: Open context menu for the notification.
        # * context_all: Open context menu for all notifications.
        # These values can be strung together for each mouse event, and
        # will be executed in sequence.
        mouse_left_click = context, close_current
        mouse_middle_click = do_action, close_current
        mouse_right_click = close_all

    # Experimental features that may or may not work correctly. Do not expect them
    # to have a consistent behaviour across releases.
    [experimental]
        # Calculate the dpi to use on a per-monitor basis.
        # If this setting is enabled the Xft.dpi value will be ignored and instead
        # dunst will attempt to calculate an appropriate dpi value for each monitor
        # using the resolution and physical size. This might be useful in setups
        # where there are multiple screens with very different dpi values.
        per_monitor_dpi = false

    # Every section that isn't one of the above is interpreted as a rules to
    # override settings for certain messages.
    #
    # Messages can be matched by
    #    appname (discouraged, see desktop_entry)
    #    body
    #    category
    #    desktop_entry
    #    icon
    #    match_transient
    #    msg_urgency
    #    stack_tag
    #    summary
    #
    # and you can override the
    #    background
    #    foreground
    #    format
    #    frame_color
    #    fullscreen
    #    new_icon
    #    set_stack_tag
    #    set_transient
    #    set_category
    #    timeout
    #    urgency
    #    icon_position
    #    skip_display
    #    history_ignore
    #    action_name
    #    word_wrap
    #    ellipsize
    #    alignment
    #    hide_text
    #
    # Shell-like globbing will get expanded.
    #
    # Instead of the appname filter, it's recommended to use the desktop_entry filter.
    # GLib based applications export their desktop-entry name. In comparison to the appname,
    # the desktop-entry won't get localized.
    #
    # SCRIPTING
    # You can specify a script that gets run when the rule matches by
    # setting the "script" option.
    # The script will be called as follows:
    #   script appname summary body icon urgency
    # where urgency can be "LOW", "NORMAL" or "CRITICAL".
    #
    # NOTE: It might be helpful to run dunst -print in a terminal in order
    # to find fitting options for rules.

    # Disable the transient hint so that idle_threshold cannot be bypassed from the
    # client
    #[transient_disable]
    #    match_transient = yes
    #    set_transient = no
    #
    # Make the handling of transient notifications more strict by making them not
    # be placed in history.
    #[transient_history_ignore]
    #    match_transient = yes
    #    history_ignore = yes

    # fullscreen values
    # show: show the notifications, regardless if there is a fullscreen window opened
    # delay: displays the new notification, if there is no fullscreen window active
    #        If the notification is already drawn, it won't get undrawn.
    # pushback: same as delay, but when switching into fullscreen, the notification will get
    #           withdrawn from screen again and will get delayed like a new notification
    #[fullscreen_delay_everything]
    #    fullscreen = delay
    #[fullscreen_show_critical]
    #    msg_urgency = critical
    #    fullscreen = show

    #[espeak]
    #    summary = "*"
    #    script = dunst_espeak.sh

    #[script-test]
    #    summary = "*script*"
    #    script = dunst_test.sh

    #[ignore]
    #    # This notification will not be displayed
    #    summary = "foobar"
    #    skip_display = true

    #[history-ignore]
    #    # This notification will not be saved in history
    #    summary = "foobar"
    #    history_ignore = yes

    #[skip-display]
    #    # This notification will not be displayed, but will be included in the history
    #    summary = "foobar"
    #    skip_display = yes

    #[signed_on]
    #    appname = Pidgin
    #    summary = "*signed on*"
    #    urgency = low
    #
    #[signed_off]
    #    appname = Pidgin
    #    summary = *signed off*
    #    urgency = low
    #
    #[says]
    #    appname = Pidgin
    #    summary = *says*
    #    urgency = critical
    #
    #[twitter]
    #    appname = Pidgin
    #    summary = *twitter.com*
    #    urgency = normal
    #
    #[stack-volumes]
    #    appname = "some_volume_notifiers"
    #    set_stack_tag = "volume"
    #
    # vim: ft=cfg

    [Type-1]
        summary = "t1"
        format = "<b>%a</b>"

    [Type-2]
        summary = "t2"
        format = "<span size="250%">%a</span>\n%b"

    [urgency_critical]
        background = "#f5e0dc"
        foreground = "#1e1e2e"
        frame_color = "#f38ba8"
        icon = "~/.config/dunst/icons/critical.svg"
        timeout = 0
        # Icon for notifications with critical urgency, uncomment to enable
        #default_icon = /path/to/icon

    [urgency_low]
        background = "#3A3C40"
        foreground = "#C9C6BC"
        frame_color = "#4D5967"
        icon = "~/.config/dunst/icons/hyprdots.svg"
        timeout = 10

    [urgency_normal]
        background = "#687374"
        foreground = "#C9C6BC"
        frame_color = "#545C3F"
        icon = "~/.config/dunst/icons/hyprdots.svg"
        timeout = 10
  '';
}
