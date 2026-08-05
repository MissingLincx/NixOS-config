{ pkgs, ... }:

{
  wsl = {
    enable = true;
    defaultUser = "linc";
    nativeSystemd = true;
  };

  networking.hostName = "chillwsl";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    wget
  ];

  system.stateVersion = "25.11";
}
