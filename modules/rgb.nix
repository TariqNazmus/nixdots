{ pkgs, ... }:

{
  # Enable OpenRGB daemon, udev rules, and Intel SMBus kernel modules
  services.hardware.openrgb = {
    enable = true;
    motherboard = "intel";
    package = pkgs.openrgb-with-all-plugins;
  };

  # Enable I2C device nodes (/dev/i2c-*) for RAM and RTX 4070 SUPER RGB control
  hardware.i2c.enable = true;

  # Allow your user to access I2C buses without sudo
  users.users."sadat".extraGroups = [ "i2c" ];

  environment.systemPackages = with pkgs; [
    i2c-tools
  ];
}
