{ pkgs, ... }:

{
  imports = [
    ./bufferline.nix
    ./lualine.nix
    ./noice.nix
    ./virt-column-nvim.nix
  ];

  extraPlugins = with pkgs.vimPlugins; [
    dressing-nvim
  ];
}
