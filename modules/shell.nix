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
      };
    };
  };

  users.defaultUserShell = pkgs.zsh;
}

