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
with Gdk.Color;                   use Gdk.Color;
with Gdk.RGBA;                    use Gdk.RGBA;
with Gtk.Color_Selection;         use Gtk.Color_Selection;
with Gtk.Color_Selection_Dialog;  use Gtk.Color_Selection_Dialog;

with Cairo;             use Cairo;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

-- Application specific units
with my_rgba;           use my_rgba;

package widget_palette is


    type palette_record is new Gtk.Drawing_Area.Gtk_Drawing_Area_Record with private;
    type palette is access all palette_record'class;


 
    type Index is range 0 .. 63;
    type Color_Array is array (Index) of Rgba_Record;

    function Get_Type return GLib.GType;
    procedure gtk_new(self : in out palette);
    procedure initialize(self : not null access palette_record'class);
    procedure DrawCell(context : Cairo.Cairo_Context;
                        x : Gint; y : Gint; s : Gint; color : Rgba_Record);
    function MouseToIndexColor(Self : palette; mx :Gint; my :Gint) return Gint;
    function GetForegroundColor(Self : palette) return Rgba_Record;
    procedure SetForegroundColor(Self : palette; col : Rgba_Record);
    function GetBackgroundColor(Self : palette) return Rgba_Record;
    procedure SetBackgroundColor(Self : palette; col : Rgba_Record);
    function GetCurrentCellColor(Self : palette) return Rgba_Record;
    procedure SetCurrentCellColor(Self : palette; color : Rgba_Record);

    function PaseLine(strL : Unbounded_String; color : in out Rgba_Record) return Boolean;
    procedure SavePalette(Self :palette);
    procedure LoadPalette(Self :palette);


    private
    type palette_record is new Gtk.Drawing_Area.Gtk_Drawing_Area_Record
    with
        record

            cellSize    : Glib.Gint := 17;
            nbRows      : Glib.Gint := 2;
            nbColumns   : Glib.Gint := 32;
            idSelect    : Gint := 0;
            tblColors   : Color_Array := (
                                0=>(0,0,0,0),
                                1=>(255,0,0,255),
                                2=>(0,255,0,255),
                                3=>(0,0,255,255),
                                others=>(255,0,0,255)
                            );
            foreGroundColor : Rgba_Record := (255,0,0,255);
            backGroundColor : Rgba_Record := (0,0,0,0);

        end record;

    klass : aliased Glib.Object.Ada_GObject_Class := Glib.Object.Uninitialized_Class;

    function draw_cb(Self : access Gtk.Widget.Gtk_Widget_Record'Class;
        context : Cairo.Cairo_Context) return boolean;

    function button_press_event_cb(Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
        Event : Gdk.Event.Gdk_Event_Button) return  Boolean;
        
    function motion_notify_event_cb(Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
        Event : Gdk.Event.Gdk_Event_Motion) return  Boolean;

end widget_palette;