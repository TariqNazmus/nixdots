{ lib, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # Wait 3 seconds before booting the highlighted entry
  boot.loader.timeout = 3;

  boot.loader.limine = {
    enable = true;
    efiSupport = true;
    maxGenerations = 10;

    # Remember and autoselect the last booted OS (NixOS or Windows)
    extraConfig = ''
      remember_last_entry: yes
    '';

    extraEntries = ''
      /Windows 11
          protocol: efi
          path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
    '';

    # CachyOS (Catppuccin Mocha) visual theme
    style = {
      backdrop = "11111b";

      interface = {
        branding = "NixOS Limine";
      };

      graphicalTerminal = {
        # 80 = ~50% transparency over the background wallpaper, 1e1e2e = Mocha base
        background = "801e1e2e";
        foreground = "cdd6f4";
        brightBackground = "313244";
        brightForeground = "cdd6f4";

        # Semicolon-separated 8-color ANSI palettes (no 0x or # prefix)
        palette = "1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4";
        brightPalette = "585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    efibootmgr
  ];
}
