{ config, pkgs, ... }:

{
  services.tailscale.enable = true;
  services.tailscale.extraSetFlags = [ "--operator=linc" ];
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.firewall.allowedUDPPorts = [ 41641 ]; # Tailscale port
  
  environment.systemPackages = [ pkgs.tailscale-systray ];
}
