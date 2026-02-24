{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config/.#chill";
    };
  };

  programs.git = {
    enable = true;
    userName = "MissingLincx";
    userEmail = "lecluff@gmail.com";
  };

  home.packages = with pkgs; [
    htop
    nvtopPackages.nvidia
    pciutils
    tmux
    helix
    tldr
  ];
}
