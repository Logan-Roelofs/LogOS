{ inputs, config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    #package = pkgs.vscodium-fhs;
    userSettings = {
      "git.enabled" = true;
      "editor.tabSize" = 2;
      "terminal.integrated.sendKeybindingsToShell" = false;
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
