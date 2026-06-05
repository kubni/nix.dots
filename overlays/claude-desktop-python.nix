final: prev: {
  claude-desktop-fhs = prev.buildFHSEnv {
    name = "claude-desktop";
    targetPkgs = pkgs: with prev; [
      claude-desktop
      docker
      docker-compose
      glibc
      nodejs
      openssl
      uv
      libreoffice
      (python3.withPackages (ps: with ps; [ python-pptx lxml openpyxl]))
    ];
    runScript = "${prev.claude-desktop}/bin/claude-desktop";
    extraInstallCommands = ''
      mkdir -p $out/share/applications
      cp ${prev.claude-desktop}/share/applications/* $out/share/applications/
      mkdir -p $out/share/icons
      cp -r ${prev.claude-desktop}/share/icons/* $out/share/icons/
    '';
    meta = prev.claude-desktop.meta // {
      description = "Claude Desktop for Linux (FHS environment for MCP servers)";
    };
  };
}
