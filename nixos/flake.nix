{
  description = "XNM's NixOS Configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
  };
#launches Hyprland using the Universal Wayland Session Manager (UWSM)
  outputs = { nixpkgs, ... } @ inputs:
  {
    let
      system = "x86_64-linux";
      overlay-unstable = final: prev: {
        unstable = nixpkgs-unstable.legacyPackages.${prev.system};
        # use this variant if unfree packages are needed:
        # unstable = import nixpkgs-unstable {
        #   inherit system;
        #   config.allowUnfree = true;
        # };

      };
    in {
    nixosConfigurations.sadat = nixpkgs.lib.nixosSystem {
      inherit system;
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