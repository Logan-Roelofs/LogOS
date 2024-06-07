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
      	"jovial"
      ];
    };
  };
  home.file.".oh-my-zsh/custom/themes/my_awesome_theme.zsh-theme".text = ''
  PROMPT='%m %B%F{blue}:: %B%F{blue}blue               %b%F{green}%3~ $(hg_prompt_info)$(git_prompt_info)%B%(!.%F{red}.%F{blue})»%f%b '
  RPS1='%(?..%F{red}%? ↵%f)'

  ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
  ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
  
  ZSH_THEME_HG_PROMPT_PREFIX="%{$fg[magenta]%}hg:‹%{$fg[yellow]%}"
  ZSH_THEME_HG_PROMPT_SUFFIX="%{$fg[magenta]%}› %{$reset_color%}"
  ZSH_THEME_HG_PROMPT_DIRTY=" %{$fg[red]%}✗"
  ZSH_THEME_HG_PROMPT_CLEAN=""
  '';
 
}
