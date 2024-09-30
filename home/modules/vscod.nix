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
      "workbench.colorTheme" = "Visual Studio Dark";
      "github.copilot.enable" = {
        "*" = true;
        "plaintext" = true;
        "markdown" = true;
        "scminput" = true;
      };
      "editor.fontFamily" = "'Monaspace Neon'";
      "vim.overrideCopy" = false;
      "vim.useCtrlKeys" = false;
      "editor.cursorBlinking" = "phase";
      "editor.cursorSmoothCaretAnimation" = "on";
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
    };
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      github.copilot-chat
      github.copilot
      jnoortheen.nix-ide
    ];
  };
  home.packages = with pkgs; [
    nixpkgs-fmt
    fzf
    ripgrep
    bat
  ];
}