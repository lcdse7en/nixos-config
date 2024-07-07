{ ... }: {
  services.mako = {
    enable = true;
    font = "Hack Nerd Font Mono 10";
    defaultTimeout = 5000;
    ignoreTimeout = true;
    width = 300;
    height = 100;
    icons = true;
    margin = "10";
    padding = "8";
    borderSize = 3;
    borderRadius = 5;
  };
}
