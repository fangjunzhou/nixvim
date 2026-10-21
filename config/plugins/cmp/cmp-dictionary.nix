{ pkgs, pkgs-cmp-dict, ... }:

{
  # Keep the pinned dictionary plugin without pulling in its old nvim-cmp.
  extraPlugins = [
    (pkgs-cmp-dict.vimPlugins.cmp-dictionary.overrideAttrs (_: {
      dependencies = [ pkgs.vimPlugins.nvim-cmp ];
    }))
  ];

  extraConfigLua = ''
      local dict = require("cmp_dictionary")
    	dict.setup({
    	  exact = -1,
    	  first_case_insensitive = true,
    	  document = false,
    	  document_command = "wn %s -over",
    	  sqlite = false,
    	  max_items = 5,
    	  capacity = 5,
    	  debug = false,
    	})
      dict.switcher({
        spelllang = {
          en = "${./en.dict}",
        },
      })
  '';
}
