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
    };

    # Clipboard.
    clipboard = {
      register = "unnamedplus";
      providers.xclip.enable = true;
    };
  };
}
