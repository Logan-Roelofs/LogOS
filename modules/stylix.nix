{ pkgs, inputs, ...}:

{
  #stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  stylix.base16Scheme ={
    base00 = "171717";
    base01 = "00434e";
    base02 = "016d7d";
    base03 = "4C566A";
    base04 = "1692a6";
    base05 = "37b3c6";
    base06 = "63cfe0";
    base07 = "9ce6f2";
    base08 = "e1f9fd";
    base09 = "e86b58";
    base0A = "b09125";
    base0B = "65b630";
    base0C = "32c373";
    base0D = "35b2c5";
    base0E = "6d8cf8";
    base0F = "b968ed";

    # Nord
    #base00 = "171717";
    #base01 = "3B4252";
    #base02 = "434C5E";
    #base03 = "4C566A";
    #base04 = "D8DEE9";
    #base05 = "E5E9F0";
    #base06 = "ECEFF4";
    #base07 = "8FBCBB";
    #base08 = "BF616A";
    #base09 = "D08770";
    #base0A = "EBCB8B";
    #base0B = "A3BE8C";
    #base0C = "88C0D0";
    #base0D = "81A1C1";
    #base0E = "B48EAD";
    #base0F = "5E81AC";
  };
  stylix.autoEnable = true;
  stylix.targets.grub.enable = false;
  
  stylix.targets.plymouth.enable = true;
  stylix.targets.plymouth.logo = "NixOS logo";
  stylix.targets.plymouth.logoAnimated = true;

  stylix.image = ../dotfiles/wp/zen.png;
  stylix.targets.gtk.enable = false;
  stylix.polarity = "dark";
}
