{
  plugins.bufferline = {
    enable = true;
  };

  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>bp";
      action = "<cmd>BufferLineTogglePin<cr>";
      options = {
        desc = "Pin Current Buffer";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>bP";
      action = "<cmd>BufferLineGroupClose ungrouped<cr>";
      options = {
        desc = "Delete Unpinned Buffers";
      };
    }
  ];
}
