{ inputs, config, pkgs, username, ... }: {
  # Web Webbrowsers
  programs.chromium.enable = true;

  # System util
  programs.kitty.enable = true;
}
