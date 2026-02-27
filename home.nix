{ config, pkgs, inputs, ... }:

{
  imports = [
    ./terminal-configs.nix
    ./gaming-configs.nix
    ./wallpapers.nix
  ];

  home.username = "linc";
  home.homeDirectory = "/home/linc";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    brave
    vesktop
    obsidian
  ];

  programs.home-manager.enable = true;
}
