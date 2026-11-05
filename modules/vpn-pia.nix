{ config, pkgs, ... }:

{
  services.pia = {
    enable = true;
    protocol = "wireguard";

    # Option A: Reference a local root-only credential file on disk 
    # (Create /etc/nixos/pia-credentials containing username on line 1, password on line 2)
    credentials.credentialsFile = "/etc/nixos/pia-credentials";

    # Auto-connect on system boot (Run `pia list` in terminal post-install to see valid regions)
    autoConnect = {
      enable = false;
      region = "japan"; 
    };

    portForwarding.enable = true;
    dns.enable = true;
  };
}
