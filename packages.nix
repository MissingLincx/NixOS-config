{ pkgs, ... }:

{
  # Steam configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Sunshine Service (The Host)
#  services.sunshine = {
#    enable = true;
#    autoStart = true;
#    capSysAdmin = true; # Allows Sunshine to capture the screen without being root
#    openFirewall = true; # Opens 47984-48010 for Moonlight
#  };

  environment.systemPackages = with pkgs; [
    vesktop
    git
    htop
    btop
 #   nvtopPackages.nvidia
    firefox
    
    # Optional: Moonlight (The Client) 
    # Add this if you want to stream FROM other PCs to this one
    # moonlight-qt 
  ];
}
