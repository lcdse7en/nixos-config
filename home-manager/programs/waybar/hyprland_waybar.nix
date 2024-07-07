{ config, pkgs, ... }:
let sharedScripts = import ./share_scripts.nix { inherit pkgs; };
in {
  home.packages = with pkgs; [ wlogout ];

  programs.waybar.enable = true;
  programs.waybar.style = ./style.css;

  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      height = 30;
      margin-top = 10;
      margin-left = 10;
      margin-bottom = 0;
      margin-right = 10;
      spacing = 0;
      # position = "top";
      # output = [ "eDP-1" ];

      modules-left = [
        "custom/separator"
        "custom/logo"
        "custom/separator"
        "cpu"
        "memory"
        "temperature"
        "custom/filler"
        "custom/playerctl"
        "custom/filler"
        "disk"
        "custom/filler"
      ];
      modules-right = [
        "custom/dot"
        "network"
        "custom/separator"
        "custom/dot"
        "pulseaudio"
        "custom/separator"
        "custom/clock-icon"
        "clock"
        "custom/power"
      ];
      modules-center = [ "hyprland/workspaces" ];

      "custom/logo" = {
        format = "";
        tooltip = false;
      };
      "custom/filler" = { "format" = " "; };
      "custom/dot" = { "format" = " "; };
      "custom/clock-icon" = { "format" = ""; };
      "custom/separator" = { "format" = " "; };
      "custom/window-name" = {
        "format" = " <b>{}</b>";
        "interval" = 1;
        "exec" = "hyprctl activewindow | grep class | awk '{print $2}'";
      };

      "hyprland/workspaces" = {
        "all-outputs" = true;
        "active-only" = false;
        "on-click" = "activate";
        "format" = "{icon}";
        "on-scroll-up" = "hyprctl dispatch workspace e+1";
        "on-scroll-down" = "hyprctl dispatch workspace e-1";
        "format-icons" = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "6" = "";
          "urgent" = "";
          "active" = "";
          "default" = "";
        };
      };

      "disk" = {
        "interval" = 1;
        "format" = ''<span color="#68b0d6"> </span> {}%'';
        "on-click" = "filelight /";
        "on-click-right" = "filelight /home/";
      };

      "tray" = {
        "icon-size" = 20;
        "spacing" = 8;
      };

      "clock" = {
        "format" = "<b>{:%I:%M %p }</b>";
        "format-alt" = "<b>{:%a.%d;%b}</b>";
        "tooltip-format" = ''
          <big>{:%B %Y}</big>
          <tt><small>{calendar}</small></tt>'';
      };

      "custom/power" = {
        "format" = "{}";
        "exec" = "echo ; echo  logout";
        "on-click" = "logoutlaunch.sh 2";
        "on-click-right" = "logoutlaunch.sh 1";
        "interval" = 86400; # once every day
        "tooltip" = true;
      };

      "cpu" = {
        "interval" = 10;
        "format" = " {usage}%";
        "max-length" = 10;
        "on-click" = "btop";
      };
      "memory" = {
        "interval" = 30;
        "format" = " {used}GiB";
        "format-alt" = " {used:0.1f}G";
        "max-length" = 10;
        "on-click-right" = "btop";
      };
      "temperature" = {
        "thermal-zone" = 0;
        "critical-threshold" = 80;
        "format-critical" = " {temperatureC}°C";
        "format" = " {temperatureC}°C";
      };

      "custom/playerctl" = {
        "format" = "[<span foreground='#46c880'>  </span> <span>{}</span> ]";
        "return-type" = "json";
        "max-length" = 55;
        "exec" =
          ''playerctl -a metadata --format '{"text": "{{playerName}}"}' -F'';
        "on-click" = "playerctl play-pause";
        "on-click-middle" = "playerctl previous";
        "on-click-right" = "playerctl next";
        "format-icons" = {
          "Playing" = "<span foreground='#46c880'>  </span>";
          "Paused" = "<span foreground='#cdd6f4'> 󰏥 </span>";
        };
      };

      "pulseaudio" = {
        "format" = "{icon} <b>{volume}</b>";
        "format-bluetooth" = " {volume}";
        "format-bluetooth-muted" = " ";
        "tooltip" = false;
        "format-muted" = "";
        "format-icons" = { "default" = [ "󰝟" "" "󰕾" "" ]; };
        "on-click" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "on-click-right" = "pavucontrol";
      };

      "network" = {
        "format-wifi" = " ";
        "format-ethernet" =
          "󰈀   {bandwidthDownBits}  {bandwidthUpBits} {ipaddr}/{cidr}";
        "tooltip-format" = ''
          Network: <big><b>{essid}</b></big>
          Signal strength: <b>{signaldBm}dBm
                  ({signalStrength}%)</b>
          Frequency: <b>{frequency}MHz</b>
          Interface: <b>{ifname}</b>
          IP:
                  <b>{ipaddr}/{cidr}</b>
          Gateway: <b>{gwaddr}</b>
          Netmask: <b>{netmask}</b>'';
        "format-linked" = "󰈀 {ifname} (No IP)";
        "format-disconnected" = "󰖪 ";
        "tooltip-format-disconnected" = "Disconnected";
        "format-alt" = ''
          <span foreground='#99ffdd'> {bandwidthDownBytes}</span> <span foreground='#ffcc66'>
                {bandwidthUpBytes}</span>'';
        "interval" = 2;
      };

      "battery" = {
        format = "{icon}   {capacity}%";
        format-charging = "⚡{capacity}%";
        format-icons = [ "" "" "" "" "" ];
        states = { critical = 20; };
        tooltip = false;
      };

      "custom/wrap-left" = { "format" = "<b>[</b>"; };
      "custom/wrap-right" = { "format" = "<b>]</b>"; };

    };
  };
}
