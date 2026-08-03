{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/environment/terminal-configs.nix
    ./modules/gaming/gaming-configs.nix
    ./modules/desktop/wallpapers.nix
    ./modules/desktop/conky-dash.nix
    #./modules/desktop/conky-cheatsheet.nix
    inputs.nvf.homeManagerModules.default
  ];

  home.username = "linc";
  home.homeDirectory = "/home/linc";
  home.stateVersion = "25.11";

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };

  programs.ghostty = {
    enable = true;
  	settings = {
      theme = "Terafox";
      font-size = 11;
      font-family = "FiraCode Nerd Font"; # Ensure this font is in your home.packages
    
      window-decoration = true;
      window-padding-x = 12;
      window-padding-y = 8;
    
      background-opacity = 0.95;
      background-blur = true;
    };
  };


  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        autocomplete.nvim-cmp.enable = true;
        viAlias = true;
        vimAlias = true;

        options = {
          tabstop = 4;        # Visual width of a tab
          shiftwidth = 2;     # Size of an indent
          softtabstop = 4;    # Number of spaces a tab counts for while editing
          expandtab = true;   # Convert tabs to spaces
        };
        lsp.enable = true;
        languages = {
          enableTreesitter = true;
          python = {
            enable = true;
            lsp.enable = true;
            format.enable = true;
          };
        nix.enable = true;
        };

        theme = {
          enable = true;

          name = "tokyonight";
          style = "storm";
        };

        clipboard = {
          enable = true;
          registers = "unnamedplus";
          providers.wl-copy.enable = true;
        };
        
        statusline.lualine.enable = true;
        telescope.enable = true;
      };
    };
  };

  home.packages = with pkgs; [
    brave
    vesktop
    obsidian
    pkgs.rgbds
    (pkgs.python3.withPackages (ps: with ps; [
    pandas
    requests
    numpy
    ]))
	pkgs.nerd-fonts.fira-code
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
}
