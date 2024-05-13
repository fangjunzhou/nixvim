{
  plugins.cmp-dictionary = {
    enable = true;
  };

  extraConfigLua = ''
      local dict = require("cmp_dictionary")
    	dict.setup({
        paths = { "${./en.dict}" },
    	  exact_length = -1,
    	  first_case_insensitive = true,
    	  document = {
          enable = false,
          command = { "wn", "%s", "-over" },
        },
    	})
  '';
}
