{ helpers, pkgs, ... }:

let
  matlabFormatter = pkgs.stdenvNoCC.mkDerivation {
    pname = "matlab-formatter-py";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "affenwiesel";
      repo = "matlab-formatter-vscode";
      rev = "43d722441dc6fcc41b1048010610c6ffe2087755";
      sha256 = "sha256-Mo2uVdeyES0/RpVGnWnN7CDpIT4z6RNHvUJcABip9z8=";
    };
    nativeBuildInputs = [ pkgs.makeWrapper ];
    installPhase = ''
      install -Dm644 formatter/matlab_formatter.py $out/share/matlab-formatter/matlab_formatter.py
      makeWrapper ${pkgs.python3}/bin/python $out/bin/matlab_formatter.py \
        --add-flags $out/share/matlab-formatter/matlab_formatter.py
    '';
  };
in
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
    # Swift
    swift-format
    # Matlab formatter
    matlabFormatter
  ];

  autoGroups = {
    FormatOnWrite = { };
  };

  # Auto format auto command
  autoCmd = [
    {
      group = "FormatOnWrite";
      event = [ "BufWritePre" ];
      pattern = [ "*.slang" ];
      command = ''lua vim.lsp.buf.format({ async = false })'';
    }
    {
      group = "FormatOnWrite";
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
    vim.g.neoformat_swift_swift_format = {
      exe = "xcrun",
      args = { "swift-format", "format", "-"},
      stdin = true,
      valid_exit_codes = { 0 },
    }
  '';
}
