{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    # nerdfonts
    jetbrains-mono
    source-code-pro
    font-awesome
    (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "DroidSansMono" ]; })
  ];
  fonts.fontDir.enable = true;
  console = {
    enable = true;
    packages = with pkgs; [
      # nerdfonts
      (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "DroidSansMono" ]; })
    ];
    #font = "/run/current-system/sw/share/X11/fonts/JetBrainsMonoNerdFont-Regular.ttf";
  };
}
