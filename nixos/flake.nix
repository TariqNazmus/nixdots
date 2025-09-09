{
  description = "XNM's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
  };
#launches Hyprland using the Universal Wayland Session Manager (UWSM)
  outputs = { nixpkgs, ... } @ inputs:
  {
    nixosConfigurations.sadat = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        ./display-manager.nix
        ./hyprland.nix
        ./hardware-configuration.nix
        ./nix-settings.nix
        ./nixpkgs.nix
        ./programming-languages.nix
        ./security-services.nix
        ./services.nix
        ./theme.nix
        ./users.nix
        ./utils.nix
      ];
    };
  };
}