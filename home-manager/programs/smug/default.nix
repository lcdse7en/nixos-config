{ pkgs, ... }:

{
  home = { packages = with pkgs; [ smug ]; };
  programs = { smug.enable = true; };

  home.file.".config/smug/accounting.yml".source = ./accounting.yml;
}
