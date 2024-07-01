{ pkgs, ... }:
let
  unstable = with pkgs; [
    gcc
    lazygit
    ripgrep
    fd
    python3
    gh
    rustup
    xclip
    yarn
    ffmpeg
    zathura
    yazi
    nodejs
    nixpkgs-fmt
    brave
  ];
in
{
  home = {
    # packages = stable ++ unstable;
    packages = unstable;
  };
}
