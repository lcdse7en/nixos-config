{ pkgs, config, ... }:
{
  networking = {
    networkmanager.enable = false;
    firewall.allowedTCPPorts = [ 5173 1420 ];
    # hosts = {
    #   "185.199.109.133" = [ "raw.githubusercontent.com" ];
    #   "185.199.111.133" = [ "raw.githubusercontent.com" ];
    #   "185.199.110.133" = [ "raw.githubusercontent.com" ];
    #   "185.199.108.133" = [ "raw.githubusercontent.com" ];
    # };
    extraHosts = ''
      185.199.109.133 raw.githubusercontent.com
      185.199.111.133 raw.githubusercontent.com
      185.199.110.133 raw.githubusercontent.com
      185.199.108.133 raw.githubusercontent.com
    '';
  };

  environment = {
    shells = with pkgs; [ fish ];
    systemPackages = with pkgs; [
      nixpkgs-fmt
      lua-language-server
      stylua
      gofumpt
      gcc
      clang
      cmake
      meson
      ninja
      git
      wget
      bat
      p7zip
      atool
      unzip
      zip
      # rar
      ffmpeg
      sops

      # hyprland
      swww
      hyprpaper
    ];
  };

  security.sudo = {
    enable = true;
    extraConfig = ''
      se7en ALL = (ALL) NOPASSWD:ALL
    '';
  };

  system.stateVersion = "24.05";
}
