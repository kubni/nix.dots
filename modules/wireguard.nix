{ lib, ...}: 

{
  networking.wg-quick.interfaces = let
    server_ip = "93.190.141.58";
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
	publicKey = "SPXmLWGJrr+NAcIALh7VadGZMqw0GZoceGO4VP2MEQo=";
        allowedIPs = [ "0.0.0.0/0" ];
        endpoint = "${server_ip}:51820";
      }];
    };
  };

  systemd.services.wg-quick-wg0.wantedBy = lib.mkForce [ ];
}
