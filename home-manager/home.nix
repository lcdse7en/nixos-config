{ inputs
, config
, pkgs
, lib
, ...
}:
let
  configDir = "${config.home.homeDirectory}/dotfiles";
in
{
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
    stateVersion = "24.05";
  };

  home.file = {
    # ".config/hypr/hyprland.conf".source = ../dotfiles/config/hypr/hyprland.conf;
  };

  imports = [
    ./shell
    ./terminals

    ./programs
    ./packages

    # ./dev

    ./wm/hyprland

    (import ./editors/neovim { inherit config configDir; })

    # ../pkgs

  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "brave";
  };

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
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  qt = {
    enable = true;
    style.name = "adwaita-dark";
    platformTheme.name = "gtk3";
  };
  # Scripts
  home.packages = [
    (import ../scripts/screenshootin.nix { inherit pkgs; })
    (import ../scripts/web-search.nix { inherit pkgs; })

  ];
}
