with System;
with GLib;              use GLib;
with GLib.Object;
with Gdk.Event;         use Gdk.Event;
with Gdk.Pixbuf;        use Gdk.Pixbuf;
with Gtk.Window;        use Gtk.Window;
with Gtk.Widget;        use Gtk.Widget;
with Gtk.Drawing_Area;  use Gtk.Drawing_Area;
with Gtk.Handlers;      use Gtk.Handlers;
with Interfaces.C;

with Cairo;             use Cairo;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

-- Application specific units
with my_rgba;           use my_rgba;

package widget_spritesbar is


    type spritesbar_record is new Gtk.Drawing_Area.Gtk_Drawing_Area_Record with private;
    type spritesbar is access all spritesbar_record'class;


    type Index is range 0 .. 7;
    type Sprite_Array is array (Index) of Gdk_Pixbuf;

    function Get_Type return GLib.GType;
    procedure gtk_new(self : in out spritesbar);
    procedure initialize(self : not null access spritesbar_record'class);
    function MouseToIndexSprite(Self : spritesbar; mx :Gint; my :Gint) return Gint;
    function GetSelectSpriteIndex(Self : spritesbar) return Gint;


    private
    type spritesbar_record is new Gtk.Drawing_Area.Gtk_Drawing_Area_Record
    with
        record

            cellSize    : Gint := 68;
            nbRows      : Gint := 8;
            idSelect    : Gint := 0;

        end record;

    klass : aliased Glib.Object.Ada_GObject_Class := Glib.Object.Uninitialized_Class;

    function draw_cb(Self : access Gtk.Widget.Gtk_Widget_Record'Class;
        context : Cairo.Cairo_Context) return boolean;

    function button_press_event_cb(Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
        Event : Gdk.Event.Gdk_Event_Button) return  Boolean;
        
    function motion_notify_event_cb(Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
        Event : Gdk.Event.Gdk_Event_Motion) return  Boolean;

end widget_spritesbar;