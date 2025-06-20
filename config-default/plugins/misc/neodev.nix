{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "neodev.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "folke";
        repo = "neodev.nvim";
        rev = "02893eeb9d6e8503817bd52385e111cba9a90500";
        hash = "sha256-vkgy2w6NvzOPlo23WKweGybEqqk4wiwdgXU1LjYkWW0=";
      };
    })
  ];
}
