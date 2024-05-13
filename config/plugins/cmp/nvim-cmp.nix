{
  plugins = {
    cmp = {
      enable = true;
      autoEnableSources = false;
      settings = {
        snippet.expand = "luasnip";
        sources = {
          __raw = ''
            cmp.config.sources({
              { name = "nvim_lsp" },
              { name = "latex_symbols", option = { strategy = 2 } },
              { name = "luasnip" },
              { name = "path" },
              { name = "dictionary" },
            })
          '';
        };
        mapping = {
          "<c-space>" = "cmp.mapping.complete()";
          "<c-b>" = "cmp.mapping.scroll_docs(-4)";
          "<c-f>" = "cmp.mapping.scroll_docs(4)";
          "<c-e>" = "cmp.mapping.close()";
          "<cr>" = "cmp.mapping.confirm({ select = true })";
          "<c-j>" = ''
            cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end, {"i", "s"})
          '';
          "<c-k>" = ''
            cmp.mapping(function()
              if cmp.visible() then
                cmp.select_prev_item()
              end
            end, {"i", "s"})
          '';
          "<tab>" = ''
            cmp.mapping(function(fallback)
              local luasnip = require("luasnip")
              if luasnip.jumpable(1) then
                luasnip.jump(1)
              else
                fallback()
              end
            end, {"i", "s"})
          '';
          "<s-tab>" = ''
            cmp.mapping(function()
              local luasnip = require("luasnip")
              if luasnip.jumpable(-1) then
                luasnip.jump(-1)
              end
            end, {"i", "s"})
          '';
        };
      };
    };
    cmp-nvim-lsp.enable = true;
    cmp_luasnip.enable = true;
    cmp-path.enable = true;
    cmp-latex-symbols.enable = true;
  };
}
