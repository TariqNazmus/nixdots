{
  description = "Python Dev Environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          python312
          uv
          ruff
          pyright
        ];

        shellHook = ''
          if [ ! -d ".venv" ]; then
            uv venv .venv
          fi
          source .venv/bin/activate
        '';
      };
    };
}
