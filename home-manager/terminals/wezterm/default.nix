# { pkgs, ... }:
# let
#   version = "d6809533215e273ca23e52614c886929ad702715";
# in
# {
#   nixpkgs.overlays = [
#     (final: prev: {
#       wezterm = prev.wezterm.overrideAttrs (old: {
#         inherit version;
#         src = prev.fetchFromGitHub {
#           owner = "wez";
#           repo = "wezterm";
#           rev = version;
#           fetchSubmodules = true;
#           hash = "sha256-ZnmBKBiaqKGKKrItTrPf/LGJvtu7BBvu1+QAk5PBi6g=";
#         };
#
#         cargoHash = "";
#       });
#     })
#   ];
#   home.packages = [ pkgs.wezterm ];
# }

{ config
, lib
, pkgs
, ...
}:
with lib; let
  cfg = config.modules.terminals.wezterm;
in
{
  options.modules.terminals.wezterm = {
    enable = mkEnableOption "enable wezterm terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      package = pkgs.wezterm-nightly;
      extraConfig = builtins.readFile ./config.lua;
    };
  };
}
