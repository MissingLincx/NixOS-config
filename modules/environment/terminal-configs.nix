{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
   shellAliases = {
      rebuild-chilltop = "sudo nixos-rebuild switch --flake ~/nixos-config/.#chilltop";
      rebuild-chill = "sudo nixos-rebuild switch --flake ~/nixos-config/.#chill";
      wlab = "sudo nixos-rebuild test --specialisation lab-mode --flake .#chill && newgrp libvirtd";
      unlab = "sudo nixos-rebuild test --flake .#chill";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "MissingLincx";
        email = "lecluff@gmail.com";
      };
    };
  };

  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;
  
      format = ''$directory$git_branch$git_status$character'';

      env_var.WLAB_ACTIVE = {
        variable = "WLAB_ACTIVE"; 
        style = "bold cyan";
        format = "[$value]($style)"; 
        disabled = false;
      };
    };
  };

  home.packages = with pkgs; [
    htop
    nvtopPackages.nvidia
    pciutils
    tmux
    tldr
    fzf
    eza
    zoxide
    nmap
    glow
  ];
}
