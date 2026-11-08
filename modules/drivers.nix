{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Enable all redistributable firmware (Z790 Wi-Fi 6E, Bluetooth, Audio, 2.5GbE LAN)
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  # Enable onboard Z790 Bluetooth 5.3 for GNOME Quick Settings
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # OpenGL / Vulkan / VA-API Hardware Acceleration (64-bit + 32-bit for Steam/Wine)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver # Hardware video decoding on NVIDIA + Wayland
      intel-media-driver # QuickSync VA-API if i7-13700K iGPU is enabled in BIOS
      vpl-gpu-rt # Intel OneVPL runtime for 13th-gen Raptor Lake
    ];
  };

  # Load the NVIDIA driver for Xorg and GNOME Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Required for GNOME Wayland
    modesetting.enable = true;

    # Saves VRAM to /tmp on suspend/wakeup to prevent black screens after sleep
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    # NVIDIA open-source kernel module (recommended for RTX 4070 SUPER / Ada Lovelace)
    open = true;

    # Enable the `nvidia-settings` GUI/CLI utility
    nvidiaSettings = true;

    # Use the stable production driver for the active kernel
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Useful GPU monitoring tools
  environment.systemPackages = with pkgs; [
    nvtopPackages.full # Interactive terminal monitor for NVIDIA + Intel GPUs
    vulkan-tools # Provides `vulkaninfo` for verifying Vulkan support
    mesa-demos # Provides `glxinfo` / `eglinfo`
  ];
}
