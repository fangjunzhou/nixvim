{
  config = {
    # Color scheme.
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "auto";
        background = {
          light = "latte";
          dark = "frappe";
        };
      };
    };

    # Options.
    opts = {
      # Reload externally changed files when the buffer has no unsaved edits.
      autoread = true;
      # Indent settings.
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      # Line number.
      number = true;
      relativenumber = true;
      signcolumn = "yes";
      # Search case sensitivity.
      ic = true;
      # Treesitter folding.
      foldmethod = "expr";
      foldexpr = "nvim_treesitter#foldexpr()";
    };

    # Set up reload checks before plugins so plugin errors cannot disable them.
    extraConfigLuaPre = ''
      do
        local group = vim.api.nvim_create_augroup("ExternalFileChanges", { clear = true })
        local function check_external_changes()
          local mode = vim.api.nvim_get_mode().mode
          if (mode == "n" or mode == "i") and vim.fn.getcmdwintype() == "" then
            vim.cmd("checktime")
          end
        end

        vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "InsertLeave" }, {
          group = group,
          callback = check_external_changes,
        })

        -- CursorHold does not repeat while idle; poll for edits from other agents.
        local timer = vim.fn.timer_start(2000, check_external_changes, { ["repeat"] = -1 })
        vim.api.nvim_create_autocmd("VimLeavePre", {
          group = group,
          callback = function()
            vim.fn.timer_stop(timer)
          end,
        })
      end
    '';

    # Clipboard.
    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
    };

    # Send clipboard contents through the terminal during SSH sessions.
    extraConfigLua = ''
      if vim.env.SSH_TTY or vim.env.SSH_CONNECTION then
        vim.g.clipboard = "osc52"
      end
    '';

    # Filetypes.
    filetype.extension = {
      "slang" = "slang";
    };

  };
}
