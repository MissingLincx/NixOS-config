{ pkgs, ... }:

{
  # 1. Steam configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # 2. Sunshine Service (The Host)
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
    };
    applications = {
      apps = [
        {
          name = "Steam Big Picture DeckUI";
          cmd = "/run/current-system/sw/bin/steam -tenfoot -steamos";
        }
        {
          name = "Desktop";
          cmd = "xterm"; 
        }
      ];
    };
  };

  # 3. System Packages (Added missing bracket here)
  environment.systemPackages = with pkgs; [
    vesktop
    git
    htop
    nvtopPackages.nvidia # Added this so you can monitor your GPU!
    cudaPackages.cuda_nvcc
    linuxPackages.nvidia_x11
    steam
  ];

  # 4. Global Hardware Settings (Must be at the top level, not inside Sunshine)
  hardware.nvidia.nvidiaSettings = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Good for Steam
  };
}
