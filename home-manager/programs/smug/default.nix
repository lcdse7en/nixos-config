{ pkgs, ... }:

{
  home = { packages = with pkgs; [ smug ]; };

  home.file.".config/smug/accounting.yml".source = ./accounting.yml;
}
