# modules/terminal.nix
{ pkgs, ... }:

let
  weztermConfig = pkgs.writeText "wezterm.lua" ''
    local wezterm = require("wezterm")
    local config = wezterm.config_builder()

    -- Fix GNOME + NVIDIA window sizing, moving, and fullscreen bugs
    config.enable_wayland = false
    config.window_decorations = "TITLE | RESIZE"

    -- Automatically start Zellij with Fish as its shell
    config.default_prog = { "zellij", "options", "--default-shell", "fish" }

    -- Font & UI settings
    config.font_size = 13.5
    config.enable_tab_bar = false
    config.font = wezterm.font_with_fallback({
      "JetBrainsMono Nerd Font",
      "Fira Code",
    })

    -- Theme (neapsix / Rosé Pine)
    local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm").main
    config.colors = theme.colors()

    config.window_background_opacity = 1
    config.text_background_opacity = 1

    config.keys = {
      {
        key = "F11",
        action = wezterm.action.ToggleFullScreen,
      },
    }

    return config
  '';

  zellijConfig = pkgs.writeText "config.kdl" ''
    default_shell "fish"
  '';
in
{
  programs.fish = {
    enable = true;

    # Auto-bootstrap Tide if unconfigured and keep devShell indicators active
    interactiveShellInit = ''
      if not set -q _tide_left_items
        tide configure --auto \
          --style=Lean \
          --prompt_colors='True color' \
          --lean_prompt_height='Two lines' \
          --prompt_connection=Disconnected \
          --prompt_spacing=Compact \
          --icons='Many icons' \
          --transient=No
      end

      # Ensure Tide always displays nix-shell, direnv
      set -l desired_right status cmd_duration context jobs direnv nix_shell
      if test "$tide_right_prompt_items" != "$desired_right"; or test "$_tide_right_items" != "$desired_right"
        set -U tide_right_prompt_items $desired_right
        set -U _tide_right_items $desired_right
      end
    '';
  };
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
    fishPlugins.tide
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

  # Create user config files from the Nix store ONLY if they do not exist ('C')
  systemd.tmpfiles.rules = [
    "d /home/sadat/.config/wezterm 0755 sadat users -"
    "C /home/sadat/.config/wezterm/wezterm.lua 0644 sadat users - ${weztermConfig}"
    "d /home/sadat/.config/zellij 0755 sadat users -"
    "C /home/sadat/.config/zellij/config.kdl 0644 sadat users - ${zellijConfig}"
  ];
}
