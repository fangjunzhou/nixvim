{ pkgs, ... }:

{
  extraPlugins = with pkgs.vimPlugins; [
    friendly-snippets
  ];
}
