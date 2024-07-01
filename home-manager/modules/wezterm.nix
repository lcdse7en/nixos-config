# { ... }:
# { config, configDir, ... }:
# {
#   programs.wezterm = {
#     enable = true;
#   };
#
#   # xdg.configFile = {
#   #   wezterm = {
#   #     source = config.lib.file.mkOutOfStoreSymlink "${configDir}/wezterm";
#   #     recursive = true;
#   #   };
#   # };
# }

{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.hm-modules.terminal-emulator.wezterm;
in
{
  options.hm-modules.terminal-emulator.wezterm = {
    enable = mkEnableOption "wezterm";
  };

  config = mkIf cfg.enable
    {
      programs.wezterm = {
        enable = true;
        package = pkgs.wezterm;
        extraConfig = ''

        '';
      };
    };
}
