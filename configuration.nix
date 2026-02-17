{ config, pkgs, inputs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ./packages.nix
    ./cosmic.nix 
  ];

  # --- Flake & System Core ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "chill"; # Matches your flake.nix 'chill' configuration
  networking.networkmanager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # --- Bootloader ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];

  # --- Localization (Carried over from your fresh install) ---
  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # --- Graphics & NVIDIA (Optimized for RTX 2060) ---
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true; 
    open = true; 
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # --- Desktop Management ---
  #services.displayManager.gdm.enable = true;
  #services.desktopManager.gnome.enable = true;

  # --- Sound (Carried over from your fresh install) ---
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # --- User Account ---
  users.users = {

    linc = {
      isNormalUser = true;
      description = "Lincoln";
      extraGroups = [ "networkmanager" "wheel" "video"  ];
      packages = with pkgs; [
        firefox
      ];
    };
    maren = { # Replace 'wife_name' with her actual username (lowercase, no spaces)
      isNormalUser = true;
      description = "Maren";
      extraGroups = [ "networkmanager" "video" ]; 
      # Notice I left out "wheel" - only add it if you want her to have sudo/admin rights
    };
  };

  # --- System Packages ---
  environment.systemPackages = with pkgs; [
    git
    vim
    curl
  ];

  system.stateVersion = "25.11"; 
}
