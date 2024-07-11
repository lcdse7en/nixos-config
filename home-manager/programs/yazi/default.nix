{ pkgs, config, inputs, ... }: {
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.system}.default;
    enableFishIntegration = true;
  };

  home.file = {
    ".config/yazi/yazi.toml".source = ./yazi.toml;
    ".config/yazi/keymap.toml".source = ./keymap.toml;
    ".config/yazi/theme.toml".source = ./theme.toml;
    ".config/yazi/plugins/smart-enter.yazi".source = ./plugins/smart-enter.yazi;
    ".config/yazi/plugins/keyjump.yazi".source = ./plugins/keyjump.yazi;
    ".config/yazi/plugins/arrow.yazi".source = ./plugins/arrow.yazi;
    ".config/yazi/flavors/everforest-dark.yazi".source =
      ./flavors/everforest-dark.yazi;
    ".config/yazi/ui.lua".text = "${builtins.readFile ./ui.lua}";

  };

}
