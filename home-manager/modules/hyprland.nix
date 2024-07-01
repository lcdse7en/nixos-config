{ config, configDir, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;
  };

  # xdg.configFile = {
  #   nvim = {
  #     source = config.lib.file.mkOutOfStoreSymlink "${configDir}/hypr";
  #     recursive = true;
  #   };
  # };

 #  extraPackages = with pkgs; [
 #   nodePackages.pyright
 #    rust-analyzer
 #  ];

}
