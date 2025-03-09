with System;
with Glib;            use Glib;
with Glib.Object;     use Glib.Object;
with Glib.Properties.Creation;   use Glib.Properties.Creation;
with Glib.Error;        use Glib.Error;
with Gdk;               use Gdk;
with Gdk.Types;         use Gdk.Types;
with Gdk.Event;         use Gdk.Event;
with Gdk.Pixbuf;        use Gdk.Pixbuf;
with Gtk;               use Gtk;
with Gtk.Handlers;      use Gtk.Handlers;
with Cairo;             use Cairo;
with Gdk.Cairo;         use Gdk.Cairo;
with Gtkada.Types;      use Gtkada.Types;
with Interfaces.C;
with Interfaces.C.Strings;

-- Ada predefined units
with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Exceptions;        use Ada.Exceptions;
with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Maps;      use Ada.Strings.Maps;

-- Application specific units
with sprite_ed_data;    use sprite_ed_data;


package body widget_spritesbar is


    --  Array of the signals created for this widget
    Signals1 : Interfaces.C.Strings.Chars_Ptr_Array := (C.Strings.New_String("spritesbar_changed"),C.Strings.New_String("pick_color"));
    package Internal_Cb is new Handlers.Callback (spritesbar_record);

    function Get_Type return Glib.GType 
    is
        Info : access GInterface_Info;
    begin
        Initialize_Class_Record(
            Ancestor => Gtk.Drawing_Area.Get_Type,
            Class_Record => Klass,
            Type_Name => "spritesbar",
            Signals => Signals1,
            Parameters => Glib.Object.Null_Parameter_Types
        );

        Put_Line("spritesbar get_type called");
        return Klass.The_Type;
    end;

    procedure gtk_new(self : in out spritesbar) 
    is
        Error : Glib.Error.GError;
        rgbPix : Rgba_Record;
    begin
        self := new spritesbar_record;
        widget_spritesbar.initialize(self);
        Put_Line("spritesbar allocated");

    end;

    procedure initialize(self : not null access spritesbar_record'class)
    is
    begin
        Glib.Object.G_New(Object => self, Typ => Get_Type);
        Gtk.Drawing_Area.Initialize(self);
        self.Set_Has_Window(True);
        self.Set_Size_Request(self.cellSize+2, self.nbRows*self.cellSize+2);

        --  We want to get Button_Release events
        self.Set_Events ( self.Get_Events 
                        or Exposure_Mask or Button_Release_Mask
                        or Button_Press_Mask or Pointer_Motion_Mask 
                    );
        self.On_Draw(draw_cb'access, True);
        self.On_Button_Press_Event (button_press_event_cb'Access);
        self.On_Motion_Notify_Event(motion_notify_event_cb'Access);

        Put_Line("spritesbar initialized");

    end;

    function draw_cb(Self : access Gtk.Widget.Gtk_Widget_Record'Class;
        context : Cairo.Cairo_Context) return boolean 
    is
        self1 : spritesbar := spritesbar(Self);
        w : Gint;
        h : Gint;
        x,y : Gint;
        l,t,r,b,s : Gdouble;
        sprite1     : Gdk_Pixbuf;
        spriteW     : Gint;
        spriteH     : Gint;
    begin
        -- Put_Line("Dial drawing");
        w := Self.Get_Allocated_Width;
        h := Self.Get_Allocated_Height;

        --
        for i in IndexSpriteArray loop
            sprite1 := tblSprites(i);
            spriteW := Get_Width(sprite1);
            spriteH := Get_Height(sprite1);
            x := w / 2;
            y := Gint(i) * self1.cellSize + self1.cellSize / 2;
            l := Gdouble(x - spriteW / 2);
            t := Gdouble(y - spriteH / 2);
            Set_Source_Pixbuf (context,
                                Pixbuf => sprite1,
                                Pixbuf_X => l,
                                Pixbuf_Y => t);
            Cairo.Paint (context);
        end loop;

        --
        Cairo.Set_Line_Width(context, 0.5);
        Set_Source_Rgba(context, 0.2, 0.2, 0.2, 1.0);
        Cairo.Move_To(context, 0.0, 0.0);
        Cairo.Line_To(context, 0.0, Gdouble(self1.nbRows*self1.cellSize));
        r := Gdouble(w-1); 
        Cairo.Move_To(context, r, 0.0);
        Cairo.Line_To(context, r, Gdouble(self1.nbRows*self1.cellSize));
        Cairo.Stroke(context);

        l := 0.0;
        for row in 0..(self1.nbRows) loop
            t := Gdouble(row*self1.cellSize);
            Cairo.Move_To(context, l, t);
            Cairo.Line_To(context, r, t);
        end loop;
        Cairo.Stroke(context);

        if self1.idSelect>=0 and self1.idSelect<self1.nbRows then
            Cairo.Set_Line_Width(context, 1.0);
            Set_Source_Rgba(context, 1.0, 0.2, 0.2, 1.0);
            t := Gdouble(self1.idSelect*self1.cellSize)+1.0;
            b := t + Gdouble(self1.cellSize-2);
            l := 1.0;
            r := Gdouble(w-2);
            s := 10.0;
            --
            Cairo.Move_To(context, l, t+s);
            Cairo.Line_To(context, l, t);
            Cairo.Line_To(context, l+s, t);
            --
            Cairo.Move_To(context, r-s, t);
            Cairo.Line_To(context, r, t);
            Cairo.Line_To(context, r, t+s);
            --
            Cairo.Move_To(context, l, b-s);
            Cairo.Line_To(context, l, b);
            Cairo.Line_To(context, l+s, b);
            --
            Cairo.Move_To(context, r-s, b);
            Cairo.Line_To(context, r, b);
            Cairo.Line_To(context, r, b-s);

            Cairo.Stroke(context);
        end if;

        return True;
    end;

    function button_press_event_cb(
            Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
            Event : Gdk.Event.Gdk_Event_Button ) return  Boolean
    is
        self1 : spritesbar := spritesbar(Self);
        id : Gint;
    begin
        --Ada.Text_IO.Put_Line("Dial Button press");
        if Event.Button = GLib.Guint(Gdk.Event.Button_Primary) then
            Put_Line("Primary Button press " & self1.cellSize'Image);
            id := MouseToIndexSprite(Self1, Gint(Event.X), Gint(Event.Y));
            if id>=0 then
                self1.idSelect := id;
                Internal_Cb.Emit_By_Name (self1, "spritesbar_changed");
                self1.Queue_Draw;
            end if;

        elsif Event.Button = GLib.Guint(Gdk.Event.Button_Secondary) then
            Put_Line("Secondary Button press");
            self1.Queue_Draw;

        end if;
        -- We've handled the event, stop processing
        return True;
    end button_press_event_cb;

    function motion_notify_event_cb
        (Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
        Event : Gdk.Event.Gdk_Event_Motion) return  Boolean
    is
        self1 : spritesbar := spritesbar(Self);
    begin
        if (Event.State and Gdk.Types.Button1_Mask) > 0 then
            --    draw_brush (Self, Event.X, Event.Y);
            Put_Line("spritesbar motion notify");
            self1.Queue_Draw;

        end if;
        -- We've handled it, stop processing
        return True;
    end motion_notify_event_cb;

    function MouseToIndexSprite(Self : spritesbar; mx :Gint; my :Gint) return Gint 
    is
        i : Gint;
        l,t,r,b : Gint;
    begin
        i := 0;
        for row in 0..(self.nbRows-1) loop
            l := 0;
            t := row*self.cellSize;
            r := l + self.cellSize;
            b := t + self.cellSize;
            if mx>l and mx<r and my>t and my<b then
                return i;
            end if;
            i := i + 1;
        end loop;
        return -1;

    end MouseToIndexSprite;

    function GetSelectSpriteIndex(Self : spritesbar) return Gint 
    is
    begin
        return Self.idSelect;
    end GetSelectSpriteIndex;


end widget_spritesbar;