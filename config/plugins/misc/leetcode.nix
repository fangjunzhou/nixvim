{ pkgs, ... }:

{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "leetcode.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "kawre";
        repo = "leetcode.nvim";
        rev = "458da8ea7e73e8ed221165aa56a595e33c4ec644";
        hash = "sha256-GwkuVt+21yCccrwCpTZ2y4qtP3GZol95JjTv2xksf3g=";
      };
    })
  ];
  extraConfigLua = builtins.readFile (./leetcode.lua);
}
