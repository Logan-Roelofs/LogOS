{
  description = "Logan's NixOs configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ags.url = "github:Aylur/ags";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      username = "logan";
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in{
      
      # 'nixos-rebuild --flake .#logos'
      nixosConfigurations.logos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username; };
        modules = [
          ./hardware/hardware-configuration.nix 
          ./modules/default.nix
          inputs.stylix.nixosModules.stylix
        ];
      };
      
      #'home-manger --flake .#logan'
      homeConfigurations = {
        "logan" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {inherit inputs username;};
          modules = [
            ./home.nix
            inputs.stylix.homeManagerModules.stylix
          ]; 
        };
      };
    };
}
