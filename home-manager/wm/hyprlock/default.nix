{ ... }: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      input-field = [{
        # size = "200, 50";
        # position = "0, -80";
        # font_color = "rgb(198,208,245)";
        # inner_color = "rgb(30,30,46)";
        # outer_color = "rgb(203,166,247)";
        placeholder_text = "whats da passwowd >_<";
      }];

      background = [{
        path = "~/airplane.png";
        blur_passes = 3;
        blur_size = 3;
        noise = 1.17e-2;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      }];

      label = [
        {
          text_align = "right";
          halign = "center";
          valign = "center";
          text = "Hi there, $USER";
          font_size = 50;
          font_family = "Sans";
          position = "0, 80";
        }
        {
          text_align = "right";
          halign = "center";
          valign = "center";
          text = "$TIME";
          font_size = 150;
          font_family = "Sans";
          position = "0, 300";
        }
      ];
    };
  };
}
