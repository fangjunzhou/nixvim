{ pkgs, ... }:

{
  extraPlugins = with pkgs.vimPlugins; [
    vim-suda
  ];
}
