{
  description = "My system configuration";

  nixConfig = {
    # enable nixcomman and flakes for nixos-rebuild switch --flake
    experimental-features = [ "nix-command" "flakes" ];
    # replace official cache with mirrors located in China
    substituters = [
      "https://mirrors.cernet.edu.cn/nix-channels/store"
      "https://mirrors.bfsu.edu.cn/nix-channels/store"
      "https://cache.nixos.org/"
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wezterm.url = "github:notohh/wezterm?dir=nix&ref=nix-add-overlay";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
          inherit inputs system;
        };
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.se7en = ./home-manager/home.nix;
            };
          }
          ./home-manager/modules/fonts.nix
          ./home-manager/modules/ssh.nix
          ./home-manager/modules/fish.nix
        ];
      };
    };
}
