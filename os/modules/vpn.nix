{ config, pkgs, ... }: {
  programs.openvpn3.enable = true;
  services.openvpn.servers = {
    HTBThe4s = { config = ''/home/longs/cyber/lab_the4s.ovpn''; };
  };
}