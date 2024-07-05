{ user, ... }:
{
  environment = {
    users.${user} = {
      directories = [
        "Blog"
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        ".cache"
        ".npm-global"
        ".cargo"
        ".local"
      ];
    };
  };
}
