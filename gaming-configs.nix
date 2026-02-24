{ config, pkgs, ... }:

{
  xdg.configFile."sunshine/apps.json".text = builtins.toJSON {
    apps = [
      {
        name = "Steam Big Picture";
        cmd = "steam -tenfoot -steamos";
      }
      {
        name = "Desktop";
        cmd = "xterm";
      }
    ];
  };

  #Speed up initial  shader compilation in Steam
  home.file.".local/share/Steam/steam_dev.cfg".text = ''
    unShaderBackgroundProcessingThreads 12
  '';

  home.packages = with pkgs; [
    mangohud # Great for monitoring FPS
    protonup-qt # for proton GE
  ];
}
