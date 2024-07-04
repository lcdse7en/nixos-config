{ pkgs, ... }:
let
  sharedScripts = import ./share_scripts.nix { inherit pkgs; };
in
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false; # disable it,autostart it in sway conf
      target = "graphical-session.target";
    };
    style = ''
      * {
          border: none;
          border-radius: 0px;
          font-family: "JetBrainsMono Nerd Font";
          font-weight: bold;
          font-size: 10px;
          min-height: 10px;
      }

      @define-color bar-bg rgba(0, 0, 0, 0);

      @define-color main-bg #11111b;
      @define-color main-fg #cdd6f4;

      @define-color wb-act-bg #a6adc8;
      @define-color wb-act-fg #313244;

      @define-color wb-hvr-bg #f5c2e7;
      @define-color wb-hvr-fg #313244;

            window#waybar {
                background: @bar-bg;
            }

            tooltip {
                background: @main-bg;
                color: @main-fg;
                border-radius: 7px;
                border-width: 0px;
            }

            #workspaces button {
                box-shadow: none;
            	text-shadow: none;
                padding: 0px;
                border-radius: 9px;
                margin-top: 3px;
                margin-bottom: 3px;
                margin-left: 0px;
                padding-left: 3px;
                padding-right: 3px;
                margin-right: 0px;
                color: @main-fg;
                animation: ws_normal 20s ease-in-out 1;
            }

            #workspaces button.active {
                background: @wb-act-bg;
                color: @wb-act-fg;
                margin-left: 3px;
                padding-left: 12px;
                padding-right: 12px;
                margin-right: 3px;
                animation: ws_active 20s ease-in-out 1;
                transition: all 0.4s cubic-bezier(.55,-0.68,.48,1.682);
            }

            #workspaces button:hover {
                background: @wb-hvr-bg;
                color: @wb-hvr-fg;
                animation: ws_hover 20s ease-in-out 1;
                transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
            }

            #taskbar button {
                box-shadow: none;
            	text-shadow: none;
                padding: 0px;
                border-radius: 9px;
                margin-top: 3px;
                margin-bottom: 3px;
                margin-left: 0px;
                padding-left: 3px;
                padding-right: 3px;
                margin-right: 0px;
                color: @wb-color;
                animation: tb_normal 20s ease-in-out 1;
            }

            #taskbar button.active {
                background: @wb-act-bg;
                color: @wb-act-color;
                margin-left: 3px;
                padding-left: 12px;
                padding-right: 12px;
                margin-right: 3px;
                animation: tb_active 20s ease-in-out 1;
                transition: all 0.4s cubic-bezier(.55,-0.68,.48,1.682);
            }

            #taskbar button:hover {
                background: @wb-hvr-bg;
                color: @wb-hvr-color;
                animation: tb_hover 20s ease-in-out 1;
                transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
            }

            #tray menu * {
                min-height: 16px
            }

            #tray menu separator {
                min-height: 10px
            }

            #backlight,
            #battery,
            #bluetooth,
            #custom-cliphist,
            #clock,
            #custom-cpuinfo,
            #cpu,
            #custom-gpuinfo,
            #idle_inhibitor,
            #custom-keybindhint,
            #language,
            #memory,
            #mpris,
            #network,
            #custom-notifications,
            #custom-power,
            #pulseaudio,
            #custom-spotify,
            #taskbar,
            #custom-theme,
            #tray,
            #custom-updates,
            #custom-wallchange,
            #custom-wbar,
            #window,
            #workspaces,
            #custom-l_end,
            #custom-r_end,
            #custom-sl_end,
            #custom-sr_end,
            #custom-rl_end,
            #custom-rr_end {
                color: @main-fg;
                background: @main-bg;
                opacity: 1;
                margin: 4px 0px 4px 0px;
                padding-left: 4px;
                padding-right: 4px;
            }

            #workspaces,
            #taskbar {
                padding: 0px;
            }

            #custom-r_end {
                border-radius: 0px 21px 21px 0px;
                margin-right: 9px;
                padding-right: 3px;
            }

            #custom-l_end {
                border-radius: 21px 0px 0px 21px;
                margin-left: 9px;
                padding-left: 3px;
            }

            #custom-sr_end {
                border-radius: 0px;
                margin-right: 9px;
                padding-right: 3px;
            }

            #custom-sl_end {
                border-radius: 0px;
                margin-left: 9px;
                padding-left: 3px;
            }

            #custom-rr_end {
                border-radius: 0px 7px 7px 0px;
                margin-right: 9px;
                padding-right: 3px;
            }

            #custom-rl_end {
                border-radius: 7px 0px 0px 7px;
                margin-left: 9px;
                padding-left: 3px;
            }
    '';

    settings = [{
      #  positions generated based on config.ctl

      modules-left = [
        "custom/padd"
        "custom/l_end"
        "custom/power"
        "custom/cliphist"
        "custom/wbar"
        "custom/theme"
        "custom/wallchange"
        "custom/r_end"
        "custom/l_end"
        "wlr/taskbar"
        "custom/spotify"
        "custom/r_end"
        ""
        "custom/padd"
      ];
      modules-center = [
        "custom/padd"
        "custom/l_end"
        "idle_inhibitor"
        "clock"
        "custom/r_end"
        "custom/padd"
      ];
      modules-right = [
        "custom/padd"
        "custom/l_end"
        "tray"
        "battery"
        "custom/r_end"
        "custom/l_end"
        "backlight"
        "network"
        "pulseaudio"
        "pulseaudio#microphone"
        "custom/notifications"
        "custom/keybindhint"
        "custom/r_end"
        "custom/padd"
      ];

      # sourced from modules based on config.ctl

      "custom/power" = {
        "format" = "{}";
        "rotate" = 0;
        "exec" = "echo ; echo  logout";
        "on-click" = "logoutlaunch.sh 2";
        "on-click-right" = "logoutlaunch.sh 1";
        "interval" = 86400; # once every day
        "tooltip" = true;
      };
      "custom/cliphist" = {
        "format" = "{}";
        "rotate" = 0;
        "exec" = "echo ; echo 󰅇 clipboard history";
        "on-click" = "sleep 0.1 && cliphist.sh c";
        "on-click-right" = "sleep 0.1 && cliphist.sh d";
        "on-click-middle" = "sleep 0.1 && cliphist.sh w";
        "interval" = 86400; # once every day
        "tooltip" = true;
      };
      "custom/wbar" = {
        "format" = "{}"; #   
        "rotate" = 0;
        "exec" = "echo ; echo  switch bar //  dock";
        "on-click" = "wbarconfgen.sh n";
        "on-click-right" = "wbarconfgen.sh p";
        "on-click-middle" = "sleep 0.1 && quickapps.sh kitty firefox spotify code dolphin";
        "interval" = 86400;
        "tooltip" = true;
      };

      # "custom/launcher" = {
      #   "format" = " ";
      #   "on-click" = "~/.config/rofi/launcher.sh";
      #   "tooltip" = false;
      # };
      # "custom/wall" = {
      #   "on-click" = "${sharedScripts.wallpaper_random}/bin/wallpaper_random";
      #   "on-click-middle" = "${sharedScripts.default_wall}/bin/default_wall";
      #   "on-click-right" = "killall dynamic_wallpaper || ${sharedScripts.dynamic_wallpaper}/bin/dynamic_wallpaper &";
      #   "format" = " 󰠖 ";
      #   "tooltip" = false;
      # };
      # "custom/cava-internal" = {
      #   "exec" = "sleep 1s && ${sharedScripts.cava-internal}/bin/cava-internal";
      #   "tooltip" = false;
      # };
      # "sway/workspaces" = {
      #   "disable-scroll" = true;
      # };
      # "backlight" = {
      #   "device" = "intel_backlight";
      #   "on-scroll-up" = "light -A 5";
      #   "on-scroll-down" = "light -U 5";
      #   "format" = "{icon} {percent}%";
      #   "format-icons" = [ "󰃝" "󰃞" "󰃟" "󰃠" ];
      # };
      # "pulseaudio" = {
      #   "scroll-step" = 1;
      #   "format" = "{icon} {volume}%";
      #   "format-muted" = "󰖁 Muted";
      #   "format-icons" = {
      #     "default" = [ "" "" "" ];
      #   };
      #   "on-click" = "pamixer -t";
      #   "tooltip" = false;
      # };
      # "battery" = {
      #   "interval" = 10;
      #   "states" = {
      #     "warning" = 20;
      #     "critical" = 10;
      #   };
      #   "format" = "{icon} {capacity}%";
      #   "format-icons" = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
      #   "format-full" = "{icon} {capacity}%";
      #   "format-charging" = "󰂄 {capacity}%";
      #   "tooltip" = false;
      # };
      # "clock" = {
      #   "interval" = 1;
      #   "format" = "{:%I:%M %p  %A %b %d}";
      #   "tooltip" = true;
      #   "tooltip-format" = "{=%A; %d %B %Y}\n<tt>{calendar}</tt>";
      # };
      # "memory" = {
      #   "interval" = 1;
      #   "format" = "󰍛 {percentage}%";
      #   "states" = {
      #     "warning" = 85;
      #   };
      # };
      # "cpu" = {
      #   "interval" = 1;
      #   "format" = "󰻠 {usage}%";
      # };
      # "mpd" = {
      #   "max-length" = 25;
      #   "format" = "<span foreground='#bb9af7'></span> {title}";
      #   "format-paused" = " {title}";
      #   "format-stopped" = "<span foreground='#bb9af7'></span>";
      #   "format-disconnected" = "";
      #   "on-click" = "mpc --quiet toggle";
      #   "on-click-right" = "mpc update; mpc ls | mpc add";
      #   "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp";
      #   "on-scroll-up" = "mpc --quiet prev";
      #   "on-scroll-down" = "mpc --quiet next";
      #   "smooth-scrolling-threshold" = 5;
      #   "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
      # };
      # "network" = {
      #   "interval" = 1;
      #   "format-wifi" = "󰖩 {essid}";
      #   "format-ethernet" = "󰀂 {ifname} ({ipaddr})";
      #   "format-linked" = "󰖪 {essid} (No IP)";
      #   "format-disconnected" = "󰯡 Disconnected";
      #   "tooltip" = false;
      # };
      # "temperature" = {
      #   #"critical-threshold"= 80;
      #   "tooltip" = false;
      #   "format" = " {temperatureC}°C";
      # };
      # "custom/powermenu" = {
      #   "format" = "";
      #   "on-click" = "~/.config/rofi/powermenu.sh";
      #   "tooltip" = false;
      # };
      # "tray" = {
      #   "icon-size" = 15;
      #   "spacing" = 5;
      # };
    }];
  };
}
