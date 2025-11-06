{ lib, ...}: 

{
  networking.wg-quick.interfaces = let
    server_ip = "109.236.81.166";
  in {
    wg0 = {
      # IP address of this machine in the *tunnel network*
      address = [ "10.2.0.2/32" ];
      dns = [ "10.2.0.1" ];
      # To match firewall allowedUDPPorts (without this wg
      # uses random port numbers).
      listenPort = 51820;

      # Path to the private key file.
      privateKeyFile = "/etc/proton-vpn.key";

      peers = [{
	publicKey = "g6DkXWKI/68RsLjROIwCEcyB/ZhyK5Q7OWcz1TtqER0=";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "${server_ip}:51820";
      }];
    };
  };

  systemd.services.wg-quick-wg0.wantedBy = lib.mkForce [ ];
}
