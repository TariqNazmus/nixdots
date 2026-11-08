{ pkgs, ... }:

{
  # Keep Bash as the system/GNOME default, but fully configure Fish
  programs.fish.enable = true;

  # Set default shell. Require fish enabled first.
  users.users.sadat.shell = pkgs.fish;
  environment.systemPackages = with pkgs; [
    wezterm
    zellij
  ];

  # Fonts used in your custom wezterm.lua
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    fira-code
  ];
}
