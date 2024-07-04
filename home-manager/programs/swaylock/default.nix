{ pkgs, ... }:
{
  # programs = {
  #   swaylock.enable = true;
  # };

  home = {
    packages = with pkgs; [
      swaylock
    ];
  };
  home.file = {
    ".config/swaylock/config".source = ./config;
  };
}
