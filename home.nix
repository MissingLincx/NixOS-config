{ config, pkgs, inputs, ... }:

{
  imports = [
    ./terminal-configs.nix
    ./gaming-configs.nix
    ./wallpapers.nix
    ./conky-dash.nix
    ./conky-cheatsheet.nix
  ];

  home.username = "linc";
  home.homeDirectory = "/home/linc";
  home.stateVersion = "25.11";

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
  };

  home.packages = with pkgs; [
    brave
    vesktop
    obsidian
    (pkgs.python3.withPackages (ps: with ps; [
    pandas
    requests
    numpy
    ]))
  ];

  programs.home-manager.enable = true;
}
