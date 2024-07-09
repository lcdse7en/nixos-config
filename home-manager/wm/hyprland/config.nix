{ pkgs, config, inputs, lib, ... }: {
  imports = [ ../../programs/waybar/hyprland_waybar.nix ];
  wayland.windowManager.hyprland = {
    extraConfig = ''

      #-----------------------#
      # wall(by swww service) #
      #-----------------------#
      exec-once =  systemctl --user start graphical-session.target
      exec-once = swww init
      exec = sleep 0.5 && default_wallpaper

      exec-once = dunst
      exec-once = nm-applet --indicator
      exec = pkill waybar & sleep 0.5 && waybar

      exec-once = ~/hypr/scripts/swwwallpaper.sh # start wallpaper daemon

      $mainMod = SUPER
      $browser = brave

      # $scripts=$HOME/.config/hypr/scripts

      monitor=,preferred,auto,1
      # monitor=HDMI-A-1, 1920x1080, 0x0, 1
      # monitor=eDP-1, 1920x1080, 1920x0, 1

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      input {
        kb_layout = us
        follow_mouse = 1 # 0|1|2|3
        kb_variant =
        kb_model =
        kb_options = caps:escape
        kb_rules =

        float_switch_override_focus = 2
        numlock_by_default = true

        touchpad {
          natural_scroll = no
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        force_no_accel = 1
      }

      device {
          name = epic mouse V1
          sensitivity = -0.5
      }

      general {
        gaps_in = 3       # 窗口之间的间隙大小
        gaps_out = 5      # 窗口与显示器边缘的间隙大小
        border_size = 2   # 窗口边框的宽度
        col.active_border = rgba(cceeffbb)    # 活动窗口的边框颜色
        col.inactive_border = rgba(595959aa) # 非活动窗口的边框颜色

        layout = dwindle # master|dwindle
      }

      dwindle {
        pseudotile = yes
        preserve_split = yes
        no_gaps_when_only = false
        force_split = 0
        special_scale_factor = 0.8
        split_width_multiplier = 1.0
        use_active_for_splits = true
      }

      master {
        new_status = master
        special_scale_factor = 0.8
        no_gaps_when_only = false
      }

      # cursor_inactive_timeout = 0
      decoration {
        rounding = 0
        active_opacity = 1.0
        inactive_opacity = 1.0
        fullscreen_opacity = 1.0
        drop_shadow = false
        shadow_range = 4
        shadow_render_power = 3
        shadow_ignore_window = true
      # col.shadow =
      # col.shadow_inactive
      # shadow_offset
        dim_inactive = false
      # dim_strength = #0.0 ~ 1.0
        col.shadow = rgba(1a1a1aee)

          blur {
              enabled = true
              size = 3
              passes = 1
              new_optimizations = true
              xray = true
              ignore_opacity = false
          }
      }

      # ▄▀█ █▄░█ █ █▀▄▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
      # █▀█ █░▀█ █ █░▀░█ █▀█ ░█░ █ █▄█ █░▀█

      # See https://wiki.hyprland.org/Configuring/Animations/

      animations {
        enabled = yes
        bezier = wind, 0.05, 0.9, 0.1, 1.05
        bezier = winIn, 0.1, 1.1, 0.1, 1.1
        bezier = winOut, 0.3, -0.3, 0, 1
        bezier = liner, 1, 1, 1, 1
        animation = windows, 1, 6, wind, slide
        animation = windowsIn, 1, 6, winIn, slide
        animation = windowsOut, 1, 5, winOut, slide
        animation = windowsMove, 1, 5, wind, slide
        animation = border, 1, 1, liner
        animation = borderangle, 1, 30, liner, loop
        animation = fade, 1, 10, default
        animation = workspaces, 1, 5, wind
      }

      gestures {
        workspace_swipe = true
        workspace_swipe_fingers = 3
        workspace_swipe_distance = 250
        workspace_swipe_invert = true
        workspace_swipe_min_speed_to_force = 15
        workspace_swipe_cancel_ratio = 0.5
        workspace_swipe_create_new = false
      }

      misc {
        vrr = 0
        disable_hyprland_logo = true
        disable_splash_rendering = true
        force_default_wallpaper = 0
        disable_autoreload = true
        always_follow_on_dnd = true
        layers_hog_keyboard_focus = true
        animate_manual_resizes = false
        enable_swallow = true
        swallow_regex =
        focus_on_activate = true
      }

      xwayland {
          force_zero_scaling = true
      }

      #-------------------------------#
      # Window/Session actions        #
      #-------------------------------#
      bind = $mainMod, Q, killactive
      bind = $mainMod SHIFT, Q, exit, # kill hyperland session
      bind = $mainMod, F, fullscreen, 1 # toggle the window on focus to fullscreen
      bind = $mainMod SHIFT, F, fullscreen, 0 # toggle the window on focus to fullscreen
      bind = $mainMod SHIFT, Z, exec, hyprlock # lock screen
      # bind = $mainMod, E, dolphin

      # ======================================================================
      # Open Browser
      # ======================================================================
      # bind = $mainMod, W, exec, $browser # open browser
      # bind = $mainMod, W, exec, web-search # web-search
      bind = $mainMod, W, exec, brave
      bind = $mainMod SHIFT, W, exec, $browser https://github.com/lcdse7en # se7en github
      bind = $mainMod, B, exec, $browser  https://www.bilibili.com/ # bilibili
      bind = $mainMod SHIFT, B, exec, $browser https://member.bilibili.com/platform/upload-manager/article # bilibili
      bind = $mainMod, F5, exec, $browser https://www.ijujitv.cc/show/1-----------2023.html # korea tv
      bind = $mainMod, F6, exec, $browser https://m.weibo.cn/u/1965284462 # korea movie weibo
      bind = $mainMod, F7, exec, $browser https://www.kpopn.com/category/news # kpopn
      bind = $mainMod, F8, exec, emacs  # open emacs

      bind = $mainMod, Return, exec, wezterm
      # bind = $mainMod, Return, exec, kitty --class="termfloat" wezterm

      bind = $mainMod SHIFT, Return, exec, kitty --class="termfloat"
      bind = $mainMod SHIFT, Space, togglefloating,
      bind = $mainMod,Y,pin
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, T, togglesplit, # dwindle

      #-------------------------------#
      # Screenshot                    #
      #-------------------------------#
      bind = $mainMod, n, exec, hyprshot -m output
      bind = $mainMod SHIFT, N, exec, hyprshot -m window
      bind = $mainMod, F12, exec, hyprshot -m region

      #-----------------------#
      # Toggle grouped layout #
      #-----------------------#
      bind = $mainMod SHIFT, T, togglegroup,
      bind = $mainMod, Tab, changegroupactive, f

      #------------#
      # change gap #
      #------------#
      bind = $mainMod SHIFT, G,exec,hyprctl --batch "keyword general:gaps_out 5;keyword general:gaps_in 3"
      bind = $mainMod , G,exec,hyprctl --batch "keyword general:gaps_out 0;keyword general:gaps_in 0"

      #--------------------------------------#
      # Move focus with mainMod + arrow keys #
      #--------------------------------------#
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d
      bind = $mainMod, H, movefocus, l
      bind = $mainMod, L, movefocus, r
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, J, movefocus, d

      #----------------------------------------#
      # Switch workspaces with mainMod + [0-9] #
      #----------------------------------------#
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10
      # bind = $mainMod, L, workspace, +1
      # bind = $mainMod, H, workspace, -1
      bind = $mainMod, period, workspace, e+1
      bind = $mainMod, comma, workspace,e-1
      bind = $mainMod, T, workspace,TG
      bind = $mainMod, M, workspace,Music

      #-------------------------------#
      # special workspace(scratchpad) #
      #-------------------------------#
      bind = $mainMod, S, togglespecialworkspace,
      bind = $mainMod SHIFT, S, movetoworkspacesilent, special

      #----------------------------------#
      # move window in current workspace #
      #----------------------------------#
      bind = $mainMod SHIFT,left ,movewindow, l
      bind = $mainMod SHIFT,right ,movewindow, r
      bind = $mainMod SHIFT,up ,movewindow, u
      bind = $mainMod SHIFT,down ,movewindow, d

      #---------------------------------------------------------------#
      # Move active window to a workspace with mainMod + ctrl + [0-9] #
      #---------------------------------------------------------------#
      bind = $mainMod CTRL, 1, movetoworkspace, 1
      bind = $mainMod CTRL, 2, movetoworkspace, 2
      bind = $mainMod CTRL, 3, movetoworkspace, 3
      bind = $mainMod CTRL, 4, movetoworkspace, 4
      bind = $mainMod CTRL, 5, movetoworkspace, 5
      bind = $mainMod CTRL, 6, movetoworkspace, 6
      bind = $mainMod CTRL, 7, movetoworkspace, 7
      bind = $mainMod CTRL, 8, movetoworkspace, 8
      bind = $mainMod CTRL, 9, movetoworkspace, 9
      bind = $mainMod CTRL, 0, movetoworkspace, 10
      bind = $mainMod CTRL, left, movetoworkspace, -1
      bind = $mainMod CTRL, right, movetoworkspace, +1
      # same as above, but doesnt switch to the workspace
      bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
      bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
      bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
      bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
      bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
      bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
      bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
      bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
      bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
      bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10
      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      #-------------------------------------------#
      # switch between current and last workspace #
      #-------------------------------------------#
      binds {
           workspace_back_and_forth = 1
           allow_workspace_cycles = 1
      }
      bind=$mainMod,slash,workspace,previous

      #------------------------#
      # quickly launch program #
      #------------------------#
      bind=$mainMod,B,exec,nvidia-offload firefox
      bind=$mainMod,M,exec,kitty --class="musicfox" --hold sh -c "musicfox"
      bind=$mainMod SHIFT,D,exec,kitty  --class="danmufloat" --hold sh -c "export TERM=xterm-256color && bili"
      bind=$mainMod,T,exec,telegram-desktop
      bind=$mainMod,bracketleft,exec,grimblast --notify --cursor  copysave area ~/Pictures/$(date "+%Y-%m-%d"T"%H:%M:%S_no_watermark").png
      bind=$mainMod,bracketright,exec, grimblast --notify --cursor  copy area
      bind=,Print,exec, flameshot_watermark
      bind=,Super_L,exec, pkill rofi || ~/.config/rofi/launcher.sh
      bind=$mainMod,Super_L,exec, bash ~/.config/rofi/powermenu.sh
      bind=$mainMod,q,exec, qq --enable-features=UseOzonePlatform --ozone-platform=x11

      #-----------------------------------------#
      # control volume,brightness,media players-#
      #-----------------------------------------#
      bind=,XF86AudioRaiseVolume,exec, pamixer -i 5
      bind=,XF86AudioLowerVolume,exec, pamixer -d 5
      bind=,XF86AudioMute,exec, pamixer -t
      bind=,XF86AudioMicMute,exec, pamixer --default-source -t
      bind=,XF86MonBrightnessUp,exec, light -A 5
      bind=,XF86MonBrightnessDown, exec, light -U 5
      bind=,XF86AudioPlay,exec, mpc -q toggle
      bind=,XF86AudioNext,exec, mpc -q next
      bind=,XF86AudioPrev,exec, mpc -q prev

      #---------------#
      # waybar toggle #
      # --------------#
      bind=$mainMod,O,exec,killall -SIGUSR1 .waybar-wrapped

      #---------------#
      # resize window #
      #---------------#
      bind=ALT,R,submap,resize
      submap=resize
      binde=,right,resizeactive,15 0
      binde=,left,resizeactive,-15 0
      binde=,up,resizeactive,0 -15
      binde=,down,resizeactive,0 15
      binde=,l,resizeactive,15 0
      binde=,h,resizeactive,-15 0
      binde=,k,resizeactive,0 -15
      binde=,j,resizeactive,0 15
      bind=,escape,submap,reset
      submap=reset

      bind=CTRL SHIFT, left, resizeactive,-15 0
      bind=CTRL SHIFT, right, resizeactive,15 0
      bind=CTRL SHIFT, up, resizeactive,0 -15
      bind=CTRL SHIFT, down, resizeactive,0 15
      bind=CTRL SHIFT, l, resizeactive, 15 0
      bind=CTRL SHIFT, h, resizeactive,-15 0
      bind=CTRL SHIFT, k, resizeactive, 0 -15
      bind=CTRL SHIFT, j, resizeactive, 0 15

      # Screenshot/Screencapture
      # bind = $mainMod, P, exec, ~/.config/hypr/scripts/screenshot.sh s # drag to snip an area / click on a window to print it
      bind = $mainMod, N, exec, ~/.config/hypr/scripts/screenshot.sh sf # frozen screen, drag to snip an area / click on a window to print it
      bind = $mainMod SHIFT, N, exec, ~/.config/hypr/scripts/screenshot.sh m # print focused monitor
      bind = ,print, exec, ~/.config/hypr/scripts/screenshot.sh p  # print all monitor outputs
      bind = $mainMod, INSERT, exec, hyprshot -m output -o ~/Pictures/Screenshots -f captura-$(date +'%Y-%m-%d-%s').png

      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # █▀ █▀█ █░█ █▀█ █▀▀ █▀▀
      # ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄

      #------------#
      # auto start #
      #------------#
      exec-once = mako &

      # █░█░█ █ █▄░█ █▀▄ █▀█ █░█░█   █▀█ █░█ █░░ █▀▀ █▀
      # ▀▄▀▄▀ █ █░▀█ █▄▀ █▄█ ▀▄▀▄▀   █▀▄ █▄█ █▄▄ ██▄ ▄█

      # See https://wiki.hyprland.org/Configuring/Window-Rules/
      #`hyprctl clients` get class、title...

      # windowrulev2 = opacity 0.90 0.90,class:^(firefox)$
      # windowrulev2 = opacity 0.90 0.90,class:^(Brave-browser)$
      windowrulev2 = opacity 0.80 0.80,class:^(kitty)$

      windowrule=opacity 0.8,kitty
      windowrule=float,title:^(Picture-in-Picture)$
      windowrule=size 960 540,title:^(Picture-in-Picture)$
      windowrule=move 25%-,title:^(Picture-in-Picture)$
      windowrule=float,imv
      windowrule=move 25%-,imv
      windowrule=size 960 540,imv
      windowrule=float,mpv
      windowrule=move 25%-,mpv
      windowrule=size 960 540,mpv
      windowrule=float,danmufloat
      windowrule=move 25%-,danmufloat
      windowrule=pin,danmufloat
      windowrule=rounding 5,danmufloat
      windowrule=size 960 540,danmufloat
      windowrule=float,termfloat
      windowrule=move 25%-,termfloat
      windowrule=size 960 540,termfloat
      windowrule=rounding 5,termfloat
      windowrule=float,nemo
      windowrule=move 25%-,nemo
      windowrule=size 960 540,nemo
      windowrule=opacity 0.95,title:Telegram
      windowrule=animation slide right,kitty
      windowrule=workspace name:TG, title:Telegram
      windowrule=workspace name:Music, musicfox
      windowrule=float,ncmpcpp
      windowrule=move 25%-,ncmpcpp
      windowrule=size 960 540,ncmpcpp
      windowrule=noblur,^(firefox)$

      #-----------------#
      # workspace rules #
      #-----------------#

      # ▄█ █▄█ █▄█ █▀▄ █▄▄ ██▄
      # █▀ █▀█ █░█ █▀█ █▀▀ █▀▀

      source = ~/.config/hypr/themes/common.conf # shared theme settings
      source = ~/.config/hypr/themes/theme.conf # theme specific settings
      source = ~/.config/hypr/themes/colors.conf # wallbash color override

      # workspace=HDMI-A-1,10
    '' + (if config.wayland.windowManager.hyprland.plugins == [ ] then
      ""
    else ''
      #---------#
      # plugins #
      #---------#
      submap=__easymotionsubmap__
      bind=ALT_SHIFT,p,killactive
      submap=reset
      plugin {
    '');
  };
}
