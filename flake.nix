{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # TODO: Change the lldb package from merged commit to unstable branch after freeze
    # Use nixpkgs commit with fixed lldb fix (Currently in breaking change freeze)
    nixpkgs-lldb.url = "github:nixos/nixpkgs?rev=8c429107e982d4debdb67f2c3e3402a23a308f05";
    nixpkgs-cmp-dict.url = "github:nixos/nixpkgs?rev=e5d1c87f5813afde2dda384ac807c57a105721cc";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
    wgsl-analyzer.url = "github:wgsl-analyzer/wgsl-analyzer";
  };

  outputs =
    { nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, system, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          pkgs-cmp-dict = import inputs.nixpkgs-cmp-dict { inherit system; };
          pkgs-lldb = import inputs.nixpkgs-lldb { inherit system; };
          pkg-wgsl-analyzer = inputs.wgsl-analyzer.packages.${system}.default;
          nixvimModule = {
            inherit pkgs;
            module = import ./config; # import the module directly
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            extraSpecialArgs = {
              inherit system;
              inherit pkgs-cmp-dict;
              inherit pkgs-lldb;
              inherit pkg-wgsl-analyzer;
            };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          packages = {
            # Lets you run `nix run .` to start nixvim
            default = nvim;
          };
        };
    };
}
