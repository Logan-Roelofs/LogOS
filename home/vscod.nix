{ inputs, config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    userSettings = {
      "git.enabled" = false;
      "editor.tabSize" = 2;
      "terminal.integrated.sendKeybindingsToShell" = true;
      # remove the code minimap
      "editor.minimap.enabled" = false;
      "window.menuBarVisibility" = "toggle";
      "accessibility.verbosity.panelChat" = false;
      "workbench.sideBar.location" = "left";
    };
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      github.copilot-chat
      github.copilot
      jnoortheen.nix-ide
    ];
  };
  home.packages = with pkgs; [ nixpkgs-fmt ];
}
