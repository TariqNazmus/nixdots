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
        ./hardware-configuration.nix
        ./nix-settings.nix
        ./nixpkgs.nix
        ./gc.nix
        ./screen.nix
        ./display-manager.nix
        ./theme.nix
        ./fonts.nix
        ./security-services.nix
        ./services.nix
        # ./printing.nix
        # ./gnome.nix
        ./hyprland.nix
        ./environment-variables.nix
        ./bluetooth.nix
        ./networking.nix
        # ./mac-randomize.nix
        # ./open-ssh.nix
        ./mosh.nix
        ./firewall.nix
        ./dns.nix
        ./vpn.nix
        ./users.nix
        ./virtualisation.nix
        ./programming-languages.nix
        ./lsp.nix
        ./rust.nix
        ./radicle.nix
        ./wasm.nix
        ./info-fetchers.nix
        ./utils.nix
        ./terminal-utils.nix
        ./llm.nix
        ./work.nix
      ];
    };
  };
}