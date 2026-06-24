{ config, pkgs, inputs, lib, ... }:

{
  # --- Steam ---
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  nixpkgs.overlays = [
    (final: prev: {
      steam = prev.steam.override {
        extraArgs = "-pipewire";
      };
    })
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

  # --- Sunshine ---
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    package = pkgs.sunshine.override {
      cudaSupport = true;
      cudaPackages = pkgs.cudaPackages;
      boost = pkgs.boost187;
    };
  };

  users.users.linc.extraGroups = [ "video" "render" "input" ];

  # --- Security & Core Drivers ---

  hardware.graphics.enable32Bit = true;

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    lutris
    wineWow64Packages.wayland
    winetricks
    nvtopPackages.nvidia
  ];
}
