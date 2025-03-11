{ pkgs, lib, inputs, config, ... }:
let
  cfg = config.firefox;
  profileName = "Morten";
  dependencies = [ ];
  extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
    bitwarden
    ublock-origin
    sponsorblock
  ];
  bookmarks = [
  {
    name = "Toolbar Bookmarks";
    toolbar = true;
    bookmarks = [
        { name = "Mail"; tags = [ "mail" ]; url = "https://outlook.live.com/mail/0"; }
        { name = "Moodle"; url = "https://www.moodle.aau.dk/my/"; }
        { name = "GitHub"; url = "https://github.com/"; }
        { name = "Overleaf"; url = "https://www.overleaf.com/project"; }
        { name = "OneNote"; url = "https://aaudk-my.sharepoint.com/personal/"; }
      ];
    }
  ];
  searchEngines = {
    "Google" = { 
      definedAliases = [ "@g" ];
      metaData = { hidden = true; }; 
    };
    "GitHub" = {
      urls = [{ template = "https://github.com/search?q={searchTerms}&type=repositories"; }];
      definedAliases = [ "@gh" ];
    };
    "Youtube" = {
      urls = [{ template = "https://www.youtube.com/results?search_query={searchTerms}"; }];
      definedAliases = [ "@yt" ];
    };
    "Nix Packages" = {
      urls = [{
        template = "https://search.nixos.org/packages";
        params = [
          { name = "type"; value = "packages"; }
          { name = "query"; value = "{searchTerms}"; }
        ];
      }];
      definedAliases = [ "@np" ];
    };
    "Amazon.com" = { metaData = { hidden = true; }; };
    "Bing" = { metaData = { hidden = true; }; };
    "DuckDuckGo" = { metaData = { hidden = true; }; };
    "eBay" = { metaData = { hidden = true; }; };
    "google" = { metaData = { hidden = true; }; };
    "Wikipedia (en)" = { metaData = { hidden = true; }; };
  };
  defaultSettings = {
    # Disable irritating first-run stuff
    "browser.disableResetPrompt" = true;
    "browser.download.panel.shown" = true;
    "browser.feeds.showFirstRunUI" = false;
    "browser.messaging-system.whatsNewPanel.enabled" = false;
    "browser.rights.3.shown" = true;
    "browser.shell.checkDefaultBrowser" = false;
    "browser.shell.defaultBrowserCheckCount" = 1;
    "browser.startup.homepage_override.mstone" = "ignore";
    "browser.uitour.enabled" = false;
    "startup.homepage_override_url" = "";
    "trailhead.firstrun.didSeeAboutWelcome" = true;
    "browser.bookmarks.restore_default_bookmarks" = false;
    "browser.bookmarks.addedImportButton" = true;

    # Credit Card Settings
    "extensions.formautofill.creditCards.enabled" = false;
    "services.sync.engine.creditcards.available" = true;

    # UI Options
    "browser.compactmode.show" = true;
    "browser.uidensity" = 1;
    "browser.tabs.tabmanager.enabled" = false;
    "browser.fullscreen.autohide" = false;
    "browser.toolbars.bookmarks.visibility" = "always";
    "sidebar.position_start" = false;

    # Prevent window from closing when last tab is closed
    "browser.tabs.closeWindowWithLastTab" = false;

    # Remove unwanted features
    "extensions.pocket.enabled" = false; # pocket
    "identity.fxaccounts.enabled" = false; # firefox sync
    "signon.rememberSignons" = false; # asking to save passwords

    # Auto-enable extensions
    "extensions.autoDisableScopes" = 0;
    "extensions.enabledScopes" = 15;

    # Miscellaneous options
    "general.autoScroll" = false; # Enable autoscrolling
    "browser.aboutConfig.showWarning" = false; # Prevent about:config warning
  };
in {
  imports = [ ];

  options = {
    firefox.enable = lib.mkEnableOption "enables firefox";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home = {
        packages = dependencies;
      };

      programs.firefox = {
        enable = true;
        profiles = {
          "${profileName}" = {
            name = "${profileName}";
            isDefault = true;
            extensions = extensions;
            search = {
              force = true;
              default = "Google";
              engines = searchEngines;
              order = [
                "Google"
                "GitHub"
                "Youtube"
                "Nix Packages"
              ];
            };
            settings = defaultSettings;
            bookmarks = bookmarks;
          };
        };
        policies.ExtensionSettings = {
            # pin bitwarden to the navbar
            "446900e4-71c2-419f-a6a7-df9c091e268b" = { default_area = "navbar"; }; # Extension ID for bitwarden
        };
      };

      xdg = {
        enable = true;
        mimeApps.enable = true;
        mimeApps.defaultApplications = {
          "text/html" = ["firefox.desktop"];
          "text/xml" = ["firefox.desktop"];
          "x-scheme-handler/http" = ["firefox.desktop"];
          "x-scheme-handler/https" = ["firefox.desktop"];
        };
      };
    }
  ]);
}
