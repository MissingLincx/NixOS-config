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

  home.packages = with pkgs; [
    mangohud # Great for monitoring FPS
    protonup-qt # for proton GE
  ];
}
