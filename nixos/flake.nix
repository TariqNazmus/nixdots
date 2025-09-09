{
  description = "XNM's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
#launches Hyprland using the Universal Wayland Session Manager (UWSM)
  outputs = { nixpkgs, ... } @ inputs:
  {
    nixosConfigurations.sadat = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        #./bluetooth.nix
        ./configuration.nix
        #./display-manager.nix
        ./hardware-configuration.nix
        #./hyprland.nix
        ./nix-settings.nix
        ./nixpkgs.nix
        #./programming-languages.nix
        ./security-services.nix
        ./services.nix
        #./theme.nix
        ./users.nix
        ./utils.nix
      ];
    };
  };
}