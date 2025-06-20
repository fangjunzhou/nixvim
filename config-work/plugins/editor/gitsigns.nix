{ helpers, ... }:

{
  plugins.gitsigns = {
    enable = true;
  };

  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>hs";
      action = helpers.mkRaw ''
        require("gitsigns").stage_hunk
      '';
      options = {
        desc = "Stage Hunk";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>hr";
      action = helpers.mkRaw ''
        require("gitsigns").reset_hunk
      '';
      options = {
        desc = "Reset Hunk";
      };
    }
    {
      mode = [ "v" ];
      key = "<leader>hs";
      action = helpers.mkRaw ''
        function()
          require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end
      '';
      options = {
        desc = "Stage Hunk";
      };
    }
    {
      mode = [ "v" ];
      key = "<leader>hr";
      action = helpers.mkRaw ''
        function()
          require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end
      '';
      options = {
        desc = "Reset Hunk";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>bs";
      action = helpers.mkRaw ''
        require("gitsigns").stage_buffer
      '';
      options = {
        desc = "Stage Buffer";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>hu";
      action = helpers.mkRaw ''
        require("gitsigns").undo_stage_hunk
      '';
      options = {
        desc = "Undo Stage Hunk";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>br";
      action = helpers.mkRaw ''
        require("gitsigns").reset_buffer
      '';
      options = {
        desc = "Reset Buffer";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>hp";
      action = helpers.mkRaw ''
        require("gitsigns").preview_hunk
      '';
      options = {
        desc = "Preview Hunk";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>hb";
      action = helpers.mkRaw ''
        function()
          require("gitsigns").blame_line({ full = true })
        end
      '';
      options = {
        desc = "Blame Line";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>tb";
      action = helpers.mkRaw ''
        require("gitsigns").toggle_current_line_blame
      '';
      options = {
        desc = "Toggle Current Line Blame";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>hd";
      action = helpers.mkRaw ''
        require("gitsigns").diffthis
      '';
      options = {
        desc = "Diff Current Buffer";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>hD";
      action = helpers.mkRaw ''
        function()
          require("gitsigns").diffthis("~")
        end
      '';
      options = {
        desc = "Diff Root";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>td";
      action = helpers.mkRaw ''
        require("gitsigns").toggle_deleted
      '';
      options = {
        desc = "Toggle Deleted";
      };
    }
  ];
}
