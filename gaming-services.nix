{ pkgs, ... }:

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
      stdenv = pkgs.cudaPackages.backendStdenv;
    };
    settings = {
      encoder = "nvenc";
      output_name = "DP-2";
    };
  };

  # --- Security & Core Drivers ---

  environment.systemPackages = with pkgs; [
    cudaPackages.cuda_nvcc
    linuxPackages.nvidia_x11
    steam
  ];
}
