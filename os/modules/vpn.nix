{ config, pkgs, ... }: {
  
  environment.systemPackages = with pkgs; [
    wireguard-tools
    wireguard-ui
  ];

  programs.openvpn3.enable = true;

  services.openvpn.servers = {
    HTBThe4s = { config = ''config /home/logan/cyber/lab_the4s.ovpn''; };
    HTBAcademy = { config = ''config /home/logan/cyber/academy-regular.ovpn''; };
  };
}