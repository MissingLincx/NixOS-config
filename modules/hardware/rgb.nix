{ config, pkgs, ... }:

{
  boot.kernelModules = [ "i2c-dev" "i2c-piix4" ]; # Required for SMBus/Motherboard RGB control
  
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd";
  };
}
