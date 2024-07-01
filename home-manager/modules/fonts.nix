{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-font-patcher
    # (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
}

# { pkgs, ... }:
# {
#   fonts = {
#     enableDefaultPackages = false;
#     fontDir.enable = true;
#     packages = with pkgs; [
#       corefonts
#       nerdfonts
#       noto-fonts
#       noto-fonts-cjk
#       twitter-color-emoji
#     ];
#
#     fontconfig = {
#       enable = true;
#       allowBitmaps = true;
#       defaultFonts = {
#         monospace = [ "JetBrainsMono NF Medium" "Twitter Color Emoji" ];
#         serif = [ "Noto Serif" "Twitter Color Emoji" ];
#         sansSerif = [ "Noto Sans" "Twitter Color Emoji" ];
#         emoji = [ "Twitter Color Emoji" ];
#       };
#       hinting = {
#         enable = true;
#         style = "full";
#       };
#     };
#   };
# }
