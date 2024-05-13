{
  plugins.flash = {
    enable = true;
  };

  keymaps = [
    {
      mode = [ "n" "x" "o" ];
      key = "s";
      action = ''
        function()
          require("flash").jump()
        end
      '';
      lua = true;
      options = {
        desc = "Flash";
      };
    }
    {
      mode = [ "n" "x" "o" ];
      key = "S";
      action = ''
        function()
          require("flash").treesitter()
        end
      '';
      lua = true;
      options = {
        desc = "Flash Treesitter";
      };
    }
    {
      mode = [ "o" ];
      key = "r";
      action = ''
        function()
          require("flash").remote()
        end
      '';
      lua = true;
      options = {
        desc = "Remote Flash";
      };
    }
    {
      mode = [ "x" "o" ];
      key = "R";
      action = ''
        function()
          require("flash").treesitter_search()
        end
      '';
      lua = true;
      options = {
        desc = "Treesitter Search";
      };
    }
    {
      mode = [ "c" ];
      key = "<c-s>";
      action = ''
        function()
          require("flash").toggle()
        end
      '';
      lua = true;
      options = {
        desc = "Toggle Flash Search";
      };
    }
  ];
}
