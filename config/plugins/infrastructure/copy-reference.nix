{ pkgs, ... }:

let
  copy-reference-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "copy-reference.nvim";
    version = "unstable-2026-08-25";
    src = pkgs.fetchFromGitHub {
      owner = "cajames";
      repo = "copy-reference.nvim";
      rev = "6b888fa9b280724f79f33c031a2105a962c2014c";
      hash = "sha256-5c+1G0hKMCXAqS6byiEZsO2VosZrkeDjYyV5LX/iPHo=";
    };
  };
in
{
  extraPlugins = [ copy-reference-nvim ];

  extraConfigLua = ''
    require("copy-reference").setup({})
  '';

  keymaps = [
    {
      mode = [ "n" "v" ];
      key = "gy";
      action = "<cmd>CopyReference line<cr>";
      options.desc = "Copy File Reference";
    }
  ];
}
