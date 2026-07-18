{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.google-authenticator ];

  services.openssh = {
    enable = true;
    settings = {
      UsePAM = true;
      KbdInteractiveAuthentication = true;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      AuthenticationMethods = "publickey,keyboard-interactive";
    };
  };

  # Insert the TOTP module into sshd's PAM stack.
  # security.pam.services.sshd.googleAuthenticator.enable = true;

  # Workaround found in https://github.com/NixOS/nixpkgs/issues/115044
  # Apparently, googleAuthenticator.enable = true; doesn't work if PasswordAuthentication is set to false.
  # TODO: Check whether to allow nullok
  security.pam.services = {
    sshd.text = ''
      account required pam_unix.so # unix (order 10900)

      auth required ${pkgs.google-authenticator}/lib/security/pam_google_authenticator.so no_increment_hotp # google_authenticator (order 12500)
      auth sufficient pam_permit.so

      session required pam_env.so conffile=/etc/pam/environment readenv=0 # env (order 10100)
      session required pam_unix.so # unix (order 10200)
      session required pam_loginuid.so # loginuid (order 10300)
      session optional ${pkgs.systemd}/lib/security/pam_systemd.so # systemd (order 12000)
    '';
  };

}
