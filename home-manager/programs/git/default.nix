{
  programs = {
    git = {
      enable = true;
      userName = "lcdse7en";
      userEmail = "2353442022@qq.com";
      # signing = {
       #  key = "D6FA49B594337867";
        # signByDefault = true;
      # };
      extraConfig = {
        url = {
          "ssh://git@github.com:lcdse7en" = {
            insteadOf = "https://github.com/lcdse7en/";
          };
        };
      };
    };
  };
}
