{ config, pkgs, configDir, ... }:
{
  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   package = pkgs.hyprland;
  #   xwayland.enable = true;
  #   systemd.enable = true;
  # };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # home.packages = with pkgs; [
  #   swww
  # ];
  #
  # xdg.configFile = {
  #   hypr = {
  #     source = config.lib.file.mkOutOfStoreSymlink "${configDir}/hypr";
  #     recursive = true;
  #   };
  # };

  #  extraPackages = with pkgs; [
  #   nodePackages.pyright
  #    rust-analyzer
  #  ];

}
