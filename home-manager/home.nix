{ inputs
, config
, pkgs
, lib
, isLinux
, isDarwin
, ...
}:
let
  configDir = "${config.home.homeDirectory}/dotfiles";
  discordIcon = pkgs.fetchurl {
    url =
      "https://static-00.iconduck.com/assets.00/apps-discord-icon-2048x2048-hkrl0hxr.png";
    hash = "sha256-e3AT1zekZJEYRm+S9wwMuJb+G2/zSOZSKJztHGKnOiY=";
  };
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
    homeDirectory = if isLinux then "/home/se7en" else "/Users/se7en";
    stateVersion = "24.05";

    packages = with pkgs;
      [
        # obsidian # re-enable when the nixpkgs package is fixed
        mdbook
        gnumake
      ] ++ lib.lists.optionals isDarwin [
        # put macOS specific packages here
        # xcodes
      ] ++ lib.lists.optionals isLinux [
        # put Linux specific packages here
        # vesktop discord client, I don't like
        # vesktop's icon, so override it
        # (vesktop.overrideAttrs (oldAttrs: {
        #   desktopItems = [
        #     (makeDesktopItem {
        #       name = "vesktop";
        #       desktopName = "Vesktop";
        #       exec = "vesktop %U";
        #       icon = "discord";
        #       startupWMClass = "Vesktop";
        #       genericName = "Internet Messenger";
        #       keywords = [ "discord" "vencord" "electron" "chat" ];
        #       categories = [ "Network" "InstantMessaging" "Chat" ];
        #     })
        #   ];
        # }))
        signal-desktop
        qbittorrent
        vlc
        cura
        r2modman
      ];
    file."${config.home.homeDirectory}/.xprofile".text = ''
      export XDG_DATA_DIRS="$XDG_DATA_DIRS:/home/se7en/.nix-profile/share"
    '';
  };

  home.file = {
    # ".config/hypr/hyprland.conf".source = ../dotfiles/config/hypr/hyprland.conf;
  };

  imports = [
    ./modules/git.nix
    ./modules/fastfetch.nix
    ./modules/starship.nix
    ./modules/packages.nix
    ./modules/wezterm.nix

    (import ./modules/nvim.nix { inherit config lib pkgs configDir; })
    (import ./modules/yazi.nix { inherit config configDir; })
    (import ./modules/hyprland.nix { inherit config configDir; })
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "wezterm";
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
