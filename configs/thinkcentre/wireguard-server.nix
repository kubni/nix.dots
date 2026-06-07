{ config, pkgs, ... }:
{
 networking.firewall.allowedUDPPorts = [ 51820 ];
 networking.nat = {
    enable = true;
    enableIPv6 = false;
    externalInterface = "eno1"; 
    internalInterfaces = [ "wg0" ];
  };

  networking.wireguard = {
    enable = true;
    interfaces.wg0 = {
      ips = [ "10.10.0.1/24" ];
      listenPort = 51820;
      privateKeyFile = "/var/wireguard/wg0";
      peers = [
        {
          name = "debian";
          publicKey = "/UphPjmK59RE4aaZRaMJJoux3c6l5M0f9CG60FAFNXQ=";
          allowedIPs = [ "10.10.0.3/32" ];
        }
        {
          name = "legion";
          publicKey = "xkwJCFSxnXJVVsOi53teVQd/8dFfXGDsfcLt6mmauyA=";
          allowedIPs = [ "10.10.0.4/32" ];
        }
        {
          name = "pixel";
          publicKey = "KF4n0dlHds91rVv/HZGtNNgflgY6X2SsbJPUL/ATA1I=";
          allowedIPs = [ "10.10.0.6/32" ];
        }
      ];

      postSetup = ''
       ${pkgs.iptables}/bin/iptables -A FORWARD -i wg0 -j ACCEPT
       ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.10.0.0/24 -o eno1 -j MASQUERADE
      '';

      # Undo the above
      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -D FORWARD -i wg0 -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.10.0.0/24 -o eno1 -j MASQUERADE
      '';                 
    };
  };
}
