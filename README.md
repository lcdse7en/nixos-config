# nixos-config

## Delete nixos old version
```shell
sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +5
sudo nix-collect-garbage --delete-old
```
