{ pkgs, config, ... }:
let
  flakePath = "~/nixos-config";
  abbr = {
    "vim" = "nvim";
    "yy" = "yazi";
    "c" = "clear";
    "e" = "exit";
    "s" = "fastfetch";
    "top" = "btop";
    "gc" = "git clone";
  };
  aliases = {
    "rebuild" = "sudo nixos-rebuild switch --flake ${flakePath/.#nixos}";
    cat = "bat";
    gogit = "cd ~/git";
    "!!" = "eval \\$history[1]";
    la = "ls -a";
    ll = "ls -l --git";
    l = "ls -laH";
    lg = "ls -lG";
    oplocal = "./js/oph/dist/mac-arm64/1Password.app/Contents/MacOS/1Password";
    # inspect $PATH
    pinspect = ''echo "$PATH" | tr ":" "\n"'';
  };
in {
  programs.fish = {
    enable = true;
    loginShellInit = if config.wayland.windowManager.hyprland.enable then ''
      set TTY1 (tty)
      [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
    '' else if config.wayland.windowManager.sway.enable then ''
      set TTY1 (tty)
      [ "$TTY1" = "/dev/tty1" ] && exec sway
    '' else
      "";
    interactiveShellInit = ''
      set fish_greeting ""
      set fish_key_bindings  fish_vi_key_bindings
    '';

    shellAbbrs = abbr;
    shellAliases = aliases;

    functions = {
      f = ''
        FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git' FZF_DEFAULT_OPTS="--color=bg+:#4C566A,bg:#424A5B,spinner:#F8BD96,hl:#F28FAD  --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96  --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD --preview 'bat --style=numbers --color=always --line-range :500 {}'" fzf --height 60% --layout reverse --info inline --border --color 'border:#b48ead'
      '';
    };
  };
  home.file = {
    ".config/fish/conf.d/nord.fish".text = import ./nord_theme.nix;
    ".config/fish/functions/fish_prompt.fish".source =
      ./functions/fish_prompt.fish;
    ".config/fish/functions/xdg-get.fish".text = import ./functions/xdg-get.nix;
    ".config/fish/functions/xdg-set.fish".text = import ./functions/xdg-set.nix;
    ".config/fish/functions/owf.fish".text = import ./functions/owf.nix;
  };
}
