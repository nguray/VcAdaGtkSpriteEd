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

package body p_select_mode is

    package Internal_Cb is new Gtk.Handlers.Callback(widget_editarea.editarea_record);

    function btn_press_evt_cb(
            Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
            Event : Gdk.Event.Gdk_Event_Button
        ) return  Boolean
    is
        self1 : editarea := editarea(Self);
        pixX : Gint;
        pixY : Gint;
        idHandle : Gint; 
    begin
        if Event.Button = GLib.Guint(Gdk.Event.Button_Primary) then
                pixX := MouseToPixelX(self1,Gint(Event.X));
                pixY := MouseToPixelY(self1,Gint(Event.Y));
                if PtInEditArea(self1,  pixX, pixY) then
                    case selRect.mode is
                    when 0 =>
                        BackupSprite;
                        selRect.SetCorner(0,pixX,pixY);
                        selRect.SetCorner(2,pixX,pixY);
                        self1.Queue_Draw;
                    when 1 =>
                        if InSelectRect(self1, Event.X, Event.Y) then
                            idHandle := HitHandle( Self1, Event.X, Event.Y);
                            if idHandle/=-1 then
                                -- Start Move Handle
                                selRect.sel_corner := idHandle;
                            else
                                --  Start Move SelectRect
                                selRect.mouseStartX := Gdouble(Event.X);
                                selRect.mouseStartY := Gdouble(Event.Y);
                                selRect.BackupPosition;
                            end if;
                        else
                            --
                            selRect.mode := 0;
                            selRect.SetCorner( 0, pixX, pixY);
                            selRect.SetCorner( 2, pixX, pixY);
                            selRect.sel_corner := -1;
                            self1.Queue_Draw;
                        end if;
                    when 2 =>
                        if InSelectRect(self1, Event.X, Event.Y) then
                            --
                            selRect.mouseStartX := Event.X;
                            selRect.mouseStartY := Event.Y;
                            selRect.BackupPosition;                        
                        else
                            selRect.mode := 0;
                            selRect.SetCorner( 0, pixX, pixY);
                            selRect.SetCorner( 2, pixX, pixY);
                            selRect.sel_corner := -1;
                        end if;
                        self1.Queue_Draw;
                    when others =>

                        null;
                    end case;

                end if;

        elsif Event.Button = GLib.Guint(Gdk.Event.Button_Secondary) then
            null;
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
                if PtInEditArea(self1, pixX, pixY) then
                    case  selRect.mode is
                    when 0 =>
                        selRect.SetCorner( 2, pixX, pixY);
                        self1.Queue_Draw;

                    when 1 =>
                        if selRect.sel_corner /= -1 then
                            selRect.SetCorner( selRect.sel_corner, pixX, pixY);
                            self1.Queue_Draw;
                        else
                            mdx := Event.X - Gdouble(selRect.mouseStartX);
                            mdy := Event.Y - Gdouble(selRect.mouseStartY);
                            dx := MouseToPixelX(self1,Gint(mdx));
                            dy := MouseToPixelY(self1,Gint(mdy));
                            if dx/=0 or dy/=0 then
                                left  := Gint(selRect.bak_left) + dx;
                                top   := Gint(selRect.bak_top) + dy;
                                right := Gint(selRect.bak_right) + dx;
                                bottom := Gint(selRect.bak_bottom) + dy;
                                -- Prevent the rectangle to go out limits
                                if (left < 0) or (right >= GetNbPixelsHeight(self1)) then
                                    left := Gint(selRect.left);
                                    right := Gint(selRect.right);
                                end if;
                                if (top < 0) or (bottom >= GetNbPixelsHeight(self1)) then
                                    top := Gint(selRect.top);
                                    bottom := Gint(selRect.bottom);
                                end if;
                                --select_rect.SetCorner(0, left, top);
                                selRect.SetCorner(0, left, top);
                                selRect.SetCorner(2, right, bottom);
                                self1.Queue_Draw;
                            end if;
                        end if;

                    when 2 =>
                        mdx := Event.X - Gdouble(selRect.mouseStartX);
                        mdy := Event.Y - Gdouble(selRect.mouseStartY);
                        dx := MouseToPixelX(self1,Gint(mdx));
                        dy := MouseToPixelY(self1,Gint(mdy));
                        if dx /= 0 or dy /= 0 then
                            left  := Gint(selRect.bak_left) + dx;
                            top   := Gint(selRect.bak_top) + dy;
                            right := Gint(selRect.bak_right) + dx;
                            bottom := Gint(selRect.bak_bottom) + dy;
                            -- Prevent the rectangle to go out limits
                            SrcX := 0;
                            if left < 0 then
                                SrcX := -left;
                                left := 0;
                            elsif right >= GetNbPixelsWidth(self1) then
                                right := GetNbPixelsWidth(self1)-1;
                            end if;
                            SrcY := 0;
                            if top < 0 then
                                SrcY := -top;
                                top := 0;
                            elsif bottom >= GetNbPixelsHeight(self1) then
                                bottom := GetNbPixelsHeight(self1)-1;
                            end if;
                            selRect.SetCorner(0, left, top);
                            selRect.SetCorner(2, right, bottom);
                            RestoreSprite;
                            Copy_Area(copySprite, SrcX, SrcY, selRect.Width, selRect.Height, curSprite, selRect.left, selRect.top);
                            Internal_Cb.Emit_By_Name (self1, "changed");
                            self1.Queue_Draw;
                            --if ea.pixbufModify != nil then
                            --    ea.pixbufModify()
                            --end if;

                        end if;
                        --return !ea.selectRect.IsEmpty()
                    when others =>
                        null;
                    end case;

                end if;

        end if;
        -- We've handled the event, stop processing
        return True;
    end motion_notify_evt_cb;

end p_select_mode;