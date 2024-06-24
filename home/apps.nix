{ inputs, config, pkgs, username, ... }: {
  # Web Webbrowsers
  programs.firefox.enable = true;
  programs.chromium.enable = true;

  # System util
  programs.kitty.enable = true;
  programs.alacritty.enable = true;

  # Text Editor
  programs.vscode.enable = true;
}
