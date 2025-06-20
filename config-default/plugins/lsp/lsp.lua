vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.wgsl",
  callback = function()
    vim.bo.filetype = "wgsl"
  end,
})

local lspconfig = require("lspconfig")

lspconfig.wgsl_analyzer.setup({
  cmd = { "${pkg-wgsl-analyzer}/bin/wgsl_analyzer" }
})

vim.lsp.handlers["wgsl-analyzer/requestConfiguration"] = function(err, result, ctx, config)
  return { 
      success = true,
      customImports = { _dummy_ = "dummy"},
      shaderDefs = {},
      trace = {
          extension = false,
          server = false,
      },
      inlayHints = {
          enabled = false,
          typeHints = false,
          parameterHints = false,
          structLayoutHints = false,
          typeVerbosity = "inner",
      },
      diagnostics = {
          typeErrors = true,
          nagaParsingErrors = true,
          nagaValidationErrors = true,
          nagaVersion = "main",
      }
  }
end

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
