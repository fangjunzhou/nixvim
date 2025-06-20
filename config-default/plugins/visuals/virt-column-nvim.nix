{ pkgs, ... }:

let
  virt-column-nvim = pkgs.vimUtils.buildVimPlugin
    {
      name = "virt-column-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "lukas-reineke";
        repo = "virt-column.nvim";
        rev = "v2.0.2";
        sha256 = "sha256-7ljjJ7UwN2U1xPCtsYbrKdnz6SGQGbM/HrxPTxNKlwo=";
      };
    };
in
{
  extraPlugins = [ virt-column-nvim ];

  extraConfigLua = ''
    require("virt-column").setup({
      virtcolumn = "80"
    })
  '';
}
