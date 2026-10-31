{ pkgs, ... }:
let
  comment-divider = pkgs.vimUtils.buildVimPlugin
    {
      pname = "comment-divider.nvim";
      version = "1.0.0";
      src = pkgs.fetchFromGitHub {
        owner = "fangjunzhou";
        repo = "comment-divider.nvim";
        rev = "v1.0.0";
        hash = "sha256-fVTyOlmHFTc1DTaClYxB0MPVWhwvh8ggDaGdnixWh7Y=";
      };
    };
in
{
  extraPlugins = [
    comment-divider
  ];

  extraConfigLua = builtins.readFile (./comment-divider.lua);
}
