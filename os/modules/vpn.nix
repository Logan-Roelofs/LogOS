{ config, pkgs, ... }: {
  services.openvpn.servers.HTBThe4s.config = "config /home/longs/cyber/lab_the4s.ovpn"
}