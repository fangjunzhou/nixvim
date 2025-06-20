{ pkgs, pkgs-unstable, ... }:

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
        enable = false;
        package = pkgs.llvmPackages_19.clang-tools;
        settings = {
          filetypes = [
            "c"
            "cpp"
          ];
        };
      };
      sourcekit = {
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
