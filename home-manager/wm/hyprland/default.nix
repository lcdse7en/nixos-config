{ inputs, pkgs, ... }: {
  imports = [ ./config.nix ];

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      # inputs.hycov.packages.${pkgs.system}.hycov
      # inputs.hypreasymotion.packages.${pkgs.system}.hypreasymotion
    ];
    systemd.enable = true;
    settings = {
      env = [
        "XMODIFIERS, @im=fcitx"
        "QT_IM_MODULE, fcitx"
        "SDL_IM_MODULE, fcitx"
        "QT_QPA_PLATFORMTHEME, qt5ct"
        "GDK_BACKEND, wayland,x11"
      ];
    };

  };

  home.packages = [
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
  ] ++ (with pkgs; [
    swww
    hyprlock
    hyprshot
    swappy
    hyprcursor
    pamixer
    imagemagick
    slurp
    pavucontrol
    playerctl
    wl-clipboard
    pulseaudio
    dolphin
  ]);

  systemd.user.targets.hyprland-session.Unit.Wants =
    [ "xdg-desktop-autostart.target" ];

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

  services.kdeconnect = {
    package = pkgs.kdePackages.kdeconnect-kde;
    enable = true;
    indicator = true;
  };

}
