{ config, pkgs, ... }:
let sharedScripts = import ./share_scripts.nix { inherit pkgs; };
in {
  home.packages = with pkgs; [ wlogout ];

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
        "custom/filler"
        "tray"
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
    }];
    style = builtins.readFile ./style.css;
    # systemd.enable = true;
  };
}
