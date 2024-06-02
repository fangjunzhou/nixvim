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
    clang-tools
    # CMake
    cmake-format
  ];

  # Auto format auto command
  autoCmd = [
    {
      event = [ "BufWritePre" ];
      command = "Neoformat";
    }
  ];

  extraConfigLua = ''
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
      exe = "${pkgs.clang-tools}/bin/clang-format",
      args = {
        "--style=file",
        "--fallback-style=google",
      },
      stdin = true,
    }
  '';
}
