{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    initExtra = ''
      eval "$(starship init bash)"
    '';
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config/.#chill";
      wlab = "export WLAB_ACTIVE='󰖳 AD-LAB' && sudo nixos-rebuild test --specialisation lab-mode --flake .#chill";
      unlab = "unset WLAB_ACTIVE && sudo nixos-rebuild test --flake .#chill";
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
      format = "$env_var$all";
      env_var.WLAB_ACTIVE = {
	style = "bold cyan";
	format = "[$value]($style) ";
      };
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
