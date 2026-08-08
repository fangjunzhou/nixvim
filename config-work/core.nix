{
  config = {
    # Color scheme.
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "macchiato";
    };

    # Options.
    opts = {
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
  };
}
