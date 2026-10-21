{ pkgs, ... }:

{
  imports = [
    ./clipboard-image.nix
    ./copy-reference.nix
    ./config-local.nix
    ./flash.nix
    ./mini.nix
    ./telescope.nix
    ./which-key.nix
  ];

  plugins.lazydev.enable = true;

  extraPlugins = [
    pkgs.vimPlugins.nvim-luadev
  ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>ll";
      action = "<Plug>(Luadev-RunLine)";
      options = {
        remap = true;
        desc = "Evaluate Lua line";
      };
    }
    {
      mode = "x";
      key = "<leader>le";
      action = "<Plug>(Luadev-Run)";
      options = {
        remap = true;
        desc = "Evaluate selected Lua";
      };
    }
    {
      mode = "n";
      key = "<leader>lo";
      action = "<cmd>Luadev<cr>";
      options.desc = "Open Lua output";
    }
  ];
}
