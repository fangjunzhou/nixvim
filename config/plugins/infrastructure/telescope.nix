{
  plugins.telescope = {
    enable = true;
  };

  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>/";
      action = ''
        function()
          require("telescope.builtin").live_grep()
        end
      '';
      lua = true;
      options = {
        desc = "Live Grep";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader><space>";
      action = ''
        function()
          require("telescope.builtin").find_files()
        end
      '';
      lua = true;
      options = {
        desc = "Find Files";
      };
    }
  ];
}
