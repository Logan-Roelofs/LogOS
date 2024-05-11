{
  description = "Logan's NixOs configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ags.url = "github:Aylur/ags";
    hyprland.url = "git+https://github.com/Logan-Roelofs/Hyprland-fix";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
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
        ];
      };
      
      #'home-manger --flake .#logan@logos'
      homeConfigurations = {
        "logan" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {inherit inputs username;};
          modules = [./home.nix]; 
        };
      };

    };
}
