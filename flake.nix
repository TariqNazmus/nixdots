{
  description = "Sadat's NixOS Flake (flake-parts)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    # Add the PIA flake input, locking it to nixpkgs
    pia.url = "github:mrehanabbasi/pia.nix";
    pia.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [
        ./hosts/flake-module.nix
        ./templates/flake-module.nix
      ];
    };
}
