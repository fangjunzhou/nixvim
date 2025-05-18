{ helpers, pkgs, ... }:

{
  extraPlugins = with pkgs.vimPlugins; [
    neoformat
  ];

  # Formatter packages
  extraPackages = with pkgs; [
    # Nix
    nixpkgs-fmt
    # C, C++, C#, and Java
    astyle
    llvmPackages_19.clang-tools
    # CMake
    cmake-format
  ];

  # Auto format auto command
  autoCmd = [
    {
      event = [ "BufWritePre" ];
      pattern = [ "*.slang" ];
      command = ''lua vim.lsp.buf.format({ async = false })'';
    }
    {
      event = [ "BufWritePre" ];
      pattern = [ "*" ];
      command = ''lua if vim.bo.filetype ~= "slang" then vim.cmd("Neoformat") end'';
    }
  ];

  extraConfigLua = ''
    vim.g.neoformat_enabled_slang = { "clangformat" }

    vim.g.neoformat_java_astyle = {
      exe = "${pkgs.astyle}/bin/astyle",
      args = {
        "--style=google",
        "--indent=spaces=2",
        "--max-code-length=80",
      },
      stdin = true,
    }
    vim.g.neoformat_cpp_clangformat = {
      exe = "${pkgs.llvmPackages_19.clang-tools}/bin/clang-format",
      args = {
        "--style=file",
        "--fallback-style=google",
      },
      stdin = true,
    }
    vim.g.neoformat_json_jq = {
      exe = "${pkgs.jq}/bin/jq",
      args = { "." },
      stdin = true,
      valid_exit_codes = { 0 },
    }
  '';
}
