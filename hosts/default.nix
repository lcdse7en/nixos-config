{ inputs
, sharedModules
, homeImports
, user
, ...
}: {
  flake.nixosConfigurations =
    let
      user = "se7en";
      inherit (inputs.nixpkgs.lib) nixosSystem;
    in
    {
      se7en = nixosSystem
        {
          specialArgs = { inherit user; };
          modules =
            [
              ./se7en
              ../modules/configuration.nix
              ../modules/core.nix
              ../modules/nix.nix
              ../modules/desktop.nix
              ../modules/fonts.nix
              ../modules/impermanence.nix
              {
                home-manager =
                  {
                    extraSpecialArgs = { inherit inputs user; };
                    users.${user}.imports = homeImports."${user}@se7en";
                    useUserPackages = true;
                    useGlobalPkgs = true;
                    users.se7en = ../home-manager/home.nix;
                  };
              }
            ] ++ sharedModules;
        };
    };
}
