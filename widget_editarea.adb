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
with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Containers.Vectors;

-- Application specific units
with sprite_ed_data;    use sprite_ed_data;
with p_select;          use p_select;
with p_select_mode;     use p_select_mode;
with p_pencil_mode;     use p_pencil_mode;
with p_rectangle_mode;  use p_rectangle_mode;
with p_ellipse_mode;    use p_ellipse_mode;
with p_fill_mode;       use p_fill_mode;


package body widget_editarea is

    package Internal_Cb is new Handlers.Callback (editarea_record);

    --  Array of the signals created for this widget
    Signals1 : Interfaces.C.Strings.Chars_Ptr_Array := (C.Strings.New_String("changed"),C.Strings.New_String("pick_color"));

    function Get_Type return Glib.GType 
    is
        Info : access GInterface_Info;
    begin
        Initialize_Class_Record(
            Ancestor => Gtk.Drawing_Area.Get_Type,
            Class_Record => Klass,
            Type_Name => "editarea",
            Signals => Signals1,
            Parameters => Glib.Object.Null_Parameter_Types
        );

        Put_Line("editarea get_type called");
        return Klass.The_Type;
    end;

    procedure gtk_new(self : in out editarea) 
    is
        Error : Glib.Error.GError;
    begin
        self := new editarea_record;
        widget_editarea.initialize(self);

        --Gdk_New_From_File (curSprite, "res/PlayToolIcon.png", Error);
        --Gdk_New_From_File (curSprite, "res/Test4.png", Error);

        --curSprite := Gdk_New(Colorspace=> Colorspace_RGB,Has_Alpha => True,Width => 32, Height => 32);
        --spritePixels := Get_Pixels(curSprite);
        --spriteWidth := Get_Width(curSprite);
        --Fill(curSprite,16#00000000#);

        self.Set_Size_Request(self.nbPixelsW*self.cellSize+128,9*64);

        self.CurrentMode := Pencil_Mode;
        currToolBtn.Set_Icon_Widget(pencilImage);
        sprite_ed_data.button_press_cb := p_pencil_mode.btn_press_evt_cb'Access;
        sprite_ed_data.motion_notify_evt_cb := p_pencil_mode.motion_notify_evt_cb'Access;

        Put_Line("EditArea allocated");

    end;

    procedure initialize(self : not null access editarea_record'class) 
    is
    begin
        Glib.Object.G_New(Object => self, Typ => Get_Type);
        Gtk.Drawing_Area.Initialize(self);
        self.Set_Has_Window(True);

        --  We want to get Button_Release events
        self.Set_Events ( self.Get_Events or Exposure_Mask or Button_Release_Mask
                    or Button_Press_Mask or Pointer_Motion_Mask);
        self.On_Draw(draw_cb'access, True);
        self.On_Button_Press_Event (button_press_event_cb'Access);
        self.On_Button_Release_Event (button_release_event_cb'Access);
        self.On_Motion_Notify_Event(motion_notify_event_cb'Access);

        Put_Line("EditArea initialized");

    end;

    function GetNbPixelsWidth(self : editarea) return Gint
    is
    begin
        return self.nbPixelsW;
    end GetNbPixelsWidth;

    function GetNbPixelsHeight(self : editarea) return Gint
    is
    begin
        return self.nbPixelsH;
    end GetNbPixelsHeight;

    function MouseToPixelX(self : editarea; mx :Gint) return Gint 
    is
    begin
        return (mx-2)/self.cellSize;
    end;

    function MouseToPixelY(self : editarea; my :Gint) return Gint 
    is
    begin
        return (my-2)/self.cellSize;
    end;

    function draw_cb(Self : access Gtk.Widget.Gtk_Widget_Record'Class;
        context : Cairo.Cairo_Context) return boolean 
    is
        self1 : editarea := editarea(Self);
        w : Gint;
        h : Gint;
        o1,o2 : Gdouble;
        x,y : Gint;
        spritePixels : Rgba_Buffer_Access;
        rgbPix : Rgba_Record;
        s : Gdouble;
        spriteWidth : Gint;
        spriteHeight : Gint;
    begin
        -- Put_Line("Dial drawing");
        w := Self.Get_Allocated_Width;
        h := Self.Get_Allocated_Height;

		o1 := (Gdouble(w - 12) / Gdouble(self1.nbPixelsW));
		o2 := (Gdouble(h - 18) / Gdouble(self1.nbPixelsH));
		self1.cellSize := (if (o1 < o2) then Gint(o1) else Gint(o2));

        Cairo.Set_Source_Rgb(context, 0.5, 0.5, 0.5);
        Cairo.Set_Line_Width(context, 0.4);
        for r in 0..(self1.nbPixelsH) loop
            for c in 0..(self1.nbPixelsW) loop
                x := c * self1.cellSize + 2;
                y := r * self1.cellSize + 2;
                Cairo.Move_To(context, Gdouble(x-1), Gdouble(y));
                Cairo.Line_To(context, Gdouble(x+1), Gdouble(y));
                Cairo.Move_To(context, Gdouble(x), Gdouble(y-1));
                Cairo.Line_To(context, Gdouble(x), Gdouble(y+2));                
            end loop;
        end loop;
        Cairo.Stroke(context);

        s := Gdouble(self1.cellSize-2);
        spriteWidth := Get_Width(curSprite);
        spriteHeight := Get_Height(curSprite);
        spritePixels := Get_Pixels(curSprite);
        for r in 0..(spriteHeight-1) loop
            for c in 0..(spriteWidth-1) loop
                rgbPix := spritePixels(Guint(r*spriteWidth + c));
                x := c * self1.cellSize + 3;
                y := r * self1.cellSize + 3;
                if rgbPix.Alpha/=0 then
                    Set_Source_Rgba(context, Gdouble(rgbPix.Red)/Gdouble(255), Gdouble(rgbPix.Green)/Gdouble(255), Gdouble(rgbPix.Blue)/Gdouble(255), 1.0);
                    Cairo.Rectangle(context,Gdouble(x),Gdouble(y),s,s);
                    Cairo.Fill(context);
                end if;
            end loop;
        end loop;

        -- Draw Select Frame
        if selRect.IsEmpty = False then
            declare
                px1,py1     : Gint;
                px2,py2     : Gint;
                dx,dy       : Gdouble;
                x,y         : Gdouble;
                x1,y1       : Gdouble;
                x2,y2       : Gdouble;
                dum         : Gdouble;
            begin
                --
                selRect.GetCorner( 0, px1, py1);
                selRect.GetCorner( 2, px2, py2);
                x1 := PixelToMouseX( self1, px1);
                y1 := PixelToMouseY( self1, py1);
                x2 := PixelToMouseX( self1, px2);
                y2 := PixelToMouseY( self1, py2);

                if x1 > x2 then
                    dum := x1;
                    x1 := x2;
                    x2 := dum;
                end if;
                if y1 > y2 then
                    dum := y1;
                    y1 := y2;
                    y2 := dum;
                end if;

                -- Draw Handles
                Set_Source_Rgba(context,0.0, 0.0, 1.0, 1.0);
                dx := Gdouble(self1.cellSize - 5);
                x := x1 + 2.0;
                y := y1 + 2.0;
                Cairo.Rectangle(context, x, y, dx, dx);
                x := x2 + 2.0;
                y := y1 + 2.0;
                Cairo.Rectangle(context, x, y, dx, dx);
                x := x2 + 2.0;
                y := y2 + 2.0;
                Cairo.Rectangle(context, x, y, dx, dx);
                x := x1 + 2.0;
                y := y2 + 2.0;
                Cairo.Rectangle(context, x, y, dx, dx);
                Cairo.Fill(context);

                -- Draw Frame
                y2 := y2 + Gdouble(self1.cellSize);
                x2 := x2 + Gdouble(self1.cellSize);
                Set_Source_Rgba(context,0.0, 0.0, 1.0, 0.1);
                Cairo.Rectangle(context, x1, y1, x2-x1, y2-y1);
                Cairo.Fill(context);
            end;
        end if;

        return True;
    end;

    function PixelToMouseX( Self :editarea; px : Gint) return Gdouble
    is
    begin
        return Gdouble(px*Self.cellSize) + 2.0;
    end PixelToMouseX;

    function PixelToMouseY( Self :editarea; py : Gint) return Gdouble
    is
    begin
        return Gdouble(py*Self.cellSize) + 2.0;
    end PixelToMouseY;

    function HitHandle( Self :editarea; mx : Gdouble; my : Gdouble) return Gint 
    is
        px , py : Gint;
        x , y   : Gdouble;
    begin
        for i in 0..3 loop
            selRect.GetCorner( Gint(i), px, py);
            x := PixelToMouseX( Self, px);
            y := PixelToMouseY( Self, py);
            if mx >= x and mx <= (x+Gdouble(Self.cellSize)) and
                my >= y and my <= (y+Gdouble(Self.cellSize)) then
                return Gint(i);
            end if;

        end loop;
        return -1;
    end HitHandle;

    function InSelectRect(Self : editarea; mx : Gdouble; my : Gdouble) return Boolean 
    is
        px1, py1 : Gint;
        x1, y1   : Gdouble;
        px2, py2 : Gint;
        x2, y2   : Gdouble;
        dum      : Gdouble;
    begin
        --
        selRect.GetCorner( 0, px1, py1);
        x1 := PixelToMouseX(Self, px1);
        y1 := PixelToMouseX(Self, py1);

        selRect.GetCorner( 2, px2, py2);
        x2 := PixelToMouseX(Self, px2);
        y2 := PixelToMouseX(Self, py2);

        if x1 > x2 then
            dum := x1;
            x1  := x2;
            x2  := dum;
        end if;

        if y1 > y2 then
            dum := y1;
            y1  := y2;
            y2  := dum;
        end if;

        y2 := y2 + Gdouble(Self.cellSize);
        x2 := x2 + Gdouble(Self.cellSize);
        
        return (mx >= x1) and (mx <= x2) and (my >= y1) and (my <= y2);

    end InSelectRect;

    function PtInEditArea(Self :editarea; px : Gint; py : Gint) return Boolean
    is
    begin
        return (px in 0..(Self.nbPixelsW-1) and py in 0..(Self.nbPixelsH-1));
    end PtInEditArea;

    -----------------------------------------------------------------------
    --
    -----------------------------------------------------------------------
    function button_press_event_cb(
            Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
            Event : Gdk.Event.Gdk_Event_Button
        ) return  Boolean
    is
    begin
        if button_press_cb/=null then
            return button_press_cb(Self,Event);
        else
            -- We've handled the event, stop processing
            return True;
        end if;
    end button_press_event_cb;

    function button_release_event_cb(
            Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
            Event : Gdk.Event.Gdk_Event_Button
        ) return  Boolean
    is
        self1 : editarea := editarea(Self);
        px1, py1 : Gint;
        px2, py2 : Gint;
        pixX     : Gint;
        pixY     : Gint;
    begin
        --
        if selRect.mode=0 then
            selRect.GetCorner( 0, px1, py1);
            selRect.GetCorner( 2, px2, py2);
            if px1 /= px2 and py1 /= py2 then
                selRect.Normalize;
                selRect.mode := 1;
            else
                selRect.Init;
            end if;
		    self1.Queue_Draw;
        end if;
	    --
	    selRect.sel_corner := -1;

        pixX := MouseToPixelX(self1,Gint(Event.X));
        pixY := MouseToPixelY(self1,Gint(Event.Y));
        if PtInEditArea(self1,  pixX, pixY) then
            self1.lastX := pixX;
            self1.lastY := pixY;
        end if;

        -- We've handled the event, stop processing
        return True;

    end button_release_event_cb;

    function motion_notify_event_cb
        (Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
        Event : Gdk.Event.Gdk_Event_Motion) return  Boolean
    is
        self1 : editarea := editarea(Self);
        pixX     : Gint;
        pixY     : Gint;
        dx,dy    : Gint;
        mdx,mdy  : Gdouble;
        left    : Gint;
        top     : Gint;
        right   : Gint;
        bottom  : Gint;
        SrcX    : Gint;
        SrcY    : Gint;
    begin
        if sprite_ed_data.motion_notify_evt_cb/=null then
            return sprite_ed_data.motion_notify_evt_cb(Self,Event);
        else
            -- We've handled the event, stop processing
            return True;
        end if;
    end motion_notify_event_cb;

    ---------------------------------------------------------------------
    -- Get_Pixels --
    function Get_Pixels
        (Pixbuf : Gdk_Pixbuf) return Rgba_Buffer_Access
    is
        function Internal
        (Pixbuf : System.Address) return Rgba_Buffer_Access;
        pragma Import (C, Internal, "gdk_pixbuf_get_pixels");
    begin
        return Internal (Get_Object (Pixbuf));
    end Get_Pixels;

    procedure SetForegroundColor(Self : editarea; color : Rgba_Record) 
    is
    begin
        Self.foreGroundColor := color;
    end SetForegroundColor;

    procedure SetBackgroundColor(Self : editarea; color : Rgba_Record) 
    is
    begin
        Self.backGroundColor := color;
    end SetBackgroundColor;

    function GetForeGroundColor(Self : editarea) return Rgba_Record
    is
    begin
        return Self.foreGroundColor;
    end GetForeGroundColor;

    function GetBackGroundColor(Self : editarea) return Rgba_Record
    is
    begin
        return Self.backGroundColor;
    end GetBackGroundColor;

    function GetLastX(Self : editarea) return Gint
    is
    begin
        return Self.lastX;
    end GetLastX;

    procedure SetLastX(Self : editarea; x :Gint)
    is
    begin
        Self.lastX := x;
    end SetLastX;

    function GetLastY(Self : editarea) return Gint
    is
    begin
        return Self.lastY;
    end GetLastY;

    procedure SetLastY(Self : editarea; y :Gint)
    is
    begin
        Self.lastY := y;
    end SetLastY;

    procedure SetSelectMode(Self :editarea) 
    is
    begin
        currToolBtn.Set_Icon_Widget(selectImage);
        Self.CurrentMode := Select_Mode;
        sprite_ed_data.button_press_cb  := p_select_mode.btn_press_evt_cb'Access;
        sprite_ed_data.motion_notify_evt_cb := p_select_mode.motion_notify_evt_cb'Access;
        selRect.Init;
        Self.Queue_Draw;

    end SetSelectMode;

    procedure SetPencilMode(Self :editarea) 
    is
    begin
        currToolBtn.Set_Icon_Widget(pencilImage);
        Self.CurrentMode := Pencil_Mode;
        sprite_ed_data.button_press_cb  := p_pencil_mode.btn_press_evt_cb'Access;
        sprite_ed_data.motion_notify_evt_cb := p_pencil_mode.motion_notify_evt_cb'Access;
        selRect.Init;
        Self.Queue_Draw;

    end SetPencilMode;

    procedure SetRectangleMode(Self :editarea) 
    is
    begin
        currToolBtn.Set_Icon_Widget(rectangleImage);
        Self.CurrentMode := Rectangle_Mode;
        sprite_ed_data.button_press_cb  := p_rectangle_mode.btn_press_evt_cb'Access;
        sprite_ed_data.motion_notify_evt_cb := p_rectangle_mode.motion_notify_evt_cb'Access;
        selRect.Init;
        Self.Queue_Draw;

    end SetRectangleMode;

    procedure SetEllipseMode(Self :editarea) 
    is
    begin
        currToolBtn.Set_Icon_Widget(ellipseImage);
        Self.CurrentMode := Ellipse_Mode;
        sprite_ed_data.button_press_cb  := p_ellipse_mode.btn_press_evt_cb'Access;
        sprite_ed_data.motion_notify_evt_cb := p_ellipse_mode.motion_notify_evt_cb'Access;
        selRect.Init;
        Self.Queue_Draw;

    end SetEllipseMode;

    procedure SetFillMode(Self :editarea) 
    is
    begin
        currToolBtn.Set_Icon_Widget(floodFillImage);
        Self.CurrentMode := Fill_Mode;
        sprite_ed_data.button_press_cb  := p_fill_mode.btn_press_evt_cb'Access;
        sprite_ed_data.motion_notify_evt_cb := p_fill_mode.motion_notify_evt_cb'Access;
        selRect.Init;

    end SetFillMode;

    procedure SetEditSprite(Self :editarea; sprite :Gdk_Pixbuf)
    is
    begin
        curSprite := sprite;    
        self.nbPixelsH := Get_Height(curSprite);
        self.nbPixelsW := Get_Width(curSprite);
        self.Queue_Draw;

    end SetEditSprite;

    procedure DrawLine(
                sprite :Gdk_Pixbuf;
                x0 :Gint;y0 :Gint;x1 :Gint;y1 :Gint; col : Rgba_Record)
    is
        w : Gint;
        h : Gint;
        steep : Boolean;
        spritePixels : Rgba_Buffer_Access;
        rgbPix       : Rgba_Record;
		deltax, deltay : Gint;
		error          : Gint;
		x, y, ystep    : Gint;

        procedure put_pixel(x :Gint; y:Gint) is
        begin
            spritePixels(Guint(x+y*w)) := col;
        end put_pixel;

        procedure swap(x : in out Gint; y : in out Gint) is
            dum : Gint;
        begin
            dum := x;
            x := y;
            y := dum;
        end swap;
        pragma Inline (swap);

        function IntAbs(val :Gint) return Gint is
        begin
            if val < 0 then
                return -val;
            else
                return val;
            end if;
        end IntAbs;

        ix0 : Gint := x0;
        iy0 : Gint := y0;
        ix1 : Gint := x1;
        iy1 : Gint := y1;

    begin
        --
        w := Get_Width(sprite);
        h := Get_Height(sprite);

        spritePixels := Get_Pixels(sprite);

        if ix0 in 0..(w-1) and iy0 in 0..(h-1) and ix1 in 0..(w-1) and iy1 in 0..(h-1) then

            steep := IntAbs(iy1-iy0)>IntAbs(ix1-ix0);
            if steep then
                swap(ix0, iy0);
                swap(ix1, iy1);
            end if;
            if ix0 > ix1 then
                swap(ix0,ix1);
                swap(iy0,iy1);
            end if;

            deltax := ix1 - ix0;
            deltay := IntAbs(iy1 - iy0);
            error := deltax / 2;

            y := iy0;
            if iy0 < iy1 then
                ystep := 1;
            else 
                ystep := -1;
            end if;

            for x  in ix0..ix1 loop
                if steep then
                    put_pixel(y, x);
                else
                    put_pixel(x, y);
                end if;
                error := error - deltay;
                if error < 0 then
                    y := y + ystep;
                    error := error + deltax;
                end if;
            end loop;

        end if;

    end DrawLine;

    procedure BackupSprite
    is
        w,h : Gint;
    begin
        if curSprite /= null and BakSprite /= null then
            h := Get_Height(curSprite);
            w := Get_Width(curSprite);
            Copy_Area(curSprite, 0, 0, w, h, bakSprite, 0, 0);
        end if;
        
    end BackupSprite;

    procedure RestoreSprite
    is
        w,h : Gint;
    begin
        if curSprite /= null and BakSprite /= null then
            h := Get_Height(curSprite);
            w := Get_Width(curSprite);
            Copy_Area(bakSprite, 0, 0, w, h, curSprite, 0, 0);
        end if;

    end RestoreSprite;

    procedure SetCurrentSprite(Self :editarea; sprite : Gdk_Pixbuf) 
    is
    begin
        curSprite := sprite;
        Self.nbPixelsW := Get_Width(curSprite);
        Self.nbPixelsH := Get_Height(curSprite);

        if bakSprite/=Null_Pixbuf then
            if Get_Width(bakSprite)/=Self.nbPixelsW or Get_Height(bakSprite)/=Self.nbPixelsH then
                Unref(bakSprite);
                bakSprite := Gdk_New(Colorspace=> Colorspace_RGB,Has_Alpha => True,Width => Self.nbPixelsW, Height => Self.nbPixelsH);    
            end if;
        else
            bakSprite := Gdk_New(Colorspace=> Colorspace_RGB,Has_Alpha => True,Width => Self.nbPixelsW, Height => Self.nbPixelsH);    
        end if;

        if copySprite/=Null_Pixbuf then
            if Get_Width(copySprite)/=Self.nbPixelsW or Get_Height(copySprite)/=Self.nbPixelsH then
                Unref(copySprite);
                copySprite := Gdk_New(Colorspace=> Colorspace_RGB,Has_Alpha => True,Width => Self.nbPixelsW, Height => Self.nbPixelsH);    
            end if;
        else
            copySprite := Gdk_New(Colorspace=> Colorspace_RGB,Has_Alpha => True,Width => Self.nbPixelsW, Height => Self.nbPixelsH);
        end if;

    end SetCurrentSprite;

    procedure FillArea(
                sprite :Gdk_Pixbuf;x0 :Gint;y0 :Gint;x1 :Gint;y1 :Gint; col :Rgba_Record)
    is
        w : Gint;
        h : Gint;
        spritePixels : Rgba_Buffer_Access;
        rgbPix       : Rgba_Record;

        procedure put_pixel(x :Gint; y:Gint) is
        begin
            spritePixels(Guint(x+y*w)) := col;
        end put_pixel;

        ix0 : Gint;
        iy0 : Gint;
        ix1 : Gint;
        iy1 : Gint;

    begin

        w := Get_Width(sprite);
        h := Get_Height(sprite);

        spritePixels := Get_Pixels(sprite);

        if x0 > x1 then
            ix0 := x1;
            ix1 := x0;
        else
            ix0 := x0;
            ix1 := x1;
        end if;

        if y0 > y1 then
            iy0 := y1;
            iy1 := y0;
        else
            iy0 := y0;
            iy1 := y1;
        end if;

        for y in iy0..iy1 loop
            for x in ix0..ix1 loop
                put_pixel(x, y);
            end loop;
        end loop;

    end FillArea;

    procedure UndoEdit(Self :editarea) 
    is
    begin
        RestoreSprite;
        Internal_Cb.Emit_By_Name (Self, "changed");
        Self.Queue_Draw;

    end UndoEdit;

    procedure CutSelect(Self :editarea) 
    is
    begin
        if Self.CurrentMode = Select_Mode then
			Copy_Area(curSprite, selRect.left, selRect.top,
				selRect.Width, selRect.Height, copySprite, 0, 0);
			cpyrect.left   := selRect.left;
			cpyrect.top    := selRect.top;
			cpyrect.right  := selRect.right;
			cpyrect.bottom := selRect.bottom;

			--  tmpPixBuf, _ := gdk.PixbufNew(gdk.COLORSPACE_RGB, true, 8,
			--  	ea.selectRect.Width(), ea.selectRect.Height())
			--  CopyArea(ea.imgBuf, ea.selectRect.left, ea.selectRect.top,
			--  	ea.selectRect.Width(), ea.selectRect.Height(), tmpPixBuf, 0, 0)
			FillArea(curSprite, selRect.left, selRect.top,
				selRect.right, selRect.bottom, Self.backGroundColor);

            selRect.Init;
            Internal_Cb.Emit_By_Name (Self, "changed");
            Self.Queue_Draw;
			--ea.clipboard.SetImage(tmpPixBuf)

        end if;

    end CutSelect;

    procedure CopySelect(Self :editarea) 
    is
    begin

        if Self.CurrentMode = Select_Mode then
            if selRect.IsEmpty/=True then
                Copy_Area(curSprite, selRect.left, selRect.top,
                    selRect.Width, selRect.Height, copySprite, 0, 0);
                cpyrect.left   := selRect.left;
                cpyrect.top    := selRect.top;
                cpyrect.right  := selRect.right;
                cpyrect.bottom := selRect.bottom;

                --  tmpPixBuf, _ := gdk.PixbufNew(gdk.COLORSPACE_RGB, true, 8,
                --      ea.selectRect.Width(), ea.selectRect.Height())
                --  CopyArea(ea.imgBuf, ea.selectRect.left, ea.selectRect.top,
                --      ea.selectRect.Width(), ea.selectRect.Height(), tmpPixBuf, 0, 0)
                selRect.Init;
                Self.Queue_Draw;
                --ea.clipboard.SetImage(tmpPixBuf)

            end if;

        end if;

    end CopySelect;

    procedure PasteSelect(Self :editarea) 
    is
    begin
        if cpyRect.IsEmpty/=True then

            SetSelectMode(Self);
            selRect.left := 0;
            selRect.top  := 0;
            selRect.right  := cpyRect.Width - 1;
            selRect.bottom := cpyRect.Height - 1;
            selRect.mode   := 2;
            BackupSprite;

            --if ea.clipboard.WaitIsImageAvailable() then

                --tmpPixBuf, _ := ea.clipboard.WaitForImage()

                --CopyArea(tmpPixBuf, 0, 0,
                --    tmpPixBuf.GetWidth(), tmpPixBuf.GetHeight(), ea.imgBufCopy, 0, 0)

                Copy_Area(copySprite, 0, 0,
                    selRect.Width, selRect.Height, curSprite, selRect.left, selRect.top);
                Internal_Cb.Emit_By_Name (Self, "changed");
                Self.Queue_Draw;
                --if ea.pixbufModify != nil {
                --    ea.pixbufModify()
                --}

            --end if;

        end if;

    end PasteSelect;

    procedure draw_rectangle(sprite :Gdk_Pixbuf;x0 :Gint;y0 :Gint;x1 :Gint;y1 :Gint; col :Rgba_Record)
    is
        w,h          : Gint;
        startX, endX : Gint;
        startY, endY : Gint;
        spritePixels : Rgba_Buffer_Access;
        rgbPix       : Rgba_Record;
        iy1,iy2      : Gint;

        procedure put_pixel(x :Gint; y:Gint) is
        begin
            spritePixels(Guint(x+y*w)) := col;
        end put_pixel;

    begin

        if x1 > x0 then
            startX := x0;
            endX   := x1;
        else
            startX := x1;
            endX   := x0;
        end if;

        if y1 > y0 then
            startY := y0;
            endY   := y1;
        else
            startY := y1;
            endY   := y0;
        end if;

        w := Get_Width(sprite);
        h := Get_Height(sprite);

        spritePixels := Get_Pixels(sprite);

        if (endX /= startX) or (endY /= startY) then
            -- Tracer le rectangle
            for x in startX..endX loop
                put_pixel(x, startY);
                put_pixel(x, endY);
            end loop;

            iy1 := startY + 1;
            iy2 := endY - 1;
            for y in iy1..iy2 loop
                put_pixel(startX, y);
                put_pixel(endX, y);
            end loop;

        end if;

    end draw_rectangle;

    procedure fill_rectangle(sprite :Gdk_Pixbuf;x0 :Gint;y0 :Gint;x1 :Gint;y1 :Gint; col :Rgba_Record)
    is
        w,h          : Gint;
        startX, endX : Gint;
        startY, endY : Gint;
        spritePixels : Rgba_Buffer_Access;
        rgbPix       : Rgba_Record;
        iy1,iy2      : Gint;

        procedure put_pixel(x :Gint; y:Gint) is
        begin
            spritePixels(Guint(x+y*w)) := col;
        end put_pixel;

    begin

        if x1 > x0 then
            startX := x0;
            endX   := x1;
        else
            startX := x1;
            endX   := x0;
        end if;

        if y1 > y0 then
            startY := y0;
            endY   := y1;
        else
            startY := y1;
            endY   := y0;
        end if;

        w := Get_Width(sprite);
        h := Get_Height(sprite);

        spritePixels := Get_Pixels(sprite);

        if (endX /= startX) or (endY /= startY) then
            -- Tracer le rectangle
            for y in startY..endY loop
                for x in startX..endX loop
                    put_pixel(x, y);
                end loop;
            end loop;

        end if;

    end fill_rectangle;

    procedure draw_ellipse(sprite :Gdk_Pixbuf;left :Gint;top :Gint;right :Gint;bottom :Gint; col :Rgba_Record)
    is
        w,h          : Gint;
        spritePixels : Rgba_Buffer_Access;

        a,b         : Gint;
        x,y         : Gint;
        a2,b2       : Gint;
        a2b2        : Gint;
        a2sqr       : Gint;
        b2sqr       : Gint;
        a4sqr       : Gint;
        b4sqr       : Gint;
        a8sqr       : Gint;
        b8sqr       : Gint;
        a4sqr_b4sqr : Gint;

        fn,fw      : Gint;
        fnn        : Gint;
        fnnw       : Gint;
        fnw        : Gint;
        fnwn       : Gint;
        fnwnw      : Gint;
        fnww       : Gint;
        fwnw       : Gint;
        fww        : Gint;
        d1,d2      : Gint;

        procedure put_pixel(x :Gint; y:Gint) is
        begin
            spritePixels(Guint(x+y*w)) := col;
        end put_pixel;

    begin
        w := Get_Width(sprite);
        h := Get_Height(sprite);

        spritePixels := Get_Pixels(sprite);

        a := (right - left) / 2;
        b := (bottom - top) / 2;

        x := 0;
        y := b;

        a2 := a * a;
        b2 := b * b;
        a2b2 := a2 + b2;
        a2sqr := a2 + a2;
        b2sqr := b2 + b2;
        a4sqr := a2sqr + a2sqr;
        b4sqr := b2sqr + b2sqr;
        a8sqr := a4sqr + a4sqr;
        b8sqr := b4sqr + b4sqr;
        a4sqr_b4sqr := a4sqr + b4sqr;

        fn := a8sqr + a4sqr;
        fnn := a8sqr;
        fnnw := a8sqr;
        fnw := a8sqr + a4sqr - b8sqr*a + b8sqr;
        fnwn := a8sqr;
        fnwnw := a8sqr + b8sqr;
        fnww := b8sqr;
        fwnw := b8sqr;
        fww := b8sqr;
        d1 := b2 - b4sqr*a + a4sqr;

        while (fnw < a2b2) or (d1 < 0) or (((fnw - fn) > b2) and (y > 0)) loop

            put_pixel(left+x, top+y);
            put_pixel(right-x, top+y);
            put_pixel(left+x, bottom-y);
            put_pixel(right-x, bottom-y);

            y := y - 1;
            if (d1 < 0) or ((fnw - fn) > b2) then
                d1 := d1 + fn;
                fn := fn + fnn;
                fnw := fnw + fnwn;
            else
                x := x + 1;
                d1 := d1 + fnw;
                fn := fn + fnnw;
                fnw := fnw + fnwnw;
            end if;

        end loop;

        fw := fnw - fn + b4sqr;
        d2 := d1 + (fw+fw-fn-fn+a4sqr_b4sqr+a8sqr)/4;
        fnw := fnw + (b4sqr - a4sqr);

        while x <= a loop

            put_pixel(left+x, top+y);
            put_pixel(right-x, top+y);
            put_pixel(left+x, bottom-y);
            put_pixel(right-x, bottom-y);

            x := x + 1;
            if d2 < 0 then
                y := y - 1;
                d2 := d2 + fnw;
                fw := fw + fwnw;
                fnw := fnw + fnwnw;
            else
                d2 := d2 + fw;
                fw := fw + fww;
                fnw := fnw + fnww;
            end if;
        end loop;

    end draw_ellipse;

    procedure fill_ellipse(sprite :Gdk_Pixbuf;left :Gint;top :Gint;right :Gint;bottom :Gint; col :Rgba_Record)
    is
        w,h          : Gint;
        spritePixels : Rgba_Buffer_Access;

        a,b             : Gint;
        x,y             : Gint;
        a2,b2           : Gint;
        a2b2            : Gint;
        a2sqr           : Gint;
        b2sqr           : Gint;
        a4sqr           : Gint;
        b4sqr           : Gint;
        a8sqr           : Gint;
        b8sqr           : Gint;
        a4sqr_b4sqr     : Gint;
        fn              : Gint;
        fnn            : Gint;
        fnnw           : Gint;
        fnw            : Gint;
        fnwn           : Gint;
        fnwnw          : Gint;
        fnww           : Gint;
        fwnw           : Gint;
        fww            : Gint;
        d1,d2          : Gint;
        old_y          : Gint;
        fw             : Gint;

        procedure draw_horizontal_line(xLeft :Gint; xRight :Gint; y :Gint)
        is
        begin
            for x in xLeft..xRight loop
                spritePixels(Guint(x+y*w)) := col;
            end loop;
        end draw_horizontal_line;

    begin
        ---------------------------------------------
        w := Get_Width(sprite);
        h := Get_Height(sprite);

        spritePixels := Get_Pixels(sprite);

        a := (right - left) / 2;
        b := (bottom - top) / 2;

        x := 0;
        y := b;
        a2 := a * a;
        b2 := b * b;
        a2b2 := a2 + b2;
        a2sqr := a2 + a2;
        b2sqr := b2 + b2;
        a4sqr := a2sqr + a2sqr;
        b4sqr := b2sqr + b2sqr;
        a8sqr := a4sqr + a4sqr;
        b8sqr := b4sqr + b4sqr;
        a4sqr_b4sqr := a4sqr + b4sqr;
        fn := a8sqr + a4sqr;
        fnn := a8sqr;
        fnnw := a8sqr;
        fnw := a8sqr + a4sqr - b8sqr*a + b8sqr;
        fnwn := a8sqr;
        fnwnw := a8sqr + b8sqr;
        fnww := b8sqr;
        fwnw := b8sqr;
        fww := b8sqr;
        d1  := b2 - b4sqr*a + a4sqr;

        while (fnw < a2b2) or (d1 < 0) or (((fnw - fn) > b2) and (y > 0)) loop

            draw_horizontal_line(left+x, right-x, top+y);
            draw_horizontal_line(left+x, right-x, bottom-y);

            y := y - 1;
            if (d1 < 0) or ((fnw - fn) > b2) then
                d1 := d1 + fn;
                fn := fn + fnn;
                fnw := fnw + fnwn;
            else
                x := x + 1;
                d1 := d1 + fnw;
                fn := fn + fnnw;
                fnw := fnw + fnwnw;
            end if;

        end loop;

        fw := fnw - fn + b4sqr;
        d2 := d1 + (fw+fw-fn-fn+a4sqr_b4sqr+a8sqr)/4;
        fnw := fnw + (b4sqr - a4sqr);

        old_y := y + 1;

        while x <= a loop
            if y /= old_y then
                draw_horizontal_line(left+x, right-x, top+y);
                draw_horizontal_line(left+x, right-x, bottom-y);
            end if;

            old_y := y;

            x := x + 1;
            if d2 < 0 then
                y := y - 1;
                d2 := d2 + fnw;
                fw := fw + fwnw;
                fnw := fnw + fnwnw;
            else
                d2 := d2 + fw;
                fw := fw + fww;
                fnw := fnw + fnww;
            end if;

        end loop;

    end fill_ellipse;

    procedure flood_fill(sprite :Gdk_Pixbuf; px :Gint; py :Gint; fill_color :Rgba_Record)
    is
        w,h          : Gint;
        spritePixels : Rgba_Buffer_Access;

        x,tx         : Gint;
        y,ty         : Gint;
        fStartNord   : Boolean := False;
        fStartSud    : Boolean := False;
        xStartLine   : Gint := 0;
        xEndLine     : Gint := 0;
        fNord        : Boolean := False;
        fSud         : Boolean := False;
        pix_color    : Rgba_Record;
        f            : Boolean;
        target_color : Rgba_Record;
        start_x      : Gint;
        start_y      : Gint;

        type gdk_point is record
            x : Gint;
            y : Gint;
        end record;
        type gdk_point_access is access all gdk_point;

        package points_stack is new Ada.Containers.Vectors(
            Index_Type => Natural, 
            Element_Type => gdk_point);

        stk         : points_stack.Vector;
        pt          : gdk_point;

        procedure put_pixel(x :Gint; y:Gint) is
        begin
            spritePixels(Guint(x+y*w)) := fill_color;
        end put_pixel;

        function get_pixel(x :Gint; y:Gint) return Rgba_Record is
        begin
            return spritePixels(Guint(x+y*w));
        end get_pixel;

        function in_sprite(x : Gint; y : Gint) return Boolean is
        begin
            return px>=0 and px<w and py>=0 and py<h;
        end in_sprite;

    begin
        w := Get_Width(sprite);
        h := Get_Height(sprite);

        spritePixels := Get_Pixels(sprite);

        if not in_sprite(px,py) then
            return;
        end if;

        target_color := get_pixel(px, py);
        if target_color = fill_color then
            return;
        end if;

        stk.Append(New_Item => gdk_point'(x=>px,y=>py));

        while stk.Length /= 0 loop

            pt := stk.Element(stk.Last_Index);
            stk.Delete_Last;

            if not in_sprite(pt.x,pt.y) then
                exit;
            end if;

            start_x := pt.x;
            start_y := pt.y;

            -- Vérifier au Nord
            fStartNord := false;
            if start_y > 0 then
                tx := start_x;
                ty := start_y-1;
                if in_sprite(tx, ty) then
                    pix_color := get_pixel(tx, ty);
                    if pix_color = target_color then
                        stk.Append(New_Item => gdk_point'(tx,ty));
                        fStartNord := true;
                    end if;
                end if;
            end if;

            -- Vérifier au sud
            fStartSud := false;
            if start_y < (h - 1) then
                tx := start_x;
                ty := start_y+1;
                if in_sprite(tx,ty) then
                    pix_color := get_pixel(tx, ty);
                    if pix_color = target_color then
                        stk.Append(New_Item => gdk_point'(tx,ty));
                        fStartSud := true;
                    end if;
                end if;
            end if;

            y := start_y;

            -- Aller vers l'est
            xEndLine := start_x;
            fNord := fStartNord;
            fSud := fStartSud;
            if xEndLine < (w - 1) then

                x := xEndLine + 1;
                loop
                    if not in_sprite(x,y) or target_color/=get_pixel(x, y) then
                        exit;
                    end if;

                    -- Vérifier au Nord
                    tx := x;
                    ty := y-1;
                    if in_sprite(tx,ty) and (y > 0) then
                        pix_color := get_pixel(tx, ty);
                        if target_color = pix_color then
                            if not fNord then
                                stk.Append(New_Item => gdk_point'(tx,ty));
                                fNord := true;
                            end if;
                        else
                            fNord := false;
                        end if;
                    else
                        fNord := false;
                    end if;

                    -- Vérifier au sud
                    tx := x;
                    ty := y+1;
                    if in_sprite(tx,ty) and (y < (h - 1)) then
                        pix_color := get_pixel(tx, ty);
                        if target_color = pix_color then
                            if not fSud then
                                stk.Append(New_Item => gdk_point'(tx,ty));
                                fSud := true;
                            end if;
                        else
                            fSud := false;
                        end if;
                    else
                        fSud := false;
                    end if;

                    xEndLine := x;
                    x := x + 1;
                    if x >= w then
                        exit;
                    end if;
                end loop;

            else
                xEndLine := w - 1;

            end if;

            -- Aller vers l'ouest
            xStartLine := start_x;
            fNord := fStartNord;
            fSud := fStartSud;
            if xStartLine > 0 then

                x := xStartLine - 1;

                loop

                    if not in_sprite(x,y) or (target_color/=get_pixel(x, y)) then
                        exit;
                    end if;

                    -- Vérifier au Nord
                    tx := x;
                    ty := y-1;
                    if in_sprite(tx,ty) and (y > 0) then
                        pix_color := get_pixel(tx, ty);
                        if target_color = pix_color then
                            if not fNord then
                                stk.Append(New_Item => gdk_point'(tx,ty));
                                fNord := true;
                            end if;
                        else
                            fNord := false;
                        end if;
                    else
                        fNord := false;
                    end if;

                    -- Vérifier au sud
                    tx := x;
                    ty := y+1;
                    if (y < (h - 1)) and in_sprite(tx,ty) then
                        pix_color := get_pixel(tx, ty);
                        if target_color = pix_color then
                            if not fSud then
                                stk.Append(New_Item => gdk_point'(tx,ty));
                                fSud := true;
                            end if;
                        else
                            fSud := false;
                        end if;
                    else 
                        fSud := false;
                    end if;

                    xStartLine := x;
                    x := x - 1;
                    if x < 0 then
                        exit;
                    end if;
                end loop;

            else
                xStartLine := 0;
            end if;

            -- Tracer la line
            for x in xStartLine..xEndLine loop
                put_pixel(x, y);
            end loop;

        end loop;

    end flood_fill;

    procedure flip_horizontaly( spriteSrc :Gdk_Pixbuf; spriteDes :Gdk_Pixbuf)
    is
        w,h                 : Gint;
        widthSpr,heightSpr  : Gint;
        srcPixels           : Rgba_Buffer_Access;
        desPixels           : Rgba_Buffer_Access;
        ipSrc, ipDes,yOffset: Gint;

    begin
        ---------------------------------------------------------
        widthSpr  := Get_Width(spriteSrc);
        heightSpr := Get_Height(spriteSrc);

        srcPixels := Get_Pixels(spriteSrc);
        desPixels := Get_Pixels(spriteDes);


        w := widthSpr - 1;
        for y in 0..(heightSpr-1) loop
            yOffset := y * widthSpr;
            for x in 0..(widthSpr-1) loop
                ipSrc := (yOffset + x);
                ipDes := (yOffset + w-x);
                desPixels(Guint(ipDes)) := srcPixels(Guint(ipSrc));
            end loop;
        end loop;

    end flip_horizontaly;

    procedure flip_verticaly( spriteSrc :Gdk_Pixbuf; spriteDes :Gdk_Pixbuf)
    is
        w,h                    : Gint;
        widthSpr,heightSpr     : Gint;
        srcPixels              : Rgba_Buffer_Access;
        desPixels              : Rgba_Buffer_Access;
        ySrcOffset, yDesOffset : Gint;

    begin
        ---------------------------------------------------------

        widthSpr  := Get_Width(spriteSrc);
        heightSpr := Get_Height(spriteSrc);

        srcPixels := Get_Pixels(spriteSrc);
        desPixels := Get_Pixels(spriteDes);

        h := heightSpr - 1;
        for y in 0..(heightSpr-1) loop
            ySrcOffset := y * widthSpr;
            yDesOffset := (h - y) * widthSpr;
            for x in 00..(widthSpr-1) loop
                desPixels(Guint(yDesOffset+x)) := srcPixels(Guint(ySrcOffset+x));
            end loop;

        end loop;

    end flip_verticaly;

    procedure swing_left( spriteSrc :Gdk_Pixbuf; spriteDes :Gdk_Pixbuf)
    is
        w,h                    : Gint;
        widthSpr,heightSpr     : Gint;
        srcPixels              : Rgba_Buffer_Access;
        desPixels              : Rgba_Buffer_Access;
        offSetH                : Gint;

    begin
        ---------------------------------------------------------
        widthSpr  := Get_Width(spriteSrc);
        heightSpr := Get_Height(spriteSrc);

        srcPixels := Get_Pixels(spriteSrc);
        desPixels := Get_Pixels(spriteDes);

        offSetH := widthSpr - 1;

        for x in 0..(widthSpr-1) loop
            for y in 0..(heightSpr-1) loop
                desPixels(Guint(y + (offSetH-x)*widthSpr)) := srcPixels(Guint(x + y*widthSpr));

            end loop;

        end loop;

    end swing_left;

    procedure swing_right( spriteSrc :Gdk_Pixbuf; spriteDes :Gdk_Pixbuf)
    is
        w,h                    : Gint;
        widthSpr,heightSpr     : Gint;
        srcPixels              : Rgba_Buffer_Access;
        desPixels              : Rgba_Buffer_Access;
        offSetW                : Gint;

    begin
        ---------------------------------------------------------
        widthSpr  := Get_Width(spriteSrc);
        heightSpr := Get_Height(spriteSrc);

        srcPixels := Get_Pixels(spriteSrc);
        desPixels := Get_Pixels(spriteDes);

        offSetW := heightSpr - 1;

        for x in 0..(widthSpr-1) loop
            for y in 0..(heightSpr-1) loop
                desPixels(Guint(offSetW-y + x*widthSpr)) := srcPixels(Guint(x + y*widthSpr));

            end loop;
        end loop;

    end swing_right;

end widget_editarea;