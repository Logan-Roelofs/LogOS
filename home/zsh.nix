{ inputs, config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      custom = "$HOME/.oh-my-zsh/custom";
      enable = true;
      # Theme is the prompt layout
      theme = "my_awesome_theme";
      plugins = [
        "git"
      ];
    };
  };
  home.file.".oh-my-zsh/custom/themes/my_awesome_theme.zsh-theme" = { 
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/logos/dotfiles/oh-my-zsh/";
    recursive = true;
  };
}
