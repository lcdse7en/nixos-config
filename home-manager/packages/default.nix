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
    nsxiv
    cava
    lua
    ffmpegthumbnailer
  ];
in {
  home = {
    # packages = stable ++ unstable;
    packages = unstable;
  };
}
