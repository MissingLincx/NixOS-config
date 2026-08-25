{ config, pkgs, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    
    loadModels = [
      "qwen2.5:14b-instruct"
    ];
  };

  environment.sessionVariables = {
    OLLAMA_API_BASE = "http://127.0.0.1:11434";
  };

  environment.systemPackages = with pkgs; [
    aider-chat
  ];
}
