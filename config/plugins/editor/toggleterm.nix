{
  plugins.toggleterm = {
    enable = true;
  };

  keymaps = [
    {
      mode = [ "n" ];
      key = "<c-\\>";
      action = "<cmd>ToggleTerm<cr>";
      options = {
        desc = "Toggle Terminal";
      };
    }
  ];
}
