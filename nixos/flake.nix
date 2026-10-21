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

  outputs = { self, nixpkgs, home-manager, stylix, whitenoise, nixvim, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [ 
            ./configuration.nix
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ted = { pkgs, config, ... }: {
                imports = [ ./home.nix ];
              };
            }
            { 
              nixpkgs.overlays = [ 
                whitenoise.overlays.default
              ]; 
            } 
          ];
        };
      };
    };
}
