# This is an NixOS module that install the tools we need for screen shots
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    grim    # screenshot tool 
    slurp   # select a region of the screen
    swappy  # gui for editing screenshots
    wl-clipboard # clipboard manager
    #convert not sure what package this comes from  but we already have it installed 
  ]; 
}
