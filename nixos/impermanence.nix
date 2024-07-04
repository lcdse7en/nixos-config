{ user, ... }:
{
  environment = {
      users.users.${user} = {
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
