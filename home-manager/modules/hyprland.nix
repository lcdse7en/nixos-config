{ config, pkgs, configDir, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    # package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
  };

  settings = {
    source = [
      "~/.config/hypr/hyprland.conf"
    ];
  };
  "$mainMod" = "SUPER"; # windows key
  "$terminal" = "wezterm";
  # "$browser" = "brave";

  bind = [
    "$mainMod SHIFT, Q, exec, exit"
    "$mainMod, Return, exec, $terminal"
  ];
  # programs.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  # };

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
