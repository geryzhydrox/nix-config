
{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix?ref=release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs,  ... }@inputs: {
    nixosConfigurations = {
      nixos-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ({pkgs, ...}: {
            imports = [
              ./configuration.nix
              ./hosts/desktop.nix
              inputs.stylix.nixosModules.stylix
              inputs.home-manager.nixosModules.default
            ];
          })
        ];
      };
      nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ({pkgs, ...}: {
            imports = [
              ./configuration.nix
              ./hosts/laptop.nix
              inputs.stylix.nixosModules.stylix
              inputs.home-manager.nixosModules.default
            ];
          })
        ];
      };
    };
  };
}
