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
        "QT_QPA_PLATFORM, wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "CLUTTER_BACKEND, wayland"
        "ADW_DISABLE_PORTAL, 1"
        # "GDK_SCALE,2"
        "XCURSOR_SIZE, 24"
        "HYPRCURSOR_SIZE, 24"
      ];
      exec-once = [
        "echo 'Xft.dpi: 192' | xrdb -merge"
        "ags -b hypr"
        "hyprshade auto"
        "fcitx5 -d --replace"
        "hyprctl dispatch exec [workspace 1 silent] wezterm"
      ];
    };

  };

  home.packages = [
    inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
  ] ++ (with pkgs; [
    swww
    hyprlock
    swappy
    hyprcursor
    pamixer
    imagemagick
    slurp
    pavucontrol
    playerctl
    wl-clipboard
    pulseaudio
    wf-recorder
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
