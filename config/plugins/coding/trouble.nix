{ helpers, ... }:

{
  plugins.trouble = {
    enable = true;
  };
  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>xx";
      action = helpers.mkRaw ''
        function()
          require("trouble").toggle()
        end
      '';
      options = {
        desc = "Toggle Trouble";
      };
    }
  ];
}
