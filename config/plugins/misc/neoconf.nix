{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "neoconf.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "folke";
        repo = "neoconf.nvim";
        rev = "5d2eb47ec961018c1be6891d153039caa4c61220";
        hash = "sha256-Aj0XcK5HiSzbHYPOhMrLWBbi25sYRghV6GWABXaGns4=";
      };
    })
  ];
}
