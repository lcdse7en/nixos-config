{ config, pkgs, configDir, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
  };

  xdg.configFile = {
    hypr = {
      source = config.lib.file.mkOutOfStoreSymlink "${configDir}/hyprland";
      recursive = true;
    };
  };
}
