{
  description = "Linc's chill Nixos configuration flake.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpapers = {
      url = "github:MissingLincx/wallpapers";
      flake = false;
    };
  };

  outputs = { self, nixpkgs,  home-manager, wallpapers, nvf, nixos-wsl, ...} @ inputs: {
    nixosConfigurations = {
      chill = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./hosts/chill/configuration.nix
	    home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
	        home-manager.backupFileExtension = "backup";
            home-manager.users.linc = import ./home.nix;
          }
        ];
      };

      chilltop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./hosts/chilltop/configuration.nix
	  home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
	        home-manager.backupFileExtension = "backup";
            home-manager.users.linc = import ./home.nix;
          }
        ];
      };

      chillwsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        extraSpecialArgs = { inherit inputs; };
        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.home-manager
          ./hosts/chillwsl/configuration.nix
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              backupFileExtension = "backup";

              users.linc = import ./home.nix;
            };
          }
        ];
      };
    };
  };
}
