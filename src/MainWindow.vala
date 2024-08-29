public class MyApp.MainWindow : Adw.ApplicationWindow {
    public MainWindow (Gtk.Application app) {
        Object (
            application: app
        );
    }

    static construct {
        var css_provider = new Gtk.CssProvider ();
        css_provider.load_from_resource (Constants.APP_PATH + "style.css");

        Gtk.StyleContext.add_provider_for_display (
            Gdk.Display.get_default (),
            css_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );
    }

    construct {
        var about_window = new Adw.AboutWindow.from_appdata (
            @"$(Constants.APP_PATH)metainfo.xml",
            Constants.APP_VERSION
        ) {
            transient_for = this,
            hide_on_close = true,

            /// The translator credits. Please translate this with your name(s).
            translator_credits = _("translator-credits"),
        };

        about_window.copyright = "© 2024-%i %s".printf (
            new DateTime.now_local ().get_year (),
            about_window.developer_name
        );

        var about_action = new SimpleAction ("about", null);
        about_action.activate.connect (() => about_window.present ());
        about_action.set_enabled (true);
        add_action (about_action);

        var settings_menu_model = new GLib.Menu ();
        settings_menu_model.append (_("About"), "win.about");

        var settings_popover = new Gtk.PopoverMenu.from_model_full (
            settings_menu_model,
            Gtk.PopoverMenuFlags.NESTED
        );

        var settings_button = new Gtk.MenuButton () {
            css_classes = { "flat" },
            popover = settings_popover,
            tooltip_text = _("Main Menu"),
            icon_name = "open-menu-symbolic",
        };

        var header = new Adw.HeaderBar ();
        header.pack_end (settings_button);

        var app_label = new Gtk.Label (_("Hello World"));
        app_label.hexpand = true;
        app_label.halign = Gtk.Align.CENTER;

        var lib_label = new Gtk.Label (MyApp.say_hello ("from Vala"));
        lib_label.hexpand = true;
        lib_label.halign = Gtk.Align.CENTER;

        var stack_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0) {
            valign = Gtk.Align.CENTER,
            vexpand = true
        };

        stack_box.append (app_label);
        stack_box.append (lib_label);

        var layout_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        layout_box.append (header);
        layout_box.append (stack_box);

        this.set_content (layout_box);
    }
}
