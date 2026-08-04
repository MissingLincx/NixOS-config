{ config, pkgs, ... }:

{
  #Speed up initial  shader compilation in Steam
  home.file.".local/share/Steam/steam_dev.cfg".text = ''
    unShaderBackgroundProcessingThreads 12
  '';

  users.users.linc.extraGroups = [ "video" "render" "input" ];

  # --- Security & Core Drivers ---

  hardware.graphics.enable32Bit = true;

  programs.gamemode.enable = true;

  home.packages = with pkgs; [
    mangohud # Great for monitoring FPS
    protonup-qt # for proton GE
  ];
}
