{ pkgs, ... }: {

  imports = [
    ./hyprland
    ./kdeconnect.nix
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
              baseURL = "http://localhost:8080/v1";
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

}
