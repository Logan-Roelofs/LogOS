{ config, pkgs, inputs, username, ... }: {
  environment.systemPackages = with pkgs; [
    hello
  ];
}