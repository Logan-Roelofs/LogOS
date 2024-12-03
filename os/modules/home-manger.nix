{ config, pkgs, inputs, ... }: {
  nix.settings.allowed-users =
    [ "*" ]; # Allow all users to use nix daemon (used for home-manager)
}
