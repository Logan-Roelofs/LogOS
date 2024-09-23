{ inputs, config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    userSettings = {
      "git.enabled" = false;
      "editor.tabSize" = 2;
    };
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      yzhang.markdown-all-in-one
      github.copilot-chat
      github.copilot
      jnoortheen.nix-ide
      
    ];
  };
  home.packages = with pkgs; [ nixpkgs-fmt ];
}
