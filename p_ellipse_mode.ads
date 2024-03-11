with Gdk;               use Gdk;
with Gdk.Event;         use Gdk.Event;
with Gtk.Window;        use Gtk.Window;
with Gtk.Widget;        use Gtk.Widget;

with widget_editarea;   use widget_editarea;

package p_ellipse_mode is

    function btn_press_evt_cb(
            Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
            Event : Gdk.Event.Gdk_Event_Button
        ) return  Boolean;

    function motion_notify_evt_cb(
       Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
        Event : Gdk.Event.Gdk_Event_Motion) return  Boolean;

end p_ellipse_mode;