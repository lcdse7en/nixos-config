{ pkgs, ... }:
let
  unstable = with pkgs; [
    wget
    curl
    kitty
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
    fzf
    dunst
    mpv
    ncmpcpp
    smug
    nsxiv

    # hyprland
    waybar
    swww
    wlogout
  ];
in
{
  home = {
    # packages = stable ++ unstable;
    packages = unstable;
  };
}
