{
  description = "Linc's chill Nixos configuration flake.";
  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

  outputs = { self, nixpkgs, ...} @ inputs: {
    nixosConfigurations.chill = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
