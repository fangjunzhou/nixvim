{ pkgs, ... }:

{
  extraPlugins = with pkgs.vimPlugins; [
    lazygit-nvim
  ];

  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>gg";
      action = "<cmd>LazyGit<cr>";
      options = {
        desc = "Toggle LazyGit";
      };
    }
  ];
}
