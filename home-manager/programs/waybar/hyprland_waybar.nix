{ config, pkgs, ... }: {
  # home.packages = with pkgs; [
  #   font-awesome_6
  #   (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  # ];

  # programs.waybar = {
  #   enable = true;
  #   # catppuccin.enable = false;
  #   style = ./style.css;
  #   settings = {
  #     mainBar = {
  #       margin-top = 10;
  #       margin-left = 7;
  #       width = 1900;
  #       height = 22;
  #       modules-left = [ "hyprland/workspaces" ];
  #       modules-center = [ "clock" ];
  #       modules-right = [ "network" "memory" "battery" "pulseaudio" ];
  #       clock = {
  #         format = " {:%r  %d/%m/%y}";
  #         interval = 1;
  #         tooltip-format = ''
  #           <big>{:%Y %B}</big>
  #           <tt><small>{calendar}</small></tt>'';
  #       };
  #     };
  #   };
  # };

  programs.waybar.enable = true;

  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      position = "top";
      height = 26;
      # output = [ "eDP-1" ];

      modules-left = [
        "custom/logo"
        "custom/separator"
        "custom/playerctl"
        "custom/filler"
        "pulseaudio"
        "custom/dot"
      ];
      modules-right = [ "cpu" "memory" "temperature" "custom/filler" "clock" ];
      modules-center = [ "hyprland/workspaces" ];

      "custom/logo" = {
        format = "";
        tooltip = false;
      };
      "custom/filler" = { "format" = " "; };
      "custom/dot" = { "format" = " "; };
      "custom/clock-icon" = { "format" = ""; };
      "custom/separator" = { "format" = " "; };

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
          "7" = "";
          "8" = "";
          "9" = "";
          "urgent" = "";
          "active" = "";
          "default" = "";
        };
      };

      "clock" = {
        "format" = "<b>{:%I:%M %p }</b>";
        "format-alt" = "<b>{:%a.%d;%b}</b>";
        "tooltip-format" = ''
          <big>{:%B %Y}</big>
          <tt><small>{calendar}</small></tt>'';
      };

      "cpu" = {
        "interval" = 10;
        "format" = " {usage}% ";
        "max-length" = 10;
        "on-click" = "btop";
      };
      "memory" = {
        "interval" = 30;
        "format" = " {}% ";
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

      # "hyprland/workspaces" = {
      #   format = "{icon}";
      #   tooltip = false;
      #   all-outputs = true;
      #   format-icons = {
      #     active = "";
      #     default = "";
      #   };
      # };

      "network" = {
        format = "  ";
        format-ethernet = "  ";
        tooltip = false;
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

  programs.waybar.style = ''
    * {
      padding: 0;
      margin: 0;
      font-family: JetBrainsMono Nerd Font;
      border: none;
      border-radius: 0;
      font-size: 16px;
      color: #1a1c2b;
    }

    window#waybar {
      background: rgba(0,0,0,0,);
    }

    #custom-logo {
      font-size: 18px;
      margin: 0;
      margin-left: 7px;
      margin-right: 12px;
      padding: 0;
      font-family: Fira Code;
      color: #b4befe;
    }

    #workspaces button {
      color: #b4befe;
    }

    #battery {
      margin-left: 7px;
      margin-right: 5px;
      color: #b4befe;
    }
  '';

}
