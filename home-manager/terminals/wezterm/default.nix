{ pkgs, ... }:
with builtins;
let
  weztermConfig = readFile (./wezterm.lua);
in

{
  home = {
    packages = with pkgs; [ maple-mono ];
  };
  programs.wezterm = {
    enable = true;
    extraConfig = weztermConfig;
  };
}
