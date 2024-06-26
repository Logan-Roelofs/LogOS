# This is an NixOS module that install the tools we need for screenshots
# Here are the two comands that are useful for screenshots
# To edit the screenshot-
# grim -g "$(slurp)" -| swappy -f -
# To copy the screenshot to the clipboard-
# grim -g "$(slurp)" -| wl-copy --type image/png
{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    grim # screenshot tool
    slurp # select a region of the screen
    swappy # gui for editing screenshots
    wl-clipboard # clipboard manager
    #convert
    #^ not sure what package this comes from  but we already have it installed
  ];
}
