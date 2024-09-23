{ inputs, config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    #userSettings = {
    # "git.enable" = false;
    #  "editor.tabSize" = 2;
    #};
  };
}
