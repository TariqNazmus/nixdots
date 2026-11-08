{ pkgs, ... }:

{
  # Keep Bash as the system/GNOME default, but fully configure Fish
  programs.fish.enable = true;

  # Set default shell. Require fish enabled first.
  users.users.sadat.shell = pkgs.fish;
  environment.systemPackages = with pkgs; [
    btop
    eza
    fzf
    git
    lazygit
    lazydocker
    ncdu
    ripgrep
    wezterm
    zellij
  ];

  # Fonts used in your custom wezterm.lua
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    fira-code
    #symbola
    terminus_font
    font-awesome
    material-icons
    maple-mono.NF
    nerd-fonts.im-writing
    nerd-fonts.blex-mono
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-monochrome-emoji
  ];
}
