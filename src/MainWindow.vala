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
        var header = new Adw.HeaderBar ();

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
