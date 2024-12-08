{ config, pkgs, lib, inputs, username, ... }: {
  #  fonts.packages = with pkgs; [
  #    font-awesome
  #ubuntu_font_family
  #nerdfonts
  #monaspace
  #];
  font.packages = [ pkgs.monaspace pkgs.font-awesome pkgs.ubuntu_font_family ... ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts)
  environment.systemPackages = with pkgs;
    [
      adwaita-icon-theme # Icon theme
    ];
}
