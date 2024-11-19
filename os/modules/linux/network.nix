{ config, pkgs, inputs, username, ... }: {

  services.mullvad-vpn.enable = true;
  networking.hostName = "NixOS";
  networking.networkmanager.enable = true;
  networking.extraHosts = ''
    10.10.11.230 cozyhosting.htb
  '';
  users.users.${username} = {
    extraGroups = [ "networkmanager" "wheel" ];
  };
  networking.firewall.enable = false;
  environment.systemPackages = with pkgs; [
    mullvad-vpn
    mullvad
    mullvad-closest
    wireguard-tools
    wg-netmanager
    gnome.gnome-control-center
  ];
}