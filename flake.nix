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
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-ld.url = "github:Mic92/nix-ld";
    # this line assume that you also have nixpkgs as an input
    nix-ld.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = { self, nixpkgs-stable, nixpkgs-unstable, home-manager-stable, home-manager-unstable, nix-ld, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs-stable = import nixpkgs-stable { inherit system; config.allowUnfree = true; };
      pkgs-unstable = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
    in
    {
      formatter.x86_64-linux = pkgs-unstable.nixpkgs-fmt;
      nixosConfigurations = {
        desktop =
          let
            nixpkgs = nixpkgs-unstable;
            pkgs = pkgs-unstable;
            home-manager = home-manager-unstable;
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; inherit pkgs; inherit nixpkgs; inherit pkgs-unstable; inherit home-manager; };
            modules = [
              nix-ld.nixosModules.nix-ld
              ./hosts/desktop/configuration.nix
              home-manager.nixosModules.default
            ];
          };
        laptop =
          let
            nixpkgs = nixpkgs-unstable;
            pkgs = pkgs-unstable;
            home-manager = home-manager-unstable;
          in
          nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; inherit pkgs; inherit nixpkgs; inherit pkgs-unstable; inherit home-manager; };
            modules = [
              nix-ld.nixosModules.nix-ld
              ./hosts/laptop/configuration.nix
              home-manager.nixosModules.default
            ];
          };
      };
    };
}
