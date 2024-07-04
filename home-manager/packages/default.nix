{ pkgs, ... }:
let
  unstable = with pkgs; [
    wget
    curl
    gcc
    ripgrep
    fd
    python3
    gh
    xclip
    yarn
    ffmpeg
    nodejs
    # nixpkgs-fmt
    brave
    fzf
    # dunst
    ncmpcpp
    smug
    nsxiv
    lua
  ];
in
{
  home = {
    # packages = stable ++ unstable;
    packages = unstable;
  };
}
