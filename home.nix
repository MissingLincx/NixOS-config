{ config, pkgs, inputs, ... }:

{
  imports = [
    ./terminal-configs.nix
    ./gaming-configs.nix
    ./wallpapers.nix
    ./conky-dash.nix
    ./conky-cheatsheet.nix
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

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
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
    pkgs.godot_4
    (pkgs.python3.withPackages (ps: with ps; [
    pandas
    requests
    numpy
    ]))
  ];

  programs.home-manager.enable = true;
}
