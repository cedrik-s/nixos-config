# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
    <home-manager/nixos>
  ];

  wsl.enable = true;
  wsl.defaultUser = "cesch";
  wsl.docker-desktop.enable = true;
  wsl.startMenuLaunchers = true;

  # Configuration required to use vscode remote in wsl,
  # See https://nix-community.github.io/NixOS-WSL/how-to/vscode.html
  environment.systemPackages = [
    pkgs.wget
    pkgs.nodejs_20
  ];
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs; # only for NixOS 24.05
  };

  programs.zsh.enable = true;  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # User config for cesch using home manager:
  home-manager.users.cesch = { pkgs, ...}: {
    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "24.05";

    programs.git = {
      enable = true;
      userName = "Cedrik Schmiedinghoff";
      userEmail = "cedrik.schmiedinghoff@gmail.com";
      signing.signByDefault = true;
      signing.key = "~/.ssh/id_ed25519";
    };

    programs.thefuck = {
      enable = true;
    };

    programs.zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };

    programs.fzf.enable = true;

    programs.bat.enable = true;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        rcat = "cat";
        cat = "bat";
      };

      oh-my-zsh = {
        enable = true;
        plugins = ["git" "ssh-agent" "zoxide" "thefuck"];
        theme = "jonathan";
        extraConfig = ''
          zstyle :omz:plugins:ssh-agent lazy yes
          zstyle :omz:plugins:ssh-agent lifetime 4h
          zstyle :omz:plugins:ssh-agent quiet yes
          zstyle :omz:plugins:ssh-agent identities ~/.ssh/id_ed25519
          eval $(thefuck --alias)
        '';
      };
    };
  };
  users.defaultUserShell = pkgs.zsh;
}
