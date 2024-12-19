{
  description = "Nixos config flake";

  inputs = {
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
#     nixpkgs-stable.url = "nixpkgs/nixos-24.11";
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs.follows = "nixos-cosmic/nixpkgs";


    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-cosmic, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
  in
  {
#       formatter.x86_64-linux = pkgs.nixpkgs-fmt;
      nixosConfigurations = {
        desktop =
          nixpkgs.lib.nixosSystem {
#           specialArgs = { inherit inputs; inherit nixpkgs; inherit pkgs; inherit home-manager; };
            modules = [
              ./hosts/desktop/configuration.nix
              home-manager.nixosModules.default
            ];
          };
        laptop =
          nixpkgs.lib.nixosSystem {
#           specialArgs = { inherit inputs; inherit nixpkgs; inherit pkgs; inherit home-manager; };
            modules = [
                {
                nix.settings = {
                  substituters = [ "https://cosmic.cachix.org/" ];
                  trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
                };
              }
              nixos-cosmic.nixosModules.default
              home-manager.nixosModules.default
              ./hosts/laptop/configuration.nix
            ];
          };
      };
    };
}
