{ inputs, config, pkgs, username, ... }: {
  # Web Webbrowsers
  programs.firefox.enable = true;
  programs.chromium.enable = true;

  # System util
  programs.kitty.enable = true;
  
  # IDE
  programs.vscode.enable = true;
  programs.vscode.userSettings = {
    "git.enabled" = "off";
  }

}
