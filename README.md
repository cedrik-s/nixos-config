# nixos-config
My personal NixOS configuration files for my WSL NixOS machines.

## Usage
I remove the default configuration in /etc/nixos and instead link the config from this repo, like suggested [here](https://nixos-and-flakes.thiscute.world/nixos-with-flakes/other-useful-tips#managing-the-configuration-with-git)

`sudo ln -s ~/nixos-config/ /etc/nixos`

To apply the config, just run
`sudo nixos-rebuild switch`
