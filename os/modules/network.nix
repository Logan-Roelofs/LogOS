{ config, pkgs, inputs, username, ... }: {

  networking.nat.enable = true;
  services.mullvad-vpn.enable = true;
  networking.resolvconf.enable = true;
  networking.firewall.checkReversePath = "strict"; # or "false"
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