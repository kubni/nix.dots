{ pkgs, ...}:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = false;
        ovmf = {
          enable = true;
          # packages = [ pkgs-stable.OVMF.fd ];
          packages = [ pkgs.OVMF.fd ];
        };
        #verbatimConfig = ''
        #  nvram = [ "${pkgs.OVMF}/FV/OVMF.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd" ]
        #'';
      };
    };
    spiceUSBRedirection.enable = true;
  };

}


