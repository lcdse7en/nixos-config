{ pkgs, config, user, ... }: {
  networking = {
    hostName = "nixos";
    # networkmanager.enable = true;
    firewall.enable = false;
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

  # sops = {
  #   secrets.SSH_PVKEY = {
  #     mode = "0600";
  #     owner = "${user}";
  #     path = "/home/" + "${user}" + "/.ssh/id_rsa";
  #   };
  #   secrets.GPG_PVKEY = {
  #     mode = "0600";
  #     owner = "${user}";
  #     path = "/home/" + "${user}" + "/.gnupg/GPG_PVKEY";
  #   };
  # };

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

  users = {
    users = {
      se7en = {
        shell = pkgs.fish;
        isNormalUser = true;
        home = "/home/se7en";
        extraGroups = [ "wheel" "networkmanager" ];
        packages = with pkgs; [ vim git ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDsT6GLG7sY8YKX7JM+jqS3EAti3YMzwHKWViveqkZvu"
        ];
      };
    };
  };

  programs.fish.enable = true;

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime

      # Chinese
      fcitx5-chinese-addons
      fcitx5-table-extra
      fcitx5-pinyin-moegirl
      fcitx5-pinyin-zhwiki

      # Japanese
      fcitx5-mozc
    ];
    fcitx5.ignoreUserConfig = true;
    fcitx5.settings.globalOptions = {
      Hotkey = {
        # Enumerate when press trigger key repeatedly
        EnumerateWithTriggerKeys = "True";
        # Skip first input method while enumerating
        EnumerateSkipFirst = "False";
      };
      "Hotkey/EnumerateForwardKeys" = { "0" = "Control+space"; };
      "Hotkey/EnumerateBackwardKeys" = { "0" = "Control+Shift+space"; };
      "Hotkey/PrevPage" = { "0" = "Up"; };
      "Hotkey/NextPage" = { "0" = "Down"; };
      "Hotkey/PrevCandidate" = { "0" = "Shift+Tab"; };
      "Hotkey/NextCandidate" = { "0" = "Tab"; };
      Behavior = {
        # Active By Default
        ActiveByDefault = "False";
        # Share Input State
        ShareInputState = "No";
        # Show preedit in application
        PreeditEnabledByDefault = "True";
        # Show Input Method Information when switch input method
        ShowInputMethodInformation = "True";
        # Show Input Method Information when changing focus
        showInputMethodInformationWhenFocusIn = "False";
        # Show compact input method information
        CompactInputMethodInformation = "True";
        # Show first input method information
        ShowFirstInputMethodInformation = "True";
        # Default page size
        DefaultPageSize = "5";
        # Override Xkb Option
        OverrideXkbOption = "False";
        # Preload input method to be used by default
        PreloadInputMethod = "True";
      };
    };
    fcitx5.settings.inputMethod = {
      "Groups/0" = {
        "Name" = "Default";
        "Default Layout" = "us";
        "DefaultIM" = "mozc";
      };
      "Groups/0/Items/0" = {
        "Name" = "keyboard-us";
        "Layout" = null;
      };
      "Groups/0/Items/1" = {
        "Name" = "mozc";
        "Layout" = null;
      };
      "GroupOrder" = { "0" = "Default"; };
    };
  };

  services = {
    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "se7en" ];
      };
    };
    # Enable CUPS to print documents.
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };

  # Enable sound with pipewire.
  # sound.enable = true;
  # hardware.pulseaudio.enable = false;

  # security.rtkit.enable = true;

  environment = {
    shells = with pkgs; [ fish ];
    systemPackages = with pkgs; [
      gofumpt
      gcc
      clang
      cmake
      meson
      ninja
      git
      wget
      p7zip
      atool
      unzip
      zip
      # rar
      ffmpeg
      sops

      # hyprland
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
