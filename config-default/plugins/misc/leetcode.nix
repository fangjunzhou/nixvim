{ pkgs, ... }:

{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "leetcode.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "fangjunzhou";
        repo = "leetcode.nvim";
        rev = "v0.1.0";
        hash = "sha256-M1p5ZucnQKEsn8922H8+FEmz1jifE+BDAg6hZ/hXW1s=";
      };
    })
  ];
  extraConfigLua = builtins.readFile (./leetcode.lua);
}
