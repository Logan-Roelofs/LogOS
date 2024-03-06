{ config, pkgs, ... }:{
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    cmake
    pkg-config
  ];
}
