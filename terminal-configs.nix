{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config/.#chill";
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
/*
  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;
  
      # 1. We manually define the order. 
      # This puts the Windows icon BEFORE the directory (nixos-config)
      format = ''$env_var$directory$git_branch$git_status$nix_shell$character'';

      # 2. Add an explicit 'variable' name to the module
      env_var.WLAB_ACTIVE = {
        variable = "WLAB_ACTIVE"; 
        style = "bold cyan";
        format = "[$value]($style)"; # Removed the trailing space to keep it tight
        disabled = false;            # Force it to stay active
      };
    };
  };
*/
  home.packages = with pkgs; [
    htop
    nvtopPackages.nvidia
    pciutils
    tmux
    helix
    tldr
    fzf
    eza
    zoxide
  ];
}
