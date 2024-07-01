{ pkgs, config, ...}:
let
  email = "2353442022@qq.com";
  name = "lcdse7en";
in
{
  programs.git = {
    enable = true;
    userEmail = email;
    userName = name;
    extraConfig = {
      color.ui = "true";
      core.editor = "nvim";
      init.defaultBranch = "main";
    };
  };
}
