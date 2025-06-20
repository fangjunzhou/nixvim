{
  plugins.neogen = {
    enable = true;
  };

  extraConfigLua = ''
    require("neogen").setup {
      enabled = true,
      languages = {
        python = {
          template = {
            annotation_convention = "reST"
          }
        },
      }
    }
  '';
}
