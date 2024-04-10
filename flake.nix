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
      pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; config.allowUnfree = true; };
    in
    {
    
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs; inherit pkgs-unstable;};
          modules = [ 
            ./hosts/desktop/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs; pkgs = pkgs-unstable; nixpkgs = nixpkgs-unstable; inherit pkgs-unstable;};
          modules = [ 
            ./hosts/laptop/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
