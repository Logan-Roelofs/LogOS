{
  description = "Logan's NixOs configuration flake";

  inputs = {
  
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    matugen.url = "github:InioX/matugen";
    ags.url = "github:Aylur/ags";
    stm.url = "github:Aylur/stm";

    lf-icons = {
      url = "github:gokcehan/lf";
      flake = false;
    };

  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      username = "logan";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      asztal = pkgs.callPackage ./config/ags { inherit inputs; };
    in{
      
      # Logos NixOs configuration
      nixosConfigurations.logos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username asztal; };
        modules = [ 
          /etc/nixos/hardware-configuration.nix 
          ./modules/default.nix 
          inputs.home-manager.nixosModules.default
        ];
      };
  };
}
