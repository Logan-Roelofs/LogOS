{ config, pkgs, inputs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "cloud";
        plugins = [
	        "git"
          "kubectl"
          "helm"
          "docker"
        ];
      initExtraFirst = "export TERM=xterm-256colorin";
      };
    };
  };

  users.defaultUserShell = pkgs.zsh;
}

