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
        { name = "SharePoint"; url = "https://aaudk-my.sharepoint.com/"; }
      ];
    }
  ];
  bookmarksCERN = [
    {
      name = "Toolbar Bookmarks";
      toolbar = true;
      bookmarks = [
        { name = "Mattermost"; url = "https://mattermost.web.cern.ch/"; }
        { name = "Jira"; url = "https://its.cern.ch/jira/secure/RapidBoard.jspa?rapidView=7926&projectKey=OS&view=planning.nodetail&quickFilter=22503&issueLimit=100#"; }
        { name = "GitLab"; url = "https://gitlab.cern.ch/";}
        { name = "Mail"; tags = [ "mail" ]; url = "https://outlook.live.com/mail/0"; }
        { name = "EDH"; url = "https://edh.cern.ch/";}
        { name = "IRC - Ironic"; url = "https://www.irccloud.com/irc/oftc/channel/openstack-ironic"; }
        {
          name = "Docs";
          bookmarks = [
            { name = "CCI - Internal Docs"; url = "https://cci-internal-docs.web.cern.ch/"; }
            { name = "Cloud Docs"; url = "https://clouddocs.web.cern.ch/index.html"; }
            { name = "CCI - Architecture"; url = "https://cci-architecture.docs.cern.ch/"; }
        ];
        }
      ];
    }
  ];
  searchEngines = {
    "google" = {
      urls = [{ template = "https://www.google.com/search?q={searchTerms}"; }];
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
    "amazondotcom-fr" = { metaData = { hidden = true; }; };
    "bing" = { metaData = { hidden = true; }; };
    "ddg" = { metaData = { hidden = true; }; };
    "ebay" = { metaData = { hidden = true; }; };
    "wikipedia" = { metaData = { hidden = true; }; };
  };
  profiles = {
    "${profileName}" = {
      id = 0;
      name = "${profileName}";
      isDefault = false;
      extensions.packages = extensions;
      search = {
        force = false;
        default = "google";
        engines = searchEngines;
        order = [
          "google"
          "GitHub"
          "Youtube"
          "Nix Packages"
        ];
      };
      settings = defaultSettings;
      bookmarks = {
        force = true;
        settings = bookmarks;
      };
    };
    "CERN" = {
      id = 1;
      name = "CERN";
      isDefault = false;
      extensions.packages = extensions;
      search = {
        force = true;
        default = "google";
        engines = searchEngines;
        order = [
          "google"
          "GitHub"
          "Youtube"
          "Nix Packages"
        ];
      };
      settings = defaultSettings;
      bookmarks = {
        force = true;
        settings = bookmarksCERN;
      };
    };
  };
  # Dynamically inject isDefault into chosen profile
  adjustedProfiles =
    lib.mapAttrs (name: profile:
      profile // {
        isDefault = (name == cfg.defaultProfile);
      }
    ) profiles;
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
in
{
  imports = [ ];

  options = {
    firefox.enable = lib.mkEnableOption "enables firefox";
    firefox.defaultProfile = lib.mkOption {
      type = lib.types.str;
      default = "${profileName}";
      description = "Name of the default Firefox profile";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      home = {
        packages = dependencies;
      };

      programs.firefox = {
        enable = true;
        profiles = adjustedProfiles;
        policies.ExtensionSettings = {
          # pin bitwarden to the navbar
          "446900e4-71c2-419f-a6a7-df9c091e268b" = { default_area = "navbar"; }; # Extension ID for bitwarden
        };
      };

      xdg = {
        enable = true;
        mimeApps.enable = true;
        mimeApps.defaultApplications = {
          "text/html" = [ "firefox.desktop" ];
          "text/xml" = [ "firefox.desktop" ];
          "x-scheme-handler/http" = [ "firefox.desktop" ];
          "x-scheme-handler/https" = [ "firefox.desktop" ];
        };
      };
    }
  ]);
}
