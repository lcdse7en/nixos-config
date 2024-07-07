{ ... }: {
  services.mako = {
    enable = true;
    font = "Hack Nerd Font Mono 10";
    defaultTimeout = 5000;
    ignoreTimeout = true;
    border-radius = 8;
    text-color = "#2e3440ff";
    background-color = "#eceff4f4";
    border-color = "#d8dee9ff";
    border-size = 0;
    margin = [ 12 12 6 ];
    padding = [ 12 12 12 12 ];
    max-visible = 3;
  };
}
