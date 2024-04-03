{ pkgs, neovim-config, username, ...}:
{
  home-manager.users.${username} = { pkgs, username, neovim-config ... }: {
  home.file.".config/nvim".source = "${neovim-config}/";
  programs.neovim.enable = true;
  };
}
