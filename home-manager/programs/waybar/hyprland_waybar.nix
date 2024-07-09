{ config, pkgs, ... }:
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
        "custom/playerctl"
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
    }];
    style = builtins.readFile ./style.css;
    # systemd.enable = true;
  };
}
