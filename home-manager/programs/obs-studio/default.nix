{ pkgs, inputs, ... }:
let
  obsThemes = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "obs";
    rev = "9a78d89";
    sha256 = "sha256-8DjAjpYsC9lEHe6gt/B7YCyfqVPaA5Qg1hbIMyyx/ho=";
  };
  customSystem = inputs.nixpkgs-system.legacyPackages.${pkgs.system};
in
{
  programs.obs-studio = {
    enable = true;
    plugins = with customSystem.obs-studio-plugins; [
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vkcapture
      wlrobs
    ];
  };
  home.file = {
    ".config/obs-studio/themes".source = "${obsThemes}/themes";
  };
}
