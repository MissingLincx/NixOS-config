{ config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ../../modules/gaming/gaming-services.nix
    ../../modules/gaming/gaming-configs.nix
    ../../modules/desktop/cosmic.nix 
    ../../windows-lab.nix
    ../../modules/hardware/nvidia.nix
    ../../modules/services/tailscale.nix
    ../../modules/services/ssh.nix
    ../../modules/hardware/rgb.nix
    ../../modules/llm/ollama.nix
  ];

  # --- Flake & System Core ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "chill";

  # --- Bootloader & Kernel ---
  boot.loader.systemd-boot.enable = false;

  boot.loader.limine.enable = true;
  boot.loader.limine.secureBoot.enable = true;
  boot.loader.timeout = 5;
  boot.loader.limine.extraEntries = ''
    /Windows 11
      protocol: efi
      path: uuid(f75e032e-b8f2-4987-b99d-0be6006843a9):/EFI/Microsoft/Boot/bootmgfw.efi
      '';

  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "nvidia-drm.modeset=1" "nvidia_drm.fbdev=1" "acpi_enforce_resources=lax" ];
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" "uinput" ];
  systemd.settings.Manager.DefaultTimeoutStopSec = "5s";

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
  networking.firewall.allowedUDPPorts = [ 9 ];

  # --- Localization ---
  time.timeZone = "America/Denver";
  i18n.defaultLocale = "en_US.UTF-8";

  # --- User Account ---
  users.users = {

    linc = {
      isNormalUser = true;
      description = "Lincoln";
      extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" "kvm"  ];
      packages = with pkgs; [
        firefox
        spotify
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
  services.udev.extraRules = ''
    # Input/Controller Rule
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';  

  # --- System Packages ---
  environment.systemPackages = with pkgs; [
    pkgs.sbctl          #for limine
    git
    vim
    curl
    pkgs.ethtool
    wakeonlan
  ];

  system.stateVersion = "25.11"; 
}
