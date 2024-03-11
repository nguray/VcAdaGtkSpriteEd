with Gdk;               use Gdk;
with Glib;              use Glib;
with Gdk.Event;         use Gdk.Event;
with Gtk.Window;        use Gtk.Window;
with Gtk.Widget;        use Gtk.Widget;
with Gdk.Pixbuf;        use Gdk.Pixbuf;

with widget_editarea;   use widget_editarea;
with my_rgba;           use my_rgba;

package p_pencil_mode is

    procedure SetPixel(pixbuf : Gdk_Pixbuf; x:Gint; y : Gint; color : Rgba_Record);
    function GetPixel(pixbuf : Gdk_Pixbuf; x:Gint; y : Gint) return Rgba_Record;

    function btn_press_evt_cb(
            Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
            Event : Gdk.Event.Gdk_Event_Button
        ) return  Boolean;

    function motion_notify_evt_cb(
       Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
        Event : Gdk.Event.Gdk_Event_Motion) return  Boolean;

end p_pencil_mode;