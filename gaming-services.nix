{ config, pkgs, inputs, lib, ... }:

{
  # --- Steam ---
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
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

  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
  ];
}
