{ pkgs, system, ... }:

{
  plugins.clipboard-image = {
    enable = true;
    clipboardPackage =
      if system == "x86_64-darwin" || system == "aarch64-darwin" then
        pkgs.pngpaste
      else
        pkgs.xclip;
  };
}
