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

      @import "theme.css";

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
      "custom/theme" = {
        "format" = "{}";
        "rotate" = 0;
        "exec" = "echo ; echo 󰟡 switch theme";
        "on-click" = "themeswitch.sh -n";
        "on-click-right" = "themeswitch.sh -p";
        "on-click-middle" = "sleep 0.1 && themeselect.sh";
        "interval" = 86400; #// once every day
        "tooltip" = true;
      };
      "custom/wallchange" = {
        "format" = "{}";
        "rotate" = 0;
        "exec" = "echo ; echo 󰆊 switch wallpaper";
        "on-click" = "swwwallpaper.sh -n";
        "on-click-right" = "swwwallpaper.sh -p";
        "on-click-middle" = "sleep 0.1 && swwwallselect.sh";
        "interval" = 86400; #// once every day
        "tooltip" = true;
      };
      "wlr/taskbar" = {
        "format" = "{icon}";
        "rotate" = 0;
        "icon-size" = 18;
        "icon-theme" = "Tela-circle-dracula";
        "spacing" = 0;
        "tooltip-format" = "{title}";
        "on-click" = "activate";
        "on-click-middle" = "close";
        "ignore-list" = [ "Alacritty" ];
        "app_ids-mapping" = {
          "firefoxdeveloperedition" = "firefox-developer-edition";
        };
      };
      "idle_inhibitor" = {
        "format" = "{icon}";
        "rotate" = 0;
        "format-icons" = {
          "activated" = "󰥔";
          "deactivated" = "";
        };
      };
      "clock" = {
        "format" = "{:%I:%M %p}";
        "rotate" = 0;
        "format-alt" = "{:%R 󰃭 %d·%m·%y}";
        "tooltip-format" = "<tt>{calendar}</tt>";
        "calendar" = {
          "mode" = "month";
          "mode-mon-col" = 3;
          "on-scroll" = 1;
          "on-click-right" = "mode";
          "format" = {
            "months" = "<span color='#ffead3'><b>{}</b></span>";
            "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
            "today" = "<span color='#ff6699'><b>{}</b></span>";
          };
        };
        "actions" = {
          "on-click-right" = "mode";
          "on-click-forward" = "tz_up";
          "on-click-backward" = "tz_down";
          "on-scroll-up" = "shift_up";
          "on-scroll-down" = "shift_down";
        };
      };
      "tray" = {
        "icon-size" = 18;
        "rotate" = 0;
        "spacing" = 5;
      };
      "battery" = {
        "states" = {
          "good" = 95;
          "warning" = 30;
          "critical" = 20;
        };
        "format" = "{icon} {capacity}%";
        "rotate" = 0;
        "format-charging" = " {capacity}%";
        "format-plugged" = " {capacity}%";
        "format-alt" = "{time} {icon}";
        "format-icons" = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
      };

      "backlight" = {
        "device" = "intel_backlight";
        "rotate" = 0;
        "format" = "{icon} {percent}%";
        "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
        "on-scroll-up" = "brightnessctl set 1%+";
        "on-scroll-down" = "brightnessctl set 1%-";
        "min-length" = 6;
      };

      "network" = {
        "tooltip" = true;
        "format-wifi" = " ";
        "rotate" = 0;
        "format-ethernet" = "󰈀 ";
        "tooltip-format" = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm
        ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP:
        <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>";
        "format-linked" = "󰈀 {ifname} (No IP)";
        "format-disconnected" = "󰖪 ";
        "tooltip-format-disconnected" = "Disconnected";
        "format-alt" = "<span foreground='#99ffdd'> {bandwidthDownBytes}</span> <span foreground='#ffcc66'>
      {bandwidthUpBytes}</span>";
        "interval" = 2;
      };
      "pulseaudio" = {
        "format" = "{icon} {volume}";
        "rotate" = 0;
        "format-muted" = "婢";
        "on-click" = "pavucontrol -t 3";
        "on-click-middle" = "volumecontrol.sh -o m";
        "on-scroll-up" = "volumecontrol.sh -o i";
        "on-scroll-down" = "volumecontrol.sh -o d";
        "tooltip-format" = "{icon} {desc} // {volume}%";
        "scroll-step" = 5;
        "format-icons" = {
          "headphone" = "";
          "hands-free" = "";
          "headset" = "";
          "phone" = "";
          "portable" = "";
          "car" = "";
          "default" = [ "" "" "" ];
        };
      };

      # "custom/notifications" = {
      #   "tooltip" = false;
      #   "format" = "{icon} {}";
      #   "rotate" = 0;
      #   "format-icons" = {
      #     "email-notification" = "<span foreground='white'><sup></sup></span>";
      #     "chat-notification" = "󱋊<span foreground='white'><sup></sup></span>";
      #     "warning-notification" = "󱨪<span foreground='yellow'><sup></sup></span>";
      #     "error-notification" = "󱨪<span foreground='red'><sup></sup></span>";
      #     "network-notification" = "󱂇<span foreground='white'><sup></sup></span>";
      #     "battery-notification" = "󰁺<span foreground='white'><sup></sup></span>";
      #     "update-notification" = "󰚰<span foreground='white'><sup></sup></span>";
      #     "music-notification" = "󰝚<span foreground='white'><sup></sup></span>";
      #     "volume-notification" = "󰕿<span foreground='white'><sup></sup></span>";
      #     "notification" = "<span foreground='white'><sup></sup></span>";
      #     "none" = "";
      #   };
      #   "return-type" = "json";
      #   "exec-if" = "which dunstctl";
      #   "exec" = "notifications.py";
      #   "on-click" = "sleep 0.1 && dunstctl history-pop";
      #   "on-click-middle" = "dunstctl history-clear";
      #   "on-click-right" = "dunstctl close-all";
      #   "interval" = 1;
      #   "tooltip" = true;
      #   "escape" = true;
      # };
      #
      # "custom/keybindhint" = {
      #   "format" = " ";
      #   "rotate" = 0;
      #   "on-click" = "keybinds_hint.sh";
      # };

      #// modules for padding //

      # "custom/l_end" = {
      #   "format" = " ";
      #   "interval" = "once";
      # };
      #
      # "custom/r_end" = {
      #   "format" = " ";
      #   "interval" = "once";
      # };
      #
      # "custom/sl_end" = {
      #   "format" = " ";
      #   "interval" = "once";
      # };
      #
      # "custom/sr_end" = {
      #   "format" = " ";
      #   "interval" = "once";
      # };
      #
      # "custom/rl_end" = {
      #   "format" = " ";
      #   "interval" = "once";
      # };
      #
      # "custom/rr_end" = {
      #   "format" = " ";
      #   "interval" = "once";
      # };
      #
      # "custom/padd" = {
      #   "format" = "  ";
      #   "interval" = "once";
      # };

    }];
  };
}
