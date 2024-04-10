{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {
    
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs; inherit pkgs-unstable;};
          modules = [ 
            ./configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
