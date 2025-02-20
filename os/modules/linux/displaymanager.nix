{ config, pkgs, inputs, ... }: {
  services.xserver.displayManager.sddm.enable = true; 
}
