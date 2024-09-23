{ inputs, config, pkgs, ... }: {
  home.packages = with pkgs; [
    (vscode-with-extensions.override {
      vscode = vscodium-fhs;
      vscodeExtensions = with vscode-extensions; [
        # Language Support
        vscode-extensions.jnoortheen.nix-ide
        # Ai
        vscode-extensions.github.copilot
        vscode-extensions.github.copilot-chat
        vscode-extensions.vscodevim.vim
      ]; # ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      #      {
      #        name = "remote-ssh-edit";
      #        publisher = "ms-vscode-remote";
      #        version = "0.47.2";
      #        sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
      #      }
      #    ];
    })
    nixpkgs-fmt
  ];
}
