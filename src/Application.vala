public class {{APP_NAMESPACE}}.Application : Gtk.Application {
    public Application () {
        Object (application_id: Constants.APP_ID);
    }

    construct {
        Intl.setlocale (GLib.LocaleCategory.ALL, "");
        Intl.bindtextdomain (Constants.GETTEXT_PACKAGE, Constants.LOCALEDIR);
        Intl.bind_textdomain_codeset (Constants.GETTEXT_PACKAGE, "UTF-8");
        Intl.textdomain (Constants.GETTEXT_PACKAGE);
    }

    protected override void activate () {
        var main_window = this.get_active_window ();

        if (main_window == null) {
            main_window = new MainWindow (this) {
                title = Constants.APP_TITLE
            };
        }

        main_window.present ();

        // Remember window dimensions state
        var settings = new Settings (Constants.APP_ID);
        settings.bind ("window-height", main_window, "default-height", SettingsBindFlags.DEFAULT);
        settings.bind ("window-width", main_window, "default-width", SettingsBindFlags.DEFAULT);

        if (settings.get_boolean ("window-maximized")) {
            main_window.maximize ();
        }

        settings.bind ("window-maximized", main_window, "maximized", SettingsBindFlags.SET);
    }

    protected override void startup () {
        base.startup ();

        // Granite.init() is called before Adw.init() to prevent Adwaita stylesheet from
        // being applied.
        Granite.init ();
        Adw.init ();

        // Setup color scheme change events and theming
        var granite_settings = Granite.Settings.get_default ();

        var gtk_settings = Gtk.Settings.get_default ();
        gtk_settings.gtk_icon_theme_name = "elementary";

        if (!(gtk_settings.gtk_theme_name.has_prefix ("io.elementary.stylesheet"))) {
            gtk_settings.gtk_theme_name = "io.elementary.stylesheet.blueberry";
        }

        gtk_settings.gtk_application_prefer_dark_theme = (
            granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK
        );

        granite_settings.notify["prefers-color-scheme"].connect (() => {
            gtk_settings.gtk_application_prefer_dark_theme = (
                granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK
            );
        });
    }
}

public static int main (string[] args) {
    var my_app = new {{APP_NAMESPACE}}.Application ();
    return my_app.run (args);
}
