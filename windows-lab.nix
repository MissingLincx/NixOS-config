{ config, pkgs, ... }:

{
  specialisation.lab-mode.configuration = {
    system.nixos.tags = [ "windows-ad-lab" ];

    # 1. Virtualization setup
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    # 2. Add linc to libvirtd group without redefining the whole user
    users.users.linc.extraGroups = [ "libvirtd" ];

    # 3. Lab-specific packages
    environment.systemPackages = with pkgs; [
      quickemu
      virt-viewer
    ];

    environment.variables.WLAB_ACTIVE = "󰖳 AD-LAB";

    # 4. Networking for VMs
    networking.firewall.trustedInterfaces = [ "virbr0" ];
  };
}
