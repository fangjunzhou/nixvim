{ pkgs, helpers, ... }:

{
  plugins.lsp = {
    enable = true;
    capabilities = ''
      capabilities = require("cmp_nvim_lsp").default_capabilities()
    '';
    servers = {
      cmake = {
        enable = true;
      };
      clangd = {
        enable = true;
        package = pkgs.llvmPackages_19.clang-tools;
        filetypes = [
          "c"
          "cpp"
          "objc"
          "objcpp"
        ];
      };
      sourcekit = {
        enable = true;
        cmd = [
          "xcrun"
          "--toolchain"
          "swift"
          "sourcekit-lsp"
        ];
        filetypes = [
          "swift"
        ];
        settings = {
          capabilities = {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true;
              };
            };
            textDocument = {
              diagnostic = {
                dynamicRegistration = true;
                relatedDocumentSupport = true;
              };
            };
          };
        };
      };
      pyright = {
        enable = true;
      };
      lua_ls = {
        enable = true;
      };
      nil_ls = {
        enable = true;
      };
    };
  };

  extraConfigLua = builtins.readFile (./lsp.lua);
}
