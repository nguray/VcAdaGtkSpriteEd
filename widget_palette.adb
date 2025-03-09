with System;
with Glib;            use Glib;
with Glib.Object;     use Glib.Object;
with Glib.Properties;
with Glib.Properties.Creation;   use Glib.Properties.Creation;
with Glib.Error;        use Glib.Error;
with Gdk;               use Gdk;
with Gdk.Types;         use Gdk.Types;
with Gdk.Event;         use Gdk.Event;
with Gdk.Pixbuf;        use Gdk.Pixbuf;
with Gdk.Screen;        use Gdk.Screen;
with Gdk.Display;       use Gdk.Display;
with Gtk;               use Gtk;
with Gtk.Handlers;      use Gtk.Handlers;
with Cairo;             use Cairo;
with Gdk.Cairo;         use Gdk.Cairo;
with Gtkada.Types;      use Gtkada.Types;
with Interfaces.C;
with Interfaces.C.Strings;

-- Ada predefined units
with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Strings;       use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Maps;  use Ada.Strings.Maps;
--with Ada.Characters.Latin_9;

-- Application specific units
with sprite_ed_data;    use sprite_ed_data;

package body widget_palette is


    --  Array of the signals created for this widget
    Signals1 : Interfaces.C.Strings.Chars_Ptr_Array := (C.Strings.New_String("color_changed"),C.Strings.New_String("color_dialog"));
    package Internal_Cb is new Handlers.Callback (palette_record);

    function Get_Type return Glib.GType 
    is
        Info : access GInterface_Info;
    begin
        Initialize_Class_Record(
            Ancestor => Gtk.Drawing_Area.Get_Type,
            Class_Record => Klass,
            Type_Name => "palette",
            Signals => Signals1,
            Parameters => Glib.Object.Null_Parameter_Types
        );

        Put_Line("palette get_type called");
        return Klass.The_Type;
    end;

    procedure gtk_new(self : in out palette) 
    is
        Error : Glib.Error.GError;
        rgbPix : Rgba_Record;
    begin
        self := new palette_record;
        widget_palette.initialize(self);
        Put_Line("Palette allocated");

    end;

    procedure initialize(self : not null access palette_record'class)
    is
    begin
        Glib.Object.G_New(Object => self, Typ => Get_Type);
        Gtk.Drawing_Area.Initialize(self);
        self.Set_Has_Window(True);
        self.Set_Size_Request(self.nbColumns*self.cellSize+2, self.nbRows*self.cellSize+2);

        --  We want to get Button_Release events
        self.Set_Events ( self.Get_Events or Exposure_Mask or Button_Release_Mask
                    or Button_Press_Mask or Pointer_Motion_Mask );
        self.On_Draw(draw_cb'access, True);
        self.On_Button_Press_Event (button_press_event_cb'Access);
        self.On_Motion_Notify_Event(motion_notify_event_cb'Access);

        Put_Line("Palette initialized");

    end;

    procedure drawCell(
        context : Cairo.Cairo_Context;
        x : Gint;
        y : Gint;
        s : Gint;
        color : Rgba_Record
        ) 
    is
        l,t,r,b : Gdouble;
    begin
        if color.Alpha/=0 then
            Set_Source_Rgba(context, Gdouble(color.Red)/Gdouble(255), Gdouble(color.Green)/Gdouble(255), Gdouble(color.Blue)/Gdouble(255), 1.0);
            Cairo.Rectangle(context,Gdouble(x),Gdouble(y),Gdouble(s),Gdouble(s));
            Cairo.Fill(context);        
        else
            --
            Cairo.Set_Line_Width(context, 0.5);
            Set_Source_Rgba(context, Gdouble(color.Red)/Gdouble(100), Gdouble(color.Green)/Gdouble(100), Gdouble(color.Blue)/Gdouble(100), 1.0);
            l := Gdouble(x);
            t := Gdouble(y);
            r := l + Gdouble(s - 1);
            b := t + Gdouble(s - 1);
            Cairo.Move_To(context, l, t);
            Cairo.Line_To(context, r, t);
            Cairo.Line_To(context, r, b);
            Cairo.Line_To(context, l, b);
            Cairo.Line_To(context, l, t);
            --
            Cairo.Move_To(context, l, t);
            Cairo.Line_To(context, r, b);
            Cairo.Move_To(context, r, t);
            Cairo.Line_To(context, l, b);

            Cairo.Stroke(context);
        end if;
    end drawCell;

    function draw_cb(Self : access Gtk.Widget.Gtk_Widget_Record'Class;
        context : Cairo.Cairo_Context) return boolean 
    is
        self1 : palette := palette(Self);
        w : Gint;
        h : Gint;
        x,y : Gint;
        rgbPix : Rgba_Record;
        s : Gdouble;
        i : Gint;
    begin
        -- Put_Line("Dial drawing");
        w := Get_Allocated_Width(self);
        w := Self.Get_Allocated_Width;
        h := Self.Get_Allocated_Height;

        i := 0;
        s := Gdouble(self1.cellSize-1);
        for r in 0..(self1.nbRows-1) loop
            for c in 0..(self1.nbColumns-1) loop
                x := 2*self1.cellSize + c*self1.cellSize;
                y := r * self1.cellSize + 1; 
                drawCell(context, x, y, Gint(s), self1.tblColors(Index(i)));
                i := i + 1;
            end loop;
        end loop;

        --
        drawCell(context,0,1,self1.cellSize*2,self1.backGroundColor);

        --
        drawCell(context,0,1,Gint(Gdouble(self1.cellSize)*1.3),self1.foreGroundColor);

        --  Put_Line("NbDraw " & nbDraw'Image);
        --  if Get_Has_Alpha(curSprite) then
        --      Put_Line("Alpha");
        --  else
        --      Put_Line("No Alpha");
        --  end if;

        return True;
    end;

    function button_press_event_cb(
            Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
            Event : Gdk.Event.Gdk_Event_Button ) return  Boolean
    is
        self1       : palette := palette(Self);
        idCol       : Gint;
    begin
        --Ada.Text_IO.Put_Line("Dial Button press");

        if Event.Button = GLib.Guint(Gdk.Event.Button_Primary) then
            if Event.The_Type=Gdk_2button_Press then
                idCol := MouseToIndexColor(self1, Gint(Event.X), Gint(Event.Y));
                if idCol>=0 then
                    self1.idSelect := idCol;
                    Internal_Cb.Emit_By_Name (self1, "color_dialog");
                end if;        
            else
                idCol := MouseToIndexColor(self1, Gint(Event.X), Gint(Event.Y));
                if idCol>=0 then
                    self1.foreGroundColor := self1.tblColors(Index(idCol));
                end if;
                Internal_Cb.Emit_By_Name (self1, "color_changed");
                self1.Queue_Draw;
            end if;

        elsif Event.Button = GLib.Guint(Gdk.Event.Button_Secondary) then
            Put_Line("Secondary Button press");
            idCol := MouseToIndexColor(self1, Gint(Event.X), Gint(Event.Y));
            if idCol>=0 then
                self1.backGroundColor := self1.tblColors(Index(idCol));
            end if;
            Internal_Cb.Emit_By_Name (self1, "color_changed");
            self1.Queue_Draw;

        end if;
        -- We've handled the event, stop processing
        return True;
    end button_press_event_cb;

    function motion_notify_event_cb
        (Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
        Event : Gdk.Event.Gdk_Event_Motion) return  Boolean
    is
        self1 : palette := palette(Self);
    begin
        if (Event.State and Gdk.Types.Button1_Mask) > 0 then
            --  
            Put_Line("palette motion notify");
            self1.Queue_Draw;

        end if;
        -- We've handled it, stop processing
        return True;
    end motion_notify_event_cb;

    function MouseToIndexColor(Self : palette; mx :Gint; my :Gint) return Gint 
    is
        i : Gint;
        l,t,r,b : Gint;
    begin
        i := 0;
        for row in 0..(self.nbRows-1) loop
            for col in 0..(self.nbColumns-1) loop
                l := self.cellSize*2 + col*self.cellSize;
                t := row * self.cellSize;
                r := l + self.cellSize;
                b := t + self.cellSize;
                if mx>l and mx<r and my>t and my<b then
                    return i;
                end if;
                i := i + 1;
            end loop;
        end loop;
        return -1;

    end MouseToIndexColor;

    function GetForegroundColor(Self : palette) return Rgba_Record 
    is
    begin
        return self.foreGroundColor;
    end GetForegroundColor;

    procedure SetForegroundColor(Self : palette; col : Rgba_Record)
    is
    begin
        Self.foreGroundColor := col;
        Self.Queue_Draw;
    end SetForegroundColor;

    function GetBackgroundColor(Self : palette) return Rgba_Record 
    is
    begin
        return self.backGroundColor;
    end GetBackgroundColor;

    procedure SetBackgroundColor(Self : palette; col : Rgba_Record)
    is
    begin
        Self.backGroundColor := col;
        Self.Queue_Draw;
    end SetBackgroundColor;

    function GetCurrentCellColor(Self : palette) return Rgba_Record 
    is
    begin
        return self.tblColors(Index(self.idSelect));
    end GetCurrentCellColor;

    procedure SetCurrentCellColor(Self : palette; color : Rgba_Record) 
    is
    begin
        self.tblColors(Index(self.idSelect)) := color;
    end SetCurrentCellColor;

    procedure SavePalette(Self :palette) 
    is
        F   : File_Type;
        File_Name : constant String := "palette.txt";
        col : Rgba_Record;
    begin
        Put_Line("Save Palette");
        Create (F, Out_File, File_Name);
        Put_Line(F, self.foreGroundColor.Red'Image & ";" & self.foreGroundColor.Green'Image & ";" & self.foreGroundColor.Blue'Image & ";" & self.foreGroundColor.Alpha'Image & ";");
        Put_Line(F, self.backGroundColor.Red'Image & ";" & self.backGroundColor.Green'Image & ";" & self.backGroundColor.Blue'Image & ";" & self.backGroundColor.Alpha'Image & ";");
        for i in 0..63 loop
            col := self.tblColors(Index(i));
            Put_Line(F, col.Red'Image & ";" & col.Green'Image & ";" & col.Blue'Image & ";" & col.Alpha'Image & ";");
        end loop;
        Close(F);

    end SavePalette;

    function PaseLine(strL : Unbounded_String; color :in out Rgba_Record) return Boolean 
    is
        S   : String := To_String(strL); 
        F   : Positive;
        L   : Natural;
        I   : Natural := 1;
        SemiColon : constant Character_Set := To_Set (';');
        Red   :  Unbounded_String := To_Unbounded_String("--");
        Green :  Unbounded_String := To_Unbounded_String("--");
        Blue  :  Unbounded_String := To_Unbounded_String("--");
        Alpha :  Unbounded_String := To_Unbounded_String("--");
    begin
        Find_Token
            (Source  => strL,
            Set     => SemiColon,
            From    => I,
            Test    => Outside,
            First   => F,
            Last    => L);
        if L /=0 then
            Red := To_Unbounded_String(S(F .. L));
            --
            I := L + 1;
            Find_Token
                (Source  => strL,
                Set     => SemiColon,
                From    => I,
                Test    => Outside,
                First   => F,
                Last    => L);
            if L/=0 then
                Green := To_Unbounded_String(S(F .. L));
                --
                I := L + 1;
                Find_Token
                    (Source  => strL,
                    Set     => SemiColon,
                    From    => I,
                    Test    => Outside,
                    First   => F,
                    Last    => L);
                if L/=0 then
                    Blue := To_Unbounded_String(S(F .. L));
                    --
                    I := L + 1;
                    Find_Token
                        (Source  => strL,
                        Set     => SemiColon,
                        From    => I,
                        Test    => Outside,
                        First   => F,
                        Last    => L);
                    if L/=0 then
                        Alpha := To_Unbounded_String(S(F .. L));
                        color.Red := Guchar(Integer'Value(To_String(Red)));
                        color.Green := Guchar(Integer'Value(To_String(Green)));
                        color.Blue := Guchar(Integer'Value(To_String(Blue)));
                        color.Alpha := Guchar(Integer'Value(To_String(Alpha)));
                        return True;
                    end if;
                end if;
            end if;
        end if;

        return False;

    end;

    procedure LoadPalette(Self :palette) 
    is
        iL   : Gint := 0;
        iCol : Gint := 0;
        Fic    : File_Type;
        strL : Unbounded_String;
        File_Name : constant String := "palette.txt";
        col  : Rgba_Record;
    begin
        Put_Line("Load Palette");
        Open (Fic, In_File, File_Name);
        while not End_Of_File (Fic) loop
            strL := To_Unbounded_String(Get_Line (Fic));
            if iL=0 then
                if PaseLine(strL, col) then
                    Self.foreGroundColor := col;
                    --Put_Line( col.Red'Image & "," & col.Green'Image & "," & col.Blue'Image & "," & col.Alpha'Image );
                end if;
            elsif iL=1 then
                if PaseLine(strL, col) then
                    Self.backGroundColor := col;
                end if;
            else
                if PaseLine(strL, col) then
                    self.tblColors(Index(iCol)):=col;
                end if;
                iCol := iCol + 1;
                exit when iCol>Gint(Self.tblColors'Last);
            end if;
            iL := iL + 1;
        end loop;
        Close(Fic);

    end LoadPalette;


end widget_palette;