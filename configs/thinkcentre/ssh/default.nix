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
    };
  };

  # Insert the TOTP module into sshd's PAM stack.
  security.pam.services.sshd.googleAuthenticator.enable = true;

}
