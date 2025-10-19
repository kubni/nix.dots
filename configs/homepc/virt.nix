{ pkgs, ...}:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = false;
      };
    };
    spiceUSBRedirection.enable = true;
  };

}


