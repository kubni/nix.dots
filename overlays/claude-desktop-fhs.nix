final: prev: {
  claude-desktop-fhs = final.buildFHSEnv {
    name = "claude-desktop";

    targetPkgs = pkgs: (with pkgs; [
      # --- upstream targetPkgs (keep in sync with nix/fhs.nix) ---
      claude-desktop
      docker
      docker-compose
      glibc
      nodejs
      openssl
      uv

      # --- added: reproducible Python env, packages baked into the store ---
      (python3.withPackages (ps: with ps; [
        pip            # so `pip install` of extras still works ad-hoc
        lxml
        python-pptx
        # add whatever you need here
      ]))
    ]);

    # runScript = "${final.claude-desktop}/bin/claude-desktop";
    runScript = "env CLAUDE_USE_WAYLAND=1 ${final.claude-desktop}/bin/claude-desktop";

    extraInstallCommands = ''
      # Copy desktop file
      mkdir -p $out/share/applications
      cp ${final.claude-desktop}/share/applications/* $out/share/applications/

      # Copy icons
      mkdir -p $out/share/icons
      cp -r ${final.claude-desktop}/share/icons/* $out/share/icons/
    '';

    meta = final.claude-desktop.meta // {
      description = "Claude Desktop for Linux (FHS env for MCP servers, +python)";
    };
  };
}
