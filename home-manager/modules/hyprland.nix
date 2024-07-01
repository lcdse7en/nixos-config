{ config, pkgs ... }:
let
in {
  home.packages = with pkgs; [

  ];

  home.file = {
    # ".config/hypr/.conf" = "${configDir}/hypr/";

    # wallpaper config

    # waybar confit
  };

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
    ];
    extraConfig = ''
      ${builtins.readFile ./config/hypr/hyprland.conf }
    '';
  };

}

# settings = {
#   source = [
#     "~/.config/hypr/hyprland.conf"
#   ];
#   "$mainMod" = "SUPER"; # windows key
#   "$terminal" = "wezterm";
#   "$browser" = "brave";
#
#   bind = [
#     "$mainMod SHIFT, Q, exec, exit"
#     "$mainMod, Return, exec, $terminal"
#   ];
# };

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
