{ pkgs, ... }:

{
  # 1. Auto-load project flake devShells on `cd` (hooks into Bash/Zsh automatically)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # 2. Docker Engine & RTX 4070 SUPER GPU passthrough
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };
  hardware.nvidia-container-toolkit.enable = true;
  users.users."sadat".extraGroups = [ "docker" ];

  # 3. Dynamic libraries so Python (uv/pip/venv) C-extensions & Node binaries run natively
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      zstd
      openssl
      curl
      glib
      libxml2
      libffi
      sqlite
    ];
  };

  # 4. Baseline CLI tools & TUI managers
  environment.systemPackages = with pkgs; [
    uv             # Fast Python package & virtualenv manager
    pnpm           # Fast Node.js package manager
    bun            # JS runtime & bundler
    docker-compose # Multi-container runner
    lazydocker     # Terminal UI for Docker (pairs with lazygit)
  ];
}
