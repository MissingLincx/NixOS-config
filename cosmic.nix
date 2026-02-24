{ config, pkgs, ... }:

{
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-store
    cosmic-edit
  ];

  services.system76-scheduler.enable = true;
}
