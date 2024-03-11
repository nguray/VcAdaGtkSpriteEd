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

package body p_pencil_mode is

    package Internal_Cb is new Gtk.Handlers.Callback(widget_editarea.editarea_record);

    procedure SetPixel(pixbuf : Gdk_Pixbuf; x:Gint; y : Gint; color : Rgba_Record) 
    is
        spriteWidth : Gint;
        spriteHeight : Gint;
        spritePixels : Rgba_Buffer_Access;
    begin
        spriteWidth := Get_Width(curSprite);
        spriteHeight := Get_Height(curSprite);
        spritePixels := Get_Pixels(curSprite);

        if x>=0 and x<(spriteWidth) and y>=0 and y<(spriteHeight) then
            spritePixels(Guint(x+y*spriteWidth)) := color;
        end if;

    end;

    function GetPixel(pixbuf : Gdk_Pixbuf; x:Gint; y : Gint) return Rgba_Record
    is
        spriteWidth : Gint;
        spriteHeight : Gint;
        spritePixels : Rgba_Buffer_Access;
    begin
        spriteWidth := Get_Width(curSprite);
        spriteHeight := Get_Height(curSprite);
        spritePixels := Get_Pixels(curSprite);

        if x>=0 and x<(spriteWidth) and y>=0 and y<(spriteHeight) then
            return spritePixels(Guint(x+y*spriteWidth));
        else
            return Rgba_Record'(0,0,0,0);
        end if;

    end;

    function btn_press_evt_cb(
            Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
            Event : Gdk.Event.Gdk_Event_Button
        ) return  Boolean
    is
        self1 : editarea := editarea(Self);
        pixX : Gint;
        pixY : Gint;
    begin
        if Event.Button = GLib.Guint(Gdk.Event.Button_Primary) then
            pixX := MouseToPixelX(self1,Gint(Event.X));
            pixY := MouseToPixelY(self1,Gint(Event.Y));
            if (Event.State and Shift_Mask)/=0 then
                SetForegroundColor(self1, GetPixel(curSprite, pixX, pixY));
                Internal_Cb.Emit_By_Name (self1, "pick_color", Gint(10));
            else
                BackupSprite;
                if (Event.State and Control_Mask)/=0 then
                    DrawLine(curSprite,GetLastX(self1),GetLastY(self1),pixX,pixY,GetForeGroundColor(self1));
                else
                    SetPixel(curSprite,pixX,pixY,GetForeGroundColor(self1));
                end if;
                Internal_Cb.Emit_By_Name (self1, "changed");
                self1.Queue_Draw;
            end if;
        elsif Event.Button = GLib.Guint(Gdk.Event.Button_Secondary) then
            pixX := MouseToPixelX(self1,Gint(Event.X));
            pixY := MouseToPixelY(self1,Gint(Event.Y));
            if (Event.State and Shift_Mask)/=0 then
                SetBackgroundColor(self1, GetPixel(curSprite, pixX, pixY));
                Internal_Cb.Emit_By_Name (self1, "pick_color");
            else
                BackupSprite;
                if (Event.State and Control_Mask)/=0 then
                    DrawLine(curSprite,GetLastX(self1),GetLastY(self1),pixX,pixY,GetBackGroundColor(self1));
                else
                    SetPixel(curSprite,pixX,pixY,GetBackGroundColor(self1));
                end if;
                Internal_Cb.Emit_By_Name (self1, "changed");
                self1.Queue_Draw;
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
        if (Event.State and Gdk.Types.Button1_Mask) > 0 then
                pixX := MouseToPixelX(self1,Gint(Event.X));
                pixY := MouseToPixelY(self1,Gint(Event.Y));
                if (Event.State and Control_Mask)/=0 then
                    RestoreSprite;
                    DrawLine(curSprite,GetLastX(self1),GetLastY(self1),pixX,pixY,GetForeGroundColor(self1));
                else
                    SetPixel(curSprite,pixX,pixY,GetForeGroundColor(self1));
                    SetLastX(self1,pixX);
                    SetLastY(self1,pixY);
                end if;
                Internal_Cb.Emit_By_Name (self1, "changed");
                self1.Queue_Draw;

        elsif (Event.State and Gdk.Types.Button3_Mask) > 0 then

            pixX := MouseToPixelX(self1,Gint(Event.X));
            pixY := MouseToPixelY(self1,Gint(Event.Y));
            if (Event.State and Control_Mask)/=0 then
                RestoreSprite;
                DrawLine(curSprite,GetLastX(self1),GetLastY(self1),pixX,pixY,GetBackGroundColor(self1));
            else
                SetPixel(curSprite,pixX,pixY,GetBackGroundColor(self1));
                SetLastX(self1,pixX);
                SetLastY(self1,pixY);
            end if;
            Internal_Cb.Emit_By_Name (self1, "changed");
            self1.Queue_Draw;

        end if;
        -- We've handled the event, stop processing
        return True;
    end motion_notify_evt_cb;


end p_pencil_mode;