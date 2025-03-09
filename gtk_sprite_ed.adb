-- units from Gtk
with Gtk;               use Gtk;
with Gtk.Main;
with Glib.Error;        use Glib.Error;
with Gtk.Widget;        use Gtk.Widget;
with Gtk.Builder;       use Gtk.Builder;
with Gtk.Tool_Button;   use Gtk.Tool_Button;
with Gtk.Image;         use Gtk.Image;
with Gtk.Dialog;        use Gtk.Dialog;
with Gtk.Window;        use Gtk.Window;
with Gtk.Box;           use Gtk.Box;
with Gtkada.Builder;    use Gtkada.Builder;
with Glib.Object;       use Glib.Object;
with Gdk.Pixbuf;        use Gdk.Pixbuf;

with Glib.Properties;
with Gdk.Color;                   use Gdk.Color;
with Gdk.RGBA;                    use Gdk.RGBA;
with Gtk.Color_Selection;         use Gtk.Color_Selection;
with Gtk.Color_Selection_Dialog;  use Gtk.Color_Selection_Dialog;
with Gtk.Widget;                  use Gtk.Widget;
with Gtk.Button;                  use Gtk.Button;
with Gtk.Enums;                   use Gtk.Enums;


-- Ada predefined units
with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;

-- Application specific units
with sprite_ed_data;    use sprite_ed_data;
with Window1_Callbacks; use Window1_Callbacks;
with widget_editarea;   use widget_editarea;
with widget_palette;    use widget_palette;
with widget_spritesbar; use widget_spritesbar;
with p_select;          use p_select;

procedure gtk_sprite_ed is

   Builder       : Gtkada_Builder;
   vBox2         : Gtk_Box;
   hBox1         : Gtk_Box;

   Error         : aliased Glib.Error.GError;
   GladeFileName : constant String := "res/gtk_sprite_ed.glade";
   use type Glib.Guint;

begin

   Gtk.Main.Init;

   -- Step 1: create a Builder and add the XML data on_menu_item_quit_activate
   Gtk_New (Builder);

   if Add_From_File (Gtk_Builder(Builder), GladeFileName, Error'Access) = 0 then
      Put_Line ("Error : " & Get_Message (Error));
      Error_Free (Error);
      return;
   end if;
   
   --  Step 2: add calls to "Register_Handler" to associate your
   --  handlers with your callbacks.
   Register_Handler (Builder, "on_window1_destroy", on_window1_destroy'Access);
   Register_Handler (Builder, "on_SelectMode_clicked", on_select_mode'Access);
   Register_Handler (Builder, "on_PencilMode_clicked", on_pencil_mode'Access);
   Register_Handler (Builder, "on_RectangleMode_clicked", on_rectangle_mode'Access);
   Register_Handler (Builder, "on_EllipseMode_clicked", on_ellipse_mode'Access);
   Register_Handler (Builder, "on_FloodFillMode_clicked", on_flood_fill_mode'Access);

   Register_Handler (Builder, "on_menu_item_quit_activate", on_menu_quit'Access);
   Register_Handler (Builder, "on_menu_item_new_activate", on_menu_new'Access);
   Register_Handler (Builder, "on_menu_item_open_activate", on_menu_open'Access);
   Register_Handler (Builder, "on_menu_item_save_activate", on_menu_save'Access);
   Register_Handler (Builder, "on_menu_item_save_as_activate", on_menu_save_as'Access);
   Register_Handler (Builder, "on_menu_item_undo_activate", on_menu_undo'Access);
   Register_Handler (Builder, "on_menu_item_cut_activate", on_menu_cut'Access);
   Register_Handler (Builder, "on_menu_item_copy_activate", on_menu_copy'Access);
   Register_Handler (Builder, "on_menu_item_paste_activate", on_menu_paste'Access);
   Register_Handler (Builder, "on_menu_item_about_activate", on_menu_about'Access);
   Register_Handler (Builder, "on_menu_flip_horizontaly_activate", on_menu_flip_horizontaly'Access);
   Register_Handler (Builder, "on_menu_flip_verticaly_activate", on_menu_flip_verticaly'Access);
   Register_Handler (Builder, "on_menu_swing_left_activate", on_menu_swing_left'Access);
   Register_Handler (Builder, "on_menu_swing_right_activate", on_menu_swing_right'Access);


   -- Step 3: call Do_Connect. Once to connect all registered handlers
   Do_Connect (Builder);

   mainWin := Gtk_Window (Builder.Get_Object("window1"));
   currToolBtn := Gtk_Tool_Button (Builder.Get_Object("CurrentMode"));
   selectImage := Gtk_Image (Builder.Get_Object("imageSelectBox1"));
   pencilImage := Gtk_Image (Builder.Get_Object("imagePencil1"));
   rectangleImage := Gtk_Image (Builder.Get_Object("imageRectangle1"));
   ellipseImage := Gtk_Image (Builder.Get_Object("imageEllipse1"));
   floodFillImage := Gtk_Image (Builder.Get_Object("imageFill1"));
   playImage := Gtk_Image (Builder.Get_Object("imagePlay1"));
   aboutDlg := Gtk_Dialog (Builder.Get_Object("AboutDialog1"));

   vBox2 := Gtk_Box(Builder.Get_Object("VBox2"));
   hBox1 := Gtk_Box(Builder.Get_Object("HBox1"));

   --select_rect := new selrect;
   --copy_rect := new selrect_record;

   for i in IndexSpriteArray loop
      tblSprites(i) := Gdk_New(Colorspace=> Colorspace_RGB,Has_Alpha => True,Width => 32, Height => 32);
      Gdk.Pixbuf.Fill(tblSprites(i),16#00000000#);
   end loop;

   Gtk_New(editarea1);
   SetCurrentSprite(editarea1, tblSprites(0));
   hBox1.Pack_Start(editarea1);
   Gtk_New(spritesbar1);
   hBox1.Pack_End(spritesbar1,Expand=>False, Fill=>False, Padding=>4);

   Gtk_New(palette1);
   LoadPalette(palette1);
   vBox2.Pack_End(palette1, Expand=>False, Fill=>False, Padding=>4);

   Palette_Cb.Connect (palette1, "color_changed", Palette_Cb.To_Marshaller (palette_color_changed_cb'Access),0);
   Palette_Cb.Connect (palette1, "color_dialog", Palette_Cb.To_Marshaller (palette_color_dialog_cb'Access),0);
   -- Update editarea pencil colors
   palette_color_changed_cb(palette1, 0);

   EditArea_Cb.Connect (editarea1, "changed", EditArea_Cb.To_Marshaller (editarea_changed'Access),0);
   EditArea_Cb.Connect (editarea1, "pick_color", EditArea_Cb.To_Marshaller (editarea_pick_color'Access),0);

   SpritesBar_Cb.Connect (spritesbar1, "spritesbar_changed", SpritesBar_Cb.To_Marshaller (spritesbar_changed'Access),0);
 
   -- Step 3.5 : display the windows and all of their children.
   --            Remove objects than are not windows as necessary.
   Show_All (Gtk_Widget (Get_Object (GTK_Builder (Builder), "window1")));

   Gtk.Main.Main;

   --  Step 4: when the application terminates
   --          call Unref to free memory associated with the Builder.
   Unref (Builder);
   for i in IndexSpriteArray loop
      if tblSprites(i)/=Null_Pixbuf then
         Unref(tblSprites(i));
      end if;
   end loop;
   if copySprite/=Null_Pixbuf then
      Unref(copySprite);
   end if;
   if bakSprite/=Null_Pixbuf then
      Unref(bakSprite);
   end if;

   Put_Line ("Program gtk_sprite_ed is finished !");

end gtk_sprite_ed;