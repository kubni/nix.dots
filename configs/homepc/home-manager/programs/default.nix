{ pkgs, ... }: {

  imports = [
    ./hyprland
    ./kdeconnect.nix
    # ./mangowc.nix
    ./mpv
  ];

  programs = {
    obs-studio.enable = true;
    opencode = {
      enable = true;
      settings = {
        provider = {
          "llama-local" = {
            name = "Llama.cpp (GPU)";
            npm = "@ai-sdk/openai-compatible";
            options = {
              baseURL = "http://localhost:8080/v1"; # or your GPU server IP
            };
            models = {
              "unsloth/Qwen3.6-35B-A3B-GGUF" = {
                name = "Qwen3.6-35B-A3B Q4_K_M";
              };
            };
          };
        };
      };
    };
  };

  # Install some commonly found programs that don't need additional configs
  # home.packages = with pkgs; [
  #   fastfetch
  #   lsd
  #   vesktop
  #   mangohud
  #   jellyfin-media-player
  #   jellyfin-mpv-shim
  #   libreoffice-qt6-fresh
  #   pandoc
  #   foliate
  #   qview
  #   viber
  #   freetube
  #   zathura
  #   thunderbird-latest
  #   browsh
  #   wezterm
  #   bottles
  #   # webcord-vencord
  #   signal-desktop
  #   prismlauncher

  #   (pkgs.lutris.override {
  #     extraPkgs = pkgs: [
  #       pkgs.wineWow64Packages.stagingFull
  #       pkgs.winetricks
  #     ];
  #   })
  # ];
}
