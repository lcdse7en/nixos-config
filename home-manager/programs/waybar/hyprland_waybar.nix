{ config, pkgs, lib, ... }:
let sharedScripts = import ./share_scripts.nix { inherit pkgs; };
in {
  home.packages = with pkgs; [ wttrbar wl-screenrec jq zenity wlogout ];

  programs.waybar = {
    enable = true;
    settings = [{
      position = "top";
      include = [ "${./shared.json}" ];
      modules-center = [ "hyprland/workspaces" ];
      modules-left = [
        "custom/separator"
        "custom/logo"
        "custom/separator"
        "cpu"
        "memory"
        "temperature"
        "custom/filler"
        # "custom/playerctl"
        "custom/spotify"
        "custom/filler"
        "disk"
        "custom/recorder"
        "custom/vpn"
        # "tray"
      ];
      modules-right = [
        "custom/dot"
        "network"
        "custom/separator"
        "custom/dot"
        "pulseaudio"
        "custom/separator"
        "custom/weather"
        "clock"
        "custom/power"
        # "custom/reboot"
      ];
      "custom/spotify" = {
        format = "{icon} {}";
        return-type = "json";
        max-length = 40;
        escape = true;
        on-click = "${lib.getExe pkgs.playerctl} -p spotify play-pause";
        on-click-right = "killall spotify";
        smooth-scrolling-threshold = 10;
        on-scroll-up = "${lib.getExe pkgs.playerctl} -p spotify next";
        on-scroll-down = "${lib.getExe pkgs.playerctl} -p spotify previous";
        exec = "${
            lib.getExe (pkgs.callPackage ./mediaplayer.nix { })
          } --player spotify 2> /dev/null";
        exec-if = "pgrep spotify";
        restart-interval = 2;
      };
    }];
    style = builtins.readFile ./style.css;
    # systemd.enable = true;
  };
}
