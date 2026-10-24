{
  description = "A flake";

  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    whitenoise = {
      url = "github:clearcmos/whitenoise-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };

 };

  outputs = inputs@{
    self,
    nixpkgs,
    home-manager,
    stylix,
    whitenoise,
    nixvim,
    ...
  }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in {
      nixosConfigurations.nixos = lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
	  nixvim.nixosModules.nixvim
          {
            nixpkgs.overlays = [
              whitenoise.overlays.default
            ];

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ted = {
              imports = [
                ./home.nix
              ];
            };
          }
        ];
      };
    };
}
