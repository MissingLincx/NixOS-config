{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    initExtra = ''
      eval "$(starship init bash)"
    '';
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config/.#chill";
      wlab = "sudo /run/current-system/specialisation/lab-mode/bin/switch-to-configuration test";
      unlab = "sudo /run/current-system/bin/switch-to-configuration test";
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
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      nix_shell = {
        symbol = " ";
        format = "via [$symbol\\($state\\)]($style) ";
        style = "bold blue";
      };
    };
  };

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
