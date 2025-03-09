with System;
with Glib;            use Glib;
with Glib.Object;     use Glib.Object;
with Glib.Properties.Creation;   use Glib.Properties.Creation;
with Glib.Error;        use Glib.Error;
with Gdk;               use Gdk;
with Gdk.Types;         use Gdk.Types;
with Gdk.Event;         use Gdk.Event;
with Gdk.Pixbuf;        use Gdk.Pixbuf;
with Gtk.Window;        use Gtk.Window;
with Gtk.Widget;        use Gtk.Widget;
with Gtk.Handlers;      use Gtk.Handlers;


-- Application specific units
with sprite_ed_data;    use sprite_ed_data;
with p_select;  use p_select;
with widget_editarea;   use widget_editarea;

package body p_fill_mode is

    package Internal_Cb is new Gtk.Handlers.Callback(widget_editarea.editarea_record);


    function btn_press_evt_cb(
            Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
            Event : Gdk.Event.Gdk_Event_Button
        ) return  Boolean
    is
        self1 : editarea := editarea(Self);
        pixX        : Gint;
        pixY        : Gint;
    begin
        if Event.Button = GLib.Guint(Gdk.Event.Button_Primary) then
            pixX := MouseToPixelX(self1,Gint(Event.X));
            pixY := MouseToPixelY(self1,Gint(Event.Y));
            if PtInEditArea(self1,  pixX, pixY) then
                BackupSprite;
                flood_fill(curSprite, pixX, pixY, GetForeGroundColor(self1));
                Internal_Cb.Emit_By_Name (self1, "changed");
                Self.Queue_Draw;
            end if;        
        end if;
        -- We've handled the event, stop processing
        return True;
    end btn_press_evt_cb;


    function motion_notify_evt_cb(
       Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
        Event : Gdk.Event.Gdk_Event_Motion) return  Boolean
    is
        self1 : editarea := editarea(Self);
    begin
        null;
        -- We've handled the event, stop processing
        return True;
    end motion_notify_evt_cb;

end p_fill_mode;