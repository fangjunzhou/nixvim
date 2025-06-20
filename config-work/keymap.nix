{
  globals.mapleader = " ";
  keymaps = [
    # Wrapped line movement.
    {
      mode = [ "n" "v" ];
      key = "j";
      action = "v:count == 0 ? 'gj' : 'j'";
      options = {
        expr = true;
        remap = true;
      };
    }
    {
      mode = [ "n" "v" ];
      key = "k";
      action = "v:count == 0 ? 'gk' : 'k'";
      options = {
        expr = true;
        remap = true;
      };
    }
    # Window movement.
    {
      mode = [ "n" ];
      key = "<c-h>";
      action = "<c-w>h";
      options = {
        remap = true;
      };
    }
    {
      mode = [ "n" ];
      key = "<c-j>";
      action = "<c-w>j";
      options = {
        remap = true;
      };
    }
    {
      mode = [ "n" ];
      key = "<c-k>";
      action = "<c-w>k";
      options = {
        remap = true;
      };
    }
    {
      mode = [ "n" ];
      key = "<c-l>";
      action = "<c-w>l";
      options = {
        remap = true;
      };
    }
    # Window resize
    {
      mode = [ "n" ];
      key = "<c-up>";
      action = "<cmd>resize +2<cr>";
    }
    {
      mode = [ "n" ];
      key = "<c-down>";
      action = "<cmd>resize +2<cr>";
    }
    {
      mode = [ "n" ];
      key = "<c-left>";
      action = "<cmd>vertical resize -2<cr>";
    }
    {
      mode = [ "n" ];
      key = "<c-right>";
      action = "<cmd>vertical resize +2<cr>";
    }
    # Window split
    {
      mode = [ "n" ];
      key = "<leader>-";
      action = "<C-W>s";
      options = {
        desc = "Split Window Horizontally";
        remap = true;
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>|";
      action = "<C-W>v";
      options = {
        desc = "Split Window Vertically";
        remap = true;
      };
    }
    # Tab management
    {
      mode = [ "n" ];
      key = "<leader><tab><tab>";
      action = "<cmd>tabnew<cr>";
      options = {
        desc = "New Tab";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader><tab>l";
      action = "<cmd>tabnext<cr>";
      options = {
        desc = "Next Tab";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader><tab>h";
      action = "<cmd>tabprevious<cr>";
      options = {
        desc = "Previous Tab";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader><tab>d";
      action = "<cmd>tabclose<cr>";
      options = {
        desc = "Close Tab";
      };
    }
    # Buffer movement
    {
      mode = [ "n" ];
      key = "<s-h>";
      action = "<cmd>bprevious<cr>";
      options = {
        desc = "Previous Buffer";
      };
    }
    {
      mode = [ "n" ];
      key = "<s-l>";
      action = "<cmd>bnext<cr>";
      options = {
        desc = "Next Buffer";
      };
    }
    # Misc
    {
      mode = [ "n" ];
      key = "<leader>qq";
      action = "<cmd>qa<cr>";
      options = {
        desc = "Quit All";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>hh";
      action = "<cmd>nohlsearch<cr>";
      options = {
        desc = "Clear Search Highlight";
      };
    }
  ];
}
