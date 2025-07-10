{ buildFirefoxXpiAddon, lib }:

{
  minimalist-nord = buildFirefoxXpiAddon rec {
    pname = "minimalist_nord";
    version = "2.3";
    addonId = "{e42266c1-3e10-4955-a63c-cdffcc999d2f}";
    url = "https://addons.mozilla.org/firefox/downloads/file/3991486/${pname}-${version}.xpi";
    sha256 = "sha256-Ixec+SosjKXdPzpw32Bcm1jqrVP6EtQmvKalwUM2NRs=";
    meta = with lib;
      {
        homepage = "https://github.com/canbeardig/MinimalistFox";
        description = "Minimalist Firefox themes based on popular colour schemes.";
        license = licenses.mpl20;
        platforms = platforms.all;
      };
  };
}
