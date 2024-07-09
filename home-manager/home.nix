{ inputs, config, pkgs, lib, ... }:
let configDir = "${config.home.homeDirectory}/dotfiles";
in {
  nixpkgs.overlays = [
    (final: prev:
      (import ../packages {
        inherit inputs;
        inherit pkgs;
      }))
    inputs.neovim-nightly-overlay.overlays.default
  ];

  home = {
    username = "se7en";
    homeDirectory = "/home/se7en";
    sessionVariables = {
      EDITOR = "nvim";
      # TERM = "xterm-256color";
      COLORTERM = "truecolor";
    };
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 22;
    };
    stateVersion = "24.05";
  };

  xdg.enable = true;
  xdg.configFile."nix/nix.conf".text = ''
    experimental-features = nix-command flakes
    # see https://github.com/nix-community/nix-direnv#via-home-manager
    keep-derivations = true
    keep-outputs = true
  '';

  home.file = {
    # ".config/hypr/hyprland.conf".source = ../dotfiles/config/hypr/hyprland.conf;
  };

  imports = [
    ./shell
    ./terminals

    ./programs
    ./packages

    # ./dev

    # ./wm/hyprland
    # ./wm/hyprlock

    ./wm/sway

    (import ./editors/neovim { inherit config pkgs configDir; })

    # ../pkgs

  ] ++ lib.concatMap import [ ../scripts ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    # Direnv integration for flakes
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
  };

  # Place Files Inside Home Directory
  home.file."Pictures/Wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };

  # Styling Options
  stylix.targets.waybar.enable = false;
  stylix.targets.rofi.enable = false;
  stylix.targets.hyprland.enable = false;
  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = 1; };
    gtk4.extraConfig = { gtk-application-prefer-dark-theme = 1; };
  };
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme.name = "gtk3";
  };

  # Scripts
  home.packages = [
    # (import ../scripts/default.nix { inherit pkgs; })
    # (import ../scripts/web-search.nix { inherit pkgs; })

  ];
}
