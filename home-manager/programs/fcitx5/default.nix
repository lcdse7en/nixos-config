{ config, pkgs, inputs, ... }: {
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      rime-data
      fcitx5-rime
      fcitx5-chinese-addons
      fcitx5-table-extra
      fcitx5-pinyin-moegirl
      fcitx5-pinyin-zhwiki
      fcitx5-mozc
    ];
  };
  home.file = {
    ".config/fcitx5/conf/classicui.conf".source = ./classicui.conf;
    ".local/share/fcitx5/themes/Nord/theme.conf".text = import ./theme.nix;
  };
}
