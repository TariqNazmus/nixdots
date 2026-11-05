{ pkgs, ... }:

{
  # Enable Neovim and set it as the default system editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
# Install Nerd Fonts and set default monospace fallback
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.symbols-only # Universal fallback for missing icon glyphs
    ];
    fontconfig.defaultFonts.monospace = [
      "JetBrainsMono Nerd Font"
      "Symbols Nerd Font Mono"
    ];
  };
  # Crucial for Arch configs: allows Mason-downloaded LSPs/formatters to run on NixOS
  programs.nix-ld.enable = true;

  # Dependencies expected by lazy.nvim, nvim-treesitter, telescope, and Wayland clipboard
  environment.systemPackages = with pkgs; [
    gcc          # Required by nvim-treesitter to compile language parsers
    gnumake      # Required by telescope-fzf-native and build hooks
    unzip        # Required by Mason to extract packages
    wget         # Required by Mason/Lazy for fetching archives
    curl
    ripgrep      # Required by Telescope live_grep
    fd           # Required by Telescope find_files
    nodejs       # Required by many LSPs (e.g., ts_ls, pyright, copilot)
    python3      # Required by Python-based plugins/Mason tools
    wl-clipboard # Enables system clipboard (+ and * registers) on GNOME Wayland
  ];
}
