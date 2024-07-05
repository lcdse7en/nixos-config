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

    packages = with pkgs;
      [
      ];
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

}
