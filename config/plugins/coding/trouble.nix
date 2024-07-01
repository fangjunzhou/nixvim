{
  plugins.trouble = {
    enable = true;
  };
  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle<cr>";
      options = {
        desc = "Toggle Trouble";
      };
    }
  ];
}
