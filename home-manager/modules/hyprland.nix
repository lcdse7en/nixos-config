{ config, configDir, ... }:
{
  xdg.configFile = {
    hypr = {
      source = config.lib.file.mkOutOfStoreSymlink "${configDir}/hyprland";
      recursive = true;
    };
  };
}
