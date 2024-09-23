{ inputs, config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    userSettings = {
      "editor.tabSize" = 2;
      "files.autoSave" = "onFocusChange";
    };
  };
}
