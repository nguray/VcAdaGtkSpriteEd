with System;
with GLib;              use GLib;
with GLib.Object;
with Gdk;               use Gdk;
with Gdk.Event;         use Gdk.Event;
with Gdk.Pixbuf;        use Gdk.Pixbuf;
with Gtk.Window;        use Gtk.Window;
with Gtk.Widget;        use Gtk.Widget;
with Gtk.Drawing_Area;  use Gtk.Drawing_Area;
with Gtk.Handlers;      use Gtk.Handlers;
with Interfaces.C;
with Gdk.Pixbuf;        use Gdk.Pixbuf;

with Cairo;             use Cairo;

-- Ada predefined units
with Ada.Containers; use Ada.Containers;
with Ada.Containers.Vectors;

-- Application specific units
with my_rgba;           use my_rgba;

package widget_editarea is


    type editarea_record is new Gtk.Drawing_Area.Gtk_Drawing_Area_Record with private;
    type editarea is access all editarea_record'class;


    type EditMode is (Select_Mode,Pencil_Mode,Rectangle_Mode,Ellipse_Mode,Fill_Mode);


    function Get_Pixels (Pixbuf : Gdk_Pixbuf) return Rgba_Buffer_Access;
    --  Return a pointer to the pixel data of the image.

    function Get_Type return GLib.GType;
    procedure gtk_new(self : in out editarea);
    procedure initialize(self : not null access editarea_record'class);

    function MouseToPixelX(self : editarea; mx :Gint) return Gint;
    function MouseToPixelY(self : editarea; my :Gint) return Gint;

    procedure SetForegroundColor(Self : editarea; color : Rgba_Record); 
    procedure SetBackgroundColor(Self : editarea; color : Rgba_Record);

    procedure SetSelectMode(Self :editarea);
    procedure SetPencilMode(Self :editarea);
    procedure SetRectangleMode(Self :editarea);
    procedure SetEllipseMode(Self :editarea);
    procedure SetFillMode(Self :editarea);

    procedure SetEditSprite(Self :editarea; sprite :Gdk_Pixbuf);

    procedure FillArea(sprite :Gdk_Pixbuf;
                x0 :Gint;y0 :Gint;x1 :Gint;y1 :Gint; col : Rgba_Record);

    procedure DrawLine(sprite :Gdk_Pixbuf;
                x0 : Gint;y0 : Gint;x1 : Gint;y1 : Gint; col : Rgba_Record);
    
    function PixelToMouseX( Self :editarea; px : Gint) return Gdouble;
    function PixelToMouseY( Self :editarea; py : Gint) return Gdouble;
    function HitHandle( Self :editarea; mx : Gdouble; my : Gdouble) return Gint;
    function InSelectRect(Self : editarea; mx : Gdouble; my : Gdouble) return Boolean;

    procedure BackupSprite;
    procedure RestoreSprite;
    procedure SetCurrentSprite(Self :editarea; sprite : Gdk_Pixbuf);

    function PtInEditArea(Self :editarea; px : Gint; py : Gint) return Boolean;

    procedure UndoEdit(Self :editarea);
    procedure CutSelect(Self :editarea);
    procedure CopySelect(Self :editarea);
    procedure PasteSelect(Self :editarea);

    procedure draw_rectangle(sprite :Gdk_Pixbuf;x0 :Gint;y0 :Gint;x1 :Gint;y1 :Gint; col :Rgba_Record);

    procedure fill_rectangle(sprite :Gdk_Pixbuf;x0 :Gint;y0 :Gint;x1 :Gint;y1 :Gint; col :Rgba_Record);

    procedure draw_ellipse(sprite :Gdk_Pixbuf;left :Gint;top :Gint;right :Gint;bottom :Gint; col :Rgba_Record);

    procedure fill_ellipse(sprite :Gdk_Pixbuf;left :Gint;top :Gint;right :Gint;bottom :Gint; col :Rgba_Record);

    procedure flood_fill(sprite :Gdk_Pixbuf; px :Gint; py :Gint; fill_color :Rgba_Record);

    function GetNbPixelsWidth(self : editarea) return Gint;

    function GetNbPixelsHeight(self : editarea) return Gint;

    function GetLastX(self : editarea) return Gint;
    procedure SetLastX(self : editarea; x : Gint);

    function GetLastY(self : editarea) return Gint;
    procedure SetLastY(self : editarea; y : Gint);

    function GetForeGroundColor(self : editarea) return Rgba_Record;

    function GetBackGroundColor(self : editarea) return Rgba_Record;

    procedure flip_horizontaly( spriteSrc :Gdk_Pixbuf; spriteDes :Gdk_Pixbuf);
     
    procedure flip_verticaly( spriteSrc :Gdk_Pixbuf; spriteDes :Gdk_Pixbuf);

    procedure swing_left( spriteSrc :Gdk_Pixbuf; spriteDes :Gdk_Pixbuf);

    procedure swing_right( spriteSrc :Gdk_Pixbuf; spriteDes :Gdk_Pixbuf);

    private
    type editarea_record is new Gtk.Drawing_Area.Gtk_Drawing_Area_Record
    with
        record

            cellSize  : Glib.Gint := 16;
            nbPixelsW : Glib.Gint := 32;
            nbPixelsH : Glib.Gint := 32;

            foreGroundColor : Rgba_Record := (255,0,0,255);
            backGroundColor : Rgba_Record := (0,0,0,0);

            lastX : Gint := 0;
            lastY : Gint := 0;

            CurrentMode     : EditMode;

        end record;

    klass : aliased Glib.Object.Ada_GObject_Class := Glib.Object.Uninitialized_Class;

    function draw_cb(Self : access Gtk.Widget.Gtk_Widget_Record'Class;
        context : Cairo.Cairo_Context) return boolean;

    function button_press_event_cb(Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
        Event : Gdk.Event.Gdk_Event_Button) return  Boolean;
        
    function button_release_event_cb(Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
        Event : Gdk.Event.Gdk_Event_Button) return  Boolean;

    function motion_notify_event_cb(Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
        Event : Gdk.Event.Gdk_Event_Motion) return  Boolean;


end widget_editarea;