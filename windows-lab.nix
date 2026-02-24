{ config, pkgs, ... }:

{
  specialisation.lab-mode.configuration = {
    system.nixos.tags = [ "windows-ad-lab" ];

    # Enable the virtualization brain
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    # Add any specific lab-only tools here
    environment.systemPackages = with pkgs; [
      quickemu    # Great for "I just need a Win11 VM right now"
      virt-viewer
    ];

    # This ensures your user can manage VMs without 'sudo' every time
    users.users.Linc.extraGroups = [ "libvirtd" ];
  };
}
