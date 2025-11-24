{ pkgs, firefox-addons, lib, ... }: let
  customAddons = pkgs.callPackage ./addons.nix {
    inherit lib;
    inherit (firefox-addons.lib.${pkgs.system}) buildFirefoxXpiAddon;
  };
in
{
  programs = {
    # librewolf = {
    #   enable = true;
    # };
    chromium.enable = true;
    firefox = {
      enable = true;
      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_ever_enabled" = true;

          # Privacy settings
          "privacy.donottrackheader.enabled" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.partition.network_state.ocsp_cache" = true;

          # Disable all sorts of telemetry
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.updatePing.enabled" = false;

          # As well as Firefox 'experiments'
          "experiments.activeExperiment" = false;
          "experiments.enabled" = false;
          "experiments.supported" = false;
          "network.allow-experiments" = false;

          # Disable Pocket Integration
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "extensions.pocket.enabled" = false;
          "extensions.pocket.api" = "";
          "extensions.pocket.oAuthConsumerKey" = "";
          "extensions.pocket.showHome" = false;
          "extensions.pocket.site" = "";

          # Tabs
          "browser.tabs.groups.enabled" = true;
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;

          # Disable suggestions
          "browser.search.suggest.enabled" = false;

        };
        userChrome = ''
          #titlebar { display: none; }
          .urlbar-input-box { text-align: center; }
          #nav-bar { margin: 3px; }
          #urlbar:not([focused]) #urlbar-background { opacity: 0 !important; }

          * {
              font-family: "monospace";
          }

          .browserContainer browser {
              border-radius: 5px !important;
              /* margin: 0vh 1vh 2vh 0vh; */
          }

          #navigator-toolbox {
              max-height: 2vh;

              & * {
                  opacity: 0;
              }
          }

          #navigator-toolbox:hover {
              max-height: 100vh;
              height: auto;

              & * {
                  opacity: 1;
              }
          }
        '';
        extensions.packages = with firefox-addons.packages.${pkgs.system}; [
          bitwarden
          darkreader
          ublock-origin
        ] ++ (with customAddons; [ minimalist-nord ]);
      };
    };
  };
}
