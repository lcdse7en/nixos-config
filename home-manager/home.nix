{ inputs
, lib
, config
, pkgs
, ...
}:
let
  configDir = "${config.home.homeDirectory}/dotfiles";
in
{
  programs.home-manager.enable = true;

  home = {
    username = "se7en";
    homeDirectory = "/home/se7en";
  };

  home.packages = with pkgs; [
  ];

  home.file = {
    # ".config/hypr/hyprland.conf".source = ../dotfiles/config/hypr/hyprland.conf;
  };

  home.stateVersion = "24.05";

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
    }))
  ];

  imports = [
    ./modules/fonts.nix
    ./modules/git.nix
    ./modules/fastfetch.nix
    ./modules/starship.nix
    ./modules/packages.nix
    # ./modules/desktop/hyprland

    (import ./modules/nvim.nix { inherit config lib pkgs configDir; })
    (import ./modules/yazi.nix { inherit config configDir; })
    # (import ./modules/hyprland.nix { inherit config configDir; })
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "wezterm";
    BROWSER = "brave";
  };

}
