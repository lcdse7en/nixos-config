{ inputs, pkgs, ... }:
{
  imports = [ ./config.nix ];

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      # inputs.hycov.packages.${pkgs.system}.hycov
      # inputs.hypreasymotion.packages.${pkgs.system}.hypreasymotion
    ];
    systemd.enable = true;
  };

  home.packages = [
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
  ] ++ (with pkgs;[
    swww
    swaylock-effects
    swayidle
    pamixer
  ]);

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  home = {
    sessionVariables = {
      QT_SCALE_FACTOR = "1";
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      CLUTTER_BACKEND = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };
  };

  home.file = {
    ".config/hypr/themes/colors.conf".source = ./themes/colors.conf;
    ".config/hypr/themes/common.conf".source = ./themes/common.conf;
    ".config/hypr/themes/theme.conf".source = ./themes/theme.conf;
  };
}
