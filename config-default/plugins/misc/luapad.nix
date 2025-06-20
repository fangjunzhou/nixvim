{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "nvim-luapad";
      src = pkgs.fetchFromGitHub {
        owner = "rafcamlet";
        repo = "nvim-luapad";
        rev = "176686eb616a5ada5dfc748f2b5109194bbe8a71";
        hash = "sha256-B0LG7EUyyXyg6N5BWijMWBNtzeF51Cd9m0gzZ437Huc=";
      };
    })
  ];
  extraConfigLua = ''
    require('luapad').setup({})
  '';
}
