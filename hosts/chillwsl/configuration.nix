{ pkgs, ... }:

{
  wsl = {
    enable = true;
    defaultUser = "linc";
  };

  networking.hostName = "chillwsl";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    wget
  ];

  system.stateVersion = "25.11";
}
