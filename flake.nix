{
  description = "Linc's chill Nixos configuration flake.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wallpapers = {
      url = "github:MissingLincx/wallpapers";
      flake = false;
    };
    #working version of sunshine
    nixpkgs-sunshine.url = "github:nixos/nixpkgs/a82ccc39b39b621151d6732718e3e250109076fa";
  };

  outputs = { self, nixpkgs, home-manager, wallpapers, nixpkgs-sunshine, ...} @ inputs: {
    nixosConfigurations.chill = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
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
  };
}
