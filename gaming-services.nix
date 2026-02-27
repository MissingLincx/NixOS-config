{ config, pkgs, inputs, ... }:

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

    package = inputs.nixpkgs-sunshine.legacyPackages.${pkgs.system}.sunshine;
#    package = pkgs.sunshine.override {
#      cudaSupport = true;
#      stdenv = pkgs.cudaPackages.backendStdenv;
#    };
  };

  users.users.linc.extraGroups = [ "video" "render" "input" ];

  # --- Security & Core Drivers ---

  environment.systemPackages = with pkgs; [
    cudaPackages.cuda_nvcc
    linuxPackages.nvidia_x11
    steam
  ];
}
