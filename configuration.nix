{ config, pkgs, inputs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ./packages.nix
    ./cosmic.nix 
  ];

  # --- Flake & System Core ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "chill";

  # --- Enable WoL ---
  networking.interfaces.enp34s0.wakeOnLan.enable = true;
  networking.firewall = {
   # 9 for Wol, 41641 for Tailscale
    allowedUDPPorts = [ 9 41641 ];
  };

  # --- Enable Tailscale ---
  services.tailscale.enable = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  nixpkgs.config.allowUnfree = true;

  # --- Bootloader ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [ 
    "nvidia-drm.modeset=1" 
    "acpi_enforce_resources=lax" 
  ];

  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ];

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

  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = [ "linc" ];
      PermitRootLogin = "no";
    };
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
    };
  };

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd"; #B450 Tomahawk (AM4)
  };

  services.udev.extraRules = ''
    # Input/Controller Rule
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';  

  environment.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config#chill";
  };

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
