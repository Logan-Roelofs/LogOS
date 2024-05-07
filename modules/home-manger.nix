# How we set up home-manger independently of nixos
# nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
#
# nix-channel --update
#
# nix-shell '<home-manager>' -A install
#
# home-manager switch

{ config, pkgs, inputs, ... }:
{
  nix.settings.allowed-users = [ "*" ]; # Allow all users to use nix daemon (used for home-manager)
}
