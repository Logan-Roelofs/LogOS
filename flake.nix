{
  description = "Logan's NixOs configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ags.url = "github:Aylur/ags";
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-python.url = "github:cachix/nixpkgs-python";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      username = "logan";
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      # 'sudo nixos-rebuild --flake .#logos'
      nixosConfigurations.logos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username home-manager; };
        modules = [
          ./hardware/hardware-configuration.nix
          ./os/default.nix
          inputs.stylix.nixosModules.stylix
          inputs.hyprland.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.logan = import ./home/default.nix;
            home-manager.extraSpecialArgs = { inherit inputs username; };
          }
        ];
      };
    };
}
