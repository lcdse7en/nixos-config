{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
  ];

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;
  programs.sway.enable = true;
  programs.wrapperFeatures.gtk = true;
  programs.zsh.loginShellInit = ''
    if [[ "$(tty)" == /dev/tty1 ]]; then
      exec sway &> /dev/null
    fi
  '';

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    wlr.enable = true;
  };
}
