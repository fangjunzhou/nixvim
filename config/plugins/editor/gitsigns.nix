{
  plugins.gitsigns = {
    enable = true;
  };

  keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>hs";
      action = ''
        require("gitsigns").stage_hunk
      '';
      lua = true;
      options = {
        desc = "Stage Hunk";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>hr";
      action = ''
        require("gitsigns").reset_hunk
      '';
      lua = true;
      options = {
        desc = "Reset Hunk";
      };
    }
    {
      mode = [ "v" ];
      key = "<leader>hs";
      action = ''
        function()
          require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end
      '';
      lua = true;
      options = {
        desc = "Stage Hunk";
      };
    }
    {
      mode = [ "v" ];
      key = "<leader>hr";
      action = ''
        function()
          require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end
      '';
      lua = true;
      options = {
        desc = "Reset Hunk";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>bs";
      action = ''
        require("gitsigns").stage_buffer
      '';
      lua = true;
      options = {
        desc = "Stage Buffer";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>hu";
      action = ''
        require("gitsigns").undo_stage_hunk
      '';
      lua = true;
      options = {
        desc = "Undo Stage Hunk";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>br";
      action = ''
        require("gitsigns").reset_buffer
      '';
      lua = true;
      options = {
        desc = "Reset Buffer";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>hp";
      action = ''
        require("gitsigns").preview_hunk
      '';
      lua = true;
      options = {
        desc = "Preview Hunk";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>hb";
      action = ''
        function()
          require("gitsigns").blame_line({ full = true })
        end
      '';
      lua = true;
      options = {
        desc = "Blame Line";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>tb";
      action = ''
        require("gitsigns").toggle_current_line_blame
      '';
      lua = true;
      options = {
        desc = "Toggle Current Line Blame";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>hd";
      action = ''
        require("gitsigns").diffthis
      '';
      lua = true;
      options = {
        desc = "Diff Current Buffer";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>hD";
      action = ''
        function()
          require("gitsigns").diffthis("~")
        end
      '';
      lua = true;
      options = {
        desc = "Diff Root";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>td";
      action = ''
        require("gitsigns").toggle_deleted
      '';
      lua = true;
      options = {
        desc = "Toggle Deleted";
      };
    }
  ];
}
