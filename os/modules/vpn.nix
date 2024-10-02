{ config, pkgs, ... }: {
  programs.openvpn3.enable = true;
  services.openvpn.servers = {
    HTBThe4s = { config = ''config /home/logan/cyber/lab_the4s.ovpn''; };
  };
}