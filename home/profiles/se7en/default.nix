{ lib, config, ... }:
{
  imports = [
    ../../../home-manager/home.nix
  ] ++ [
  ];

  wayland.windowManager.hyprland = lib.mkIf config.wayland.windowManager.hyprland.enable { };

  wayland.windowManager.sway = lib.mkIf config.wayland.windowManager.sway.enable { extraOptions = [ "--unsupported-gpu" ]; };

  # Autostart QEMU/KVM in the first initialization of NixOS
  # realted link: https://nixos.wiki/wiki/Virt-manager
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
