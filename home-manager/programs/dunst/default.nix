{
  programs.dunst.enable = true;

  home.file.".config/dunst/dunstrc".text = ''
    [global]
    format = "<b>%s</b>\n%b"

    icon_path = "~/.local/share/icons/"
    icon_theme = WhiteSur
    max_icon_size = 64
    enable_recursive_icon_lookup = true

    origin = top-right
    offset = 22x22
    frame_width = 2
    frame_color = "#b4befe"
    separator_color= frame
    font = "Fira Code 10"
    corner_radius = 7
    background = "#11111B"
    foreground = "#CDD6F4"
  '';
}
