# How we set up home-manger independently of nixos
# nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
#
# nix-channel --update
#
# MIGHT NEED TO REBOOT HERE
#
# nix-shell '<home-manager>' -A install
#
# home-manager switch
{ config, pkgs, inputs, ... }: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  nix.settings.allowed-users =
    [ "*" ]; # Allow all users to use nix daemon (used for home-manager)
}
