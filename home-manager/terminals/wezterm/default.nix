{ pkgs, ... }:
let
  version = "d6809533215e273ca23e52614c886929ad702715";
in
{
  nixpkgs.overlays = [
    (final: prev: {
      wezterm = prev.wezterm.overrideAttrs (old: {
        inherit version;
        src = prev.fetchFromGitHub {
          owner = "wez";
          repo = "wezterm";
          rev = version;
          fetchSubmodules = true;
          hash = "sha256-ZnmBKBiaqKGKKrItTrPf/LGJvtu7BBvu1+QAk5PBi6g=";
        };

        cargoHash = "";
      });
    })
  ];
  home.packages = [ pkgs.wezterm ];
}
