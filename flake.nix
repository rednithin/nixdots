{
  description = "Nixos config flake";

  inputs = {
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    
    home-manager-stable = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs-stable, nixpkgs-unstable, home-manager-stable, home-manager-unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};
      pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; config.allowUnfree = true; };
      nixpkgs = if (builtins.hostName == "laptop") then nixpkgs-unstable else nixpkgs-stable;
      pkgs = if (builtins.hostName == "laptop") then pkgs-unstable else pkgs-stable;
      home-manager = if (builtins.hostName == "laptop") then home-manager-unstable else home-manager-stable;
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs-stable.lib.nixosSystem {
          specialArgs = {inherit inputs; inherit pkgs; inherit nixpkgs; inherit home-manager;};
          modules = [ 
            ./hosts/desktop/configuration.nix
            inputs.home-manager-stable.nixosModules.default
          ];
        };
        laptop = nixpkgs-unstable.lib.nixosSystem {
          specialArgs = {inherit inputs; inherit pkgs; inherit nixpkgs; inherit home-manager;};
          modules = [ 
            ./hosts/laptop/configuration.nix
            inputs.home-manager-unstable.nixosModules.default
          ];
        };
      };
    };
}
