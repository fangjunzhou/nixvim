{
  plugins.trouble = {
    enable = true;
  };
  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>xx";
      action = ''
        function()
          require("trouble").toggle()
        end
      '';
      lua = true;
      options = {
        desc = "Toggle Trouble";
      };
    }
  ];
}
