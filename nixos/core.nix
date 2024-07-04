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

  time.timeZone = "Asia/Shanghai";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ALL = "en_US.UTF-8";
      LANGUAGE = "en_US.UTF-8";
    };
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "C.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
      "zh_TW.UTF-8/UTF-8"
    ];
  };

  # security.rtkit.enable = true;
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "se7en" ];
    };
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
      dunst
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
