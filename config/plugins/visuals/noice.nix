{ helpers, ... }:
{
  plugins.noice = {
    enable = true;
    settings.lsp.progress.enabled = false;
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
