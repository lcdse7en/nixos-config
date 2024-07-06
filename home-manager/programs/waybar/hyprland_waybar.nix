{ ... }: {
  programs.waybar = {
    enable = true;
    # catppuccin.enable = false;
    style = ./style.css;
    settings = {
      mainBar = {
        margin-top = 10;
        margin-left = 7;
        width = 1900;
        height = 22;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "network" "memory" "battery" "pulseaudio" ];
        clock = {
          format = " {:%r  %d/%m/%y}";
          interval = 1;
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
      };
    };
  };
}
