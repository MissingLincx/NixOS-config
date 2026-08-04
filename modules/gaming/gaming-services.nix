{ config, pkgs, inputs, lib, ... }:

{

  imports = [
    ./steam.nix
    ./sunshine.nix
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-cosmic
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [ "cosmic" "gtk" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    lutris
    wineWow64Packages.wayland
    winetricks
    nvtopPackages.nvidia
  ];
}
