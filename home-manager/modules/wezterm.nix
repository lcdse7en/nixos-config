{ ... }:
# { config, configDir, ... }:
{
  programs.wezterm = {
    enable = true;
  };

  # xdg.configFile = {
  #   wezterm = {
  #     source = config.lib.file.mkOutOfStoreSymlink "${configDir}/wezterm";
  #     recursive = true;
  #   };
  # };
}
