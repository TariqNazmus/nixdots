{ inputs, ... }:
{
  flake.nixosConfigurations = {
    nixos = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./nixos/configuration.nix
        (inputs.self + "/modules")
      ];
    };
  };
}
