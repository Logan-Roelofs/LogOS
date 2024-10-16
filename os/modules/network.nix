{ config, pkgs, inputs, username, ... }: {

  networking.nat.enable = true;
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
    gtk3
    wireguard-tools
    wg-bond
    wg-netmanager
    gnome.gnome-control-center
    networkmanager-openvpn
    gnome.networkmanager-openvpn
    networkmanager-fortisslvpn
    gnome.networkmanager-fortisslvpn
    networkmanager-openconnect
    gnome.networkmanager-openconnect
    networkmanager-vpnc
    gnome.networkmanager-vpnc
    networkmanager-sstp
    networkmanager-l2tp
    networkmanager-iodine
    gnome.networkmanager-iodine
    networkmanager_strongswan
  ];
  networking.wg-quick.interfaces = {
    wg-proton = {
      address = [ "10.2.0.2/32" ];
      dns = [ "10.2.0.1" ]; # mullvad public dns
      privateKeyFile = "../../dotfiles/vpn/wg-proton-privatekey";
      peers = [
        {
          publicKey = "Lblqk058zWqS+I7pxpKo4ffxfceki0KTTGdEdvI4zUg=";
          allowedIPs = [ "0.0.0.0/0" ]; # Only send communication through mullvad if it is in the range of the given ips, allows for split tunneling
          endpoint = "149.22.88.59:51820"; # my selected mullvad enpoint
        }
      ];
    };
  };
}