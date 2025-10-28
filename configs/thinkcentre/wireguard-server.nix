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
          name = "pocophone";
          publicKey = "mXkGVmujt+/glLeI2tuVS83+KdtrEZX2H0onF2bUnX8=";
          allowedIPs = [ "10.10.0.2/32" ];
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
