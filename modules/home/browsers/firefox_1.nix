{ pkgs, inputs, ... }: # <-- Añadir inputs aquí

let
  # Obtener rycee directamente desde el input de NUR
  firefox-addons = inputs.nur.legacyPackages.${pkgs.stdenv.hostPlatform.system}.repos.rycee.firefox-addons;
in
{
  programs.firefox = {
    enable = true;

    # Políticas a nivel de sistema/navegador (instalación forzada)
    policies = {
      ExtensionSettings = {
        # 1Password
        "{d634138d-c276-4961-924b-14816a2d3e38}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
        };

        # Librezam
        "{c554e207-6426-444a-93be-33f749a0d922}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/librezam/latest.xpi";
        };

        # Trufflepiggy - Context Search
        "tp_cs_firefox_trufflepiggy_com" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/trufflepiggy-context-search/latest.xpi";
        };
      };
    };

    profiles.th3g3ntl3man = {
      id = 0;
      isDefault = true;

      # Declarar extensiones desde NUR
      extensions.packages = with firefox-addons; [
        ublock-origin
        vimium
        darkreader
        simple-translate
        sponsorblock
      ];

      # Preferencias internas de Firefox (about:config)
      settings = {
        "browser.startup.page" = 3; # Restaurar sesión anterior
        "browser.download.panel.shown" = true;
        "signon.rememberSignons" = false; # Desactivar gestor de contraseñas nativo
        "sidebar.verticalTabs" = true;
        "privacy.trackingprotection.enabled" = true;
        # Asegura que se muestre la página de nueva pestaña nativa
        "browser.newtabpage.enabled" = true;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

        # Configuración declarativa de tus accesos fijados
        "browser.newtabpage.pinned" = builtins.toJSON [
          {
            url = "https://github.com/jvegaf?tab=repositories";
            label = "Repos";
            baseDomain = "github.com";
          }
          {
            url = "https://github.com/jvegaf?tab=stars";
            label = "Stars";
            baseDomain = "github.com";
          }
          {
            url = "https://mail.google.com/mail/u/0/#inbox";
            label = "Recibidos - josevega234@gmail.com - Gmail";
            baseDomain = "mail.google.com";
          }
          {
            url = "https://www.youtube.com/";
            label = "youtube";
            baseDomain = "youtube.com";
          }
          {
            url = "http://192.168.8.1/";
            baseDomain = "192.168.8.1";
          }
          {
            url = "https://gemini.google.com/app";
            baseDomain = "gemini.google.com";
          }
          {
            url = "https://es.wallapop.com/search?latitude=40.309206&longitude=-3.723528&keywords=mini%20torno&order_by=newest&country_code=ES&saved_search_id=c3258265-763d-44a2-8ede-06cf76a3102c&source=stored_filters";
            baseDomain = "es.wallapop.com";
          }
          {
            url = "https://www.printables.com/@JoseVega_2707002/collections/liked";
            label = "Jose Vega | Printables.com";
            baseDomain = "printables.com";
          }
          {
            url = "https://www.thingiverse.com/";
            baseDomain = "thingiverse.com";
          }
          {
            url = "https://es.aliexpress.com/";
            baseDomain = "es.aliexpress.com";
          }
          {
            url = "http://www.as.com/";
            label = "as";
            baseDomain = "as.com";
          }
          {
            url = "https://www.marca.com/";
            label = "MARCA - Diario online líder en información deportiva";
            baseDomain = "marca.com";
          }
          {
            url = "http://192.168.8.177:4409/";
            label = "K1C";
            baseDomain = "192.168.8.177";
          }
          {
            url = "https://notebooklm.google.com/?icid=home_maincta&pli=1";
            label = "NotebookLM";
            baseDomain = "notebooklm.google.com";
          }
          null
          {
            url = "https://searchix.ovh/";
            label = "Searchix";
          }
          null
          null
          null
          {
            url = "https://drive.google.com/drive/";
            baseDomain = "drive.google.com";
          }
          {
            url = "https://hearthis.at/";
            label = "hearthis";
            baseDomain = "hearthis.at";
          }
          null
          null
          null
          null
          null
          null
          {
            url = "https://keep.google.com/#home";
            baseDomain = "keep.google.com";
          }
        ];

        "browser.uiCustomization.horizontalTabsBackup" = builtins.toJSON {
          placements = {
            widget-overflow-fixed-list = [ ];
            unified-extensions-area = [
              "chrome-gnome-shell_gnome_org-browser-action"
              "song-id_losnappas-browser-action"
              "_036a55b4-5e72-4d05-a06c-cba2dfcc134a_-browser-action"
              "_74145f27-f039-47ce-a470-a662b129930a_-browser-action"
              "tp_cs_firefox_trufflepiggy_com-browser-action"
              "librezam_librezam-browser-action"
            ];
            nav-bar = [
              "sidebar-button"
              "back-button"
              "forward-button"
              "stop-reload-button"
              "customizableui-special-spring1"
              "vertical-spacer"
              "urlbar-container"
              "customizableui-special-spring2"
              "downloads-button"
              "fxa-toolbar-menu-button"
              "reset-pbm-toolbar-button"
              "unified-extensions-button"
              "sponsorblocker_ajay_app-browser-action"
              "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action"
              "ublock0_raymondhill_net-browser-action"
              "_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action"
              "addon_darkreader_org-browser-action"
              "simple-translate_sienori-browser-action"
            ];
            toolbar-menubar = [ "menubar-items" ];
            TabsToolbar = [
              "firefox-view-button"
              "tabbrowser-tabs"
              "new-tab-button"
              "alltabs-button"
            ];
            vertical-tabs = [ ];
            PersonalToolbar = [
              "import-button"
              "personal-bookmarks"
            ];
          };
          seen = [
            "reset-pbm-toolbar-button"
            "developer-button"
            "screenshot-button"
            "sponsorblocker_ajay_app-browser-action"
            "addon_darkreader_org-browser-action"
            "chrome-gnome-shell_gnome_org-browser-action"
            "_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action"
            "song-id_losnappas-browser-action"
            "_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action"
            "_036a55b4-5e72-4d05-a06c-cba2dfcc134a_-browser-action"
            "ublock0_raymondhill_net-browser-action"
            "_74145f27-f039-47ce-a470-a662b129930a_-browser-action"
            "tp_cs_firefox_trufflepiggy_com-browser-action"
            "simple-translate_sienori-browser-action"
            "librezam_librezam-browser-action"
          ];
          dirtyAreaCache = [
            "nav-bar"
            "vertical-tabs"
            "PersonalToolbar"
            "toolbar-menubar"
            "TabsToolbar"
            "unified-extensions-area"
          ];
          currentVersion = 24;
          newElementCount = 2;
        };

      };

      # Motores de búsqueda personalizados
      # search = {
      #   force = true;
      #   default = "DuckDuckGo";
      # };
    };
  };
}
