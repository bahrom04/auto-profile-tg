{
  description = "fak-yu-niks-okay";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      in {
        # Nix script formattar
        formatter = pkgs.alejandra;

        # Output package
        packages.default = pkgs.callPackage ./. {};
      } // {
        darwinModules.default = import ./module.nix;
      }
    );

}