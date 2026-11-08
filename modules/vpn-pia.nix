{ config, pkgs, ... }:

let
  # Declarative Kill Switch & GNOME Desktop Notification helper
  pia-ks = pkgs.writeShellScriptBin "pia-ks" ''
    ACTION="''${1:-status}"
    case "$ACTION" in
      on)
        # Create a dedicated iptables chain that drops all traffic not going through 'pia'
        sudo ${pkgs.iptables}/bin/iptables -N PIA-KILLSWITCH 2>/dev/null || sudo ${pkgs.iptables}/bin/iptables -F PIA-KILLSWITCH
        sudo ${pkgs.iptables}/bin/iptables -A PIA-KILLSWITCH -o lo -j ACCEPT
        sudo ${pkgs.iptables}/bin/iptables -A PIA-KILLSWITCH -o pia -j ACCEPT
        sudo ${pkgs.iptables}/bin/iptables -A PIA-KILLSWITCH -d 192.168.0.0/16,10.0.0.0/8,172.16.0.0/12 -j ACCEPT
        sudo ${pkgs.iptables}/bin/iptables -A PIA-KILLSWITCH -p udp --dport 1337 -j ACCEPT
        sudo ${pkgs.iptables}/bin/iptables -A PIA-KILLSWITCH -j REJECT
        sudo ${pkgs.iptables}/bin/iptables -C OUTPUT -j PIA-KILLSWITCH 2>/dev/null || sudo ${pkgs.iptables}/bin/iptables -I OUTPUT 1 -j PIA-KILLSWITCH
        ${pkgs.libnotify}/bin/notify-send -u critical -i network-vpn-symbolic "PIA Kill Switch Enabled" "All non-VPN traffic is now blocked."
        echo "Kill switch ENABLED (non-VPN traffic blocked)."
        ;;
      off)
        sudo ${pkgs.iptables}/bin/iptables -D OUTPUT -j PIA-KILLSWITCH 2>/dev/null || true
        sudo ${pkgs.iptables}/bin/iptables -F PIA-KILLSWITCH 2>/dev/null || true
        sudo ${pkgs.iptables}/bin/iptables -X PIA-KILLSWITCH 2>/dev/null || true
        ${pkgs.libnotify}/bin/notify-send -u normal -i changes-allow-symbolic "PIA Kill Switch Disabled" "Direct internet traffic is allowed."
        echo "Kill switch DISABLED."
        ;;
      status)
        if sudo ${pkgs.iptables}/bin/iptables -C OUTPUT -j PIA-KILLSWITCH 2>/dev/null; then
          echo "Kill switch: ACTIVE"
        else
          echo "Kill switch: INACTIVE"
        fi
        ;;
      *)
        echo "Usage: pia-ks [on|off|status]"
        ;;
    esac
  '';
in
{
  services.pia = {
    enable = true;
    protocol = "wireguard";
    credentials.credentialsFile = "/etc/nixos/pia-credentials";

    autoConnect = {
      enable = true;
      region = "japan";
    };

    portForwarding.enable = true;
    dns.enable = true;
  };

  # Symlink /run/secrets/pia -> /etc/nixos/pia-credentials so 'pia' CLI finds it by default
  systemd.tmpfiles.rules = [
    "d /run/secrets 0755 root root -"
    "L+ /run/secrets/pia - - - - /etc/nixos/pia-credentials"
  ];

  environment.systemPackages = with pkgs; [
    pia-ks
    libnotify
    gnome-extension-manager
    gnomeExtensions.executor
  ];
}
