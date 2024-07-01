{ config, configDir, ... }:
{
  xdg.configFile = {
    hyprland = {
      source = config.lib.file.mkOutOfStoreSymlink "${configDir}/hypr";
      recursive = true;
    };
  };
}
