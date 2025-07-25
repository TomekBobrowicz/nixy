# Zen is a minimalistic web browser.
{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  stylix.targets.zen-browser.profileNames = ["Profile0"];

  programs.zen-browser = {
    enable = true;
    profiles = {
      Profile0 = {
        # bookmarks, extensions, search engines...
      };
    };

    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;

      AutofillAddressesEnabled = false;
      AutoFillCreditCardEnabled = false;
      DisablePocket = true;
      DisableProfileImport = true;
      DisableSetDesktopBackground = true;
      DontCheckDefaultBrowser = true;
      HomepageURL = "https://google.com";
      StartPage = "homepage";
      NewTabPage = true;
      OfferToSaveLogins = false;
      # find more options here: https://mozilla.github.io/policy-templates/
    };
  };
}
