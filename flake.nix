{
  description = "Logan's NixOs configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs,  ... }@inputs:
    let
      username = "logan";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in{
      # Logos NixOs configuration
      nixosConfigurations.logos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username; };
        modules = [ 
          ./hardware/hardware-configuration.nix 
          ./modules/default.nix 
        ];
      };
    };
}
