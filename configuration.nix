{ config, pkgs, inputs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ./gaming-services.nix
    ./cosmic.nix 
    ./windows-lab.nix
  ];

  # --- Flake & System Core ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "chill";

  # --- Bootloader & Kernel ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "nvidia-drm.modeset=1" "nvidia_drm.fbdev=1" "acpi_enforce_resources=lax" ];
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" "uinput" ];

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
    nvidiaSettings = true;
  };

  # --- Sound  ---
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # --- Networking ---
  networking.interfaces.enp34s0.wakeOnLan.enable = true;
  networking.firewall.allowedUDPPorts = [ 9 41641 ];
  services.tailscale.enable = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "linc" ];
      PermitRootLogin = "no";
    };
  };

  # --- Localization (Carried over from your fresh install) ---
  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";

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
    maren = {
      isNormalUser = true;
      description = "Maren";
      extraGroups = [ "networkmanager" "video" ]; 
      packages = with pkgs; [
        google-chrome
      ];
    };
  };

  # --- Fonts ---
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.droid-sans-mono
  ];

  # --- Misc ---

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd"; #B450 Tomahawk (AM4)
  };

  services.udev.extraRules = ''
    # Input/Controller Rule
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';  

  # --- System Packages ---
  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    pkgs.ethtool
    wakeonlan
  ];

  system.stateVersion = "25.11"; 
}
