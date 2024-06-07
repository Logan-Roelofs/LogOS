{ config, pkgs, inputs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        # Theme is the prompt layout
        theme = "strug";
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

