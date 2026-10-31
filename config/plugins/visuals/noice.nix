{ helpers, ... }:
{
  plugins.noice = {
    enable = true;
    settings = {
      lsp.progress.enabled = false;
      routes = [
        {
          # Hide the idle Normal-mode Ctrl-C quit hint, with or without unsaved changes.
          filter = {
            event = "msg_show";
            kind = "";
            find = "^Type  :qa!?  and press <Enter> to ";
          };
          opts.skip = true;
        }
      ];
    };
  };
  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>n";
      action = "<cmd>Noice dismiss<cr>";
      options = {
        desc = "Dismiss Noice";
      };
    }
  ];
}
