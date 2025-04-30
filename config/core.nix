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

    # Filetypes.
    filetype.extension = {
      "slang" = "slang";
    };

  };
}
