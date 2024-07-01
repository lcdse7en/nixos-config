{ config, configDir, ... }:
{
  programs.yazi = {
    enable = true;
  };

  xdg.configFile = {
    yazi = {
      source = config.lib.file.mkOutOfStoreSymlink "${configDir}/yazi";
      recursive = true;
    };
  };
}
