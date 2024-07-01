{ pkgs, configDir, ... }:
{
  programs.hyprland.enaable = true;

  environment.systemPackages = with pkgs; [
    swww
  ];

  xdg.configFile = {
    hypr = {
      source = config.lib.file.mkOutOfStoreSymlink "${configDir}/hypr";
      recursive = true;
    };
  };

  #  extraPackages = with pkgs; [
  #   nodePackages.pyright
  #    rust-analyzer
  #  ];

}
