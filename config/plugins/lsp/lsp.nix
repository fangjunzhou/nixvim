{ pkgs, ... }:

{
  extraPlugins = with pkgs.vimPlugins;[
    ltex_extra-nvim
  ];

  plugins.lsp = {
    enable = true;
    servers = {
      cmake = {
        enable = true;
      };
      clangd = {
        enable = true;
      };
      rust-analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
      pyright = {
        enable = true;
      };
      lua-ls = {
        enable = true;
      };
      nil-ls = {
        enable = true;
      };
      ltex = {
        enable = true;
        settings = {
          checkFrequency = "edit";
          additionalRules.enablePickyRules = true;
          languageToolHttpServerUri = "https://languagetool.puffedpescado.com/";
        };
        onAttach.function = ''
          -- rest of your on_attach process.
          require("ltex_extra").setup({
            -- table <string> : languages for witch dictionaries will be loaded, e.g. { "es-AR", "en-US" }
            -- https://valentjn.github.io/ltex/supported-languages.html#natural-languages
            load_langs = { "en-US" }, -- en-US as default
            -- boolean : whether to load dictionaries on startup
            init_check = true,
            -- string : relative or absolute path to store dictionaries
            -- e.g. subfolder in the project root or the current working directory: ".ltex"
            -- e.g. shared files for all projects:  vim.fn.expand("~") .. "/.local/share/ltex"
            path = ".ltex", -- project root or current working directory
            -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
            log_level = "none",
            -- table : configurations of the ltex language server.
            -- Only if you are calling the server from ltex_extra
            server_opts = nil,
          })
        '';
      };
    };
  };

  extraConfigLua = ''
    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
    	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    	callback = function(ev)
    		-- Enable completion triggered by <c-x><c-o>
    		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    		-- Buffer local mappings.
    		-- See `:help vim.lsp.*` for documentation on any of the below functions
    		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover" })
    		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go Declaration" })
    		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go Definition" })
    		vim.keymap.set("n", "gr", function()
    			require("telescope.builtin").lsp_references()
    		end, { buffer = ev.buf, desc = "Go References" })
    		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = ev.buf, desc = "Go Implementation" })
    		vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
    		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code Action" })
    		vim.keymap.set("n", "<space>f", function()
    			vim.lsp.buf.format({ async = true })
    		end, { buffer = ev.buf, desc = "Format" })
    	end,
    })
  '';
}
