{ pkgs, ... }:
let
  comment-divider = pkgs.vimUtils.buildVimPlugin
    {
      name = "comment-divider";
      src = pkgs.fetchFromGitHub {
        owner = "fangjunzhou";
        repo = "comment-divider.nvim";
        rev = "v0.2.0";
        sha256 = "sha256-znj5rOYotbQ7wYpEz7aPMjY37nT2+QIM9/w+K3qiaxk=";
      };
    };
in
{
  extraPlugins = [
    comment-divider
  ];

  extraConfigLua = builtins.readFile (./comment-divider.lua);
}
