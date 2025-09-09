{
  description = "XNM's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
  };
#launches Hyprland using the Universal Wayland Session Manager (UWSM)
  outputs = { nixpkgs, ... }:
  {
    let
      system = "x86_64-linux";
    in {
    nixosConfigurations.sadat = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        #./bluetooth.nix
        ./configuration.nix
        #./display-manager.nix
        ./hardware-configuration.nix
        #./hyprland.nix
        ./nix-settings.nix
        ./nixpkgs.nix
        #./programming-languages.nix
        #./security-services.nix
        #./services.nix
        #./theme.nix
        ./users.nix
        #./utils.nix
      ];
    };
    };

  };
}