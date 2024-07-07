{
  description = "My system configuration";

  nixConfig = {
    # enable nixcomman and flakes for nixos-rebuild switch --flake
    experimental-features =
      [ "nix-command" "flakes" "auto-allocate-uids" "cgroups" ];
    # replace official cache with mirrors located in China
    substituters = [
      "https://mirrors.cernet.edu.cn/nix-channels/store"
      "https://mirrors.bfsu.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      # "https://ruixi-rebirth.cachix.org"
      "https://cache.nixos.org"
      "https://nixpkgs-wayland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "ruixi-rebirth.cachix.org-1:sWs3V+BlPi67MpNmP8K4zlA3jhPCAvsnLKi4uXsiLI4="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
    trusted-users = [ "root" "se7en" "@wheel" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    ###########################################################
    #  Hyprland                                               #
    ###########################################################
    # url = "github:hyprwm/Hyprland?ref=v0.40.0";
    # url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    hyprland = {
      url = "github:hyprwm/Hyprland?ref=v0.41.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlock = {
      url = "github:hyprwm/Hyprlock";
      # NOTE: required to prevent red screen on lock
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpaper.url = "github:hyprwm/hyprpaper";
    hyprcursor = { url = "github:hyprwm/hyprcursor"; };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hycov = {
      url =
        "github:DreamMaoMao/hycov?rev=7f4aa3c1111938e88ca8d1774270fd67cb399399";
      inputs.hyprland.follows = "hyprland";
    };
    hypreasymotion = {
      url =
        "github:DreamMaoMao/hyprland-easymotion?rev=54a8fb0e5652b79fb4f8399506696f1c32b59aaa";
      inputs.hyprland.follows = "hyprland";
    };
    hyprpicker.url = "github:hyprwm/hyprpicker";
    hypr-contrib.url = "github:hyprwm/contrib";
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    waybar = {
      url = "github:Alexays/Waybar";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixd.url = "github:nix-community/nixd";

    rust-overlay.url = "github:oxalica/rust-overlay";

    impermanence.url = "github:nix-community/impermanence";

    # wezterm.url = "github:notohh/wezterm?dir=nix&ref=nix-add-overlay";
    wezterm = { url = "github:wez/wezterm?dir=nix"; };

    # Snowfall Lib
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-system.url = "github:eljamm/nixpkgs/system";
  };

  outputs =
    inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, hyprland, ... }:
    let
      user = "se7en";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;

      # selfPkgs = import ./pkgs;
    in {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            pkgs-stable = import nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };
            inherit inputs system user;
          };
          modules = [
            ./nixos/configuration.nix
            inputs.stylix.nixosModules.stylix
            # hyprland.nixosModules.default
            { programs.hyprland.enable = true; }
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                users.se7en = import ./home-manager/home.nix;
                extraSpecialArgs = { inherit inputs user; };
              };
            }
          ];
        };
      };
    };

}
