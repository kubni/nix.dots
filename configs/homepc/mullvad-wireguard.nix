{ lib, ...}: 

{
  networking.wg-quick.interfaces = let
    server_ip = "146.70.193.2";
  in {
    wg0 = {
      # IP address of this machine in the *tunnel network*
      address = [ "10.71.17.66/32" ];
      dns = [ "10.64.0.1" ];
      # To match firewall allowedUDPPorts (without this wg
      # uses random port numbers).
      listenPort = 51820;

      # Path to the private key file.
      privateKeyFile = "/etc/mullvad-vpn.key";

      peers = [{
        publicKey = "Orrce1127WpljZa+xKbF21zJkJ9wM1M3VJ5GJ/UsIDU=";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "${server_ip}:51820";
        persistentKeepalive = 25;
      }];
    };
  };

  systemd.services.wg-quick-wg0.wantedBy = lib.mkForce [ ];
}
