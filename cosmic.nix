{ config, pkgs, ... }:

{
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  environment.cosmic.excludePackages = with pkgs; [

  ];

  # NVIDIA Fix from the Wiki (prevents weird "phantom" monitor issues)
  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];

  services.system76-scheduler.enable = true;

  # System76 recommends the 'open' kernels for COSMIC
  hardware.nvidia.open = true;
}
