{ pkgs, ... }:
let
  flakePath = "~/nixos-config";
  abbr = {
    "vim" = "nvim";
    "yy" = "yazi";
    "c" = "clear";
    "e" = "exit";
  };
  aliases = {
    "rebuild" = "sudo nixos-rebuild switch --flake ${flakePath}";
    "s" = "fastfetch";
    # "ls" = "eza --icons --no-permissions --no-user --no-time --group-directories-first";
  };
in
{
  programs.fish = {
    enable = true;
    shellAbbrs = abbr;
    shellAliases = aliases;
    interactiveShellInit = ''
      startship init fish | source
    '';
    shellInit = ''
      # set -g fish_greeting
      # colors

    '';
  };
}
