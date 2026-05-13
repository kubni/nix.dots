{ lib, ...}: 

{
  networking.wg-quick.interfaces = let
    server_ip = "";
  in {
    wg0 = {
      # IP address of this machine in the *tunnel network*
      address = [ "10.2.0.2/32" ];
      dns = [ "10.2.0.1" ];
      # To match firewall allowedUDPPorts (without this wg
      # uses random port numbers).
      listenPort = 51820;

      # Path to the private key file.
      privateKeyFile = "/etc/private-vpn.key";

      peers = [{
	publicKey = "changeme";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "${server_ip}:51820";
      }];
    };
  };

  systemd.services.wg-quick-wg0.wantedBy = lib.mkForce [ ];
}
