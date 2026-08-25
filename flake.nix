{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-cmp-dict.url = "github:nixos/nixpkgs?rev=e5d1c87f5813afde2dda384ac807c57a105721cc";
    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
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
          pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
          pkgs-unfree = import inputs.nixpkgs { inherit system; config.allowUnfree = true; };
          pkgs-cmp-dict = import inputs.nixpkgs-cmp-dict { inherit system; };
          nixvim-module = {
            inherit pkgs;
            module = import ./config; # import the module directly
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            extraSpecialArgs = {
              inherit system;
              inherit pkgs-unstable;
              inherit pkgs-unfree;
              inherit pkgs-cmp-dict;
            };
          };
          nvim = nixvim'.makeNixvimWithModule nixvim-module;
        in
        {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvim-module;
          };

          packages = {
            # Lets you run `nix run .` to start nixvim
            default = nvim;
          };
        };
    };
}
