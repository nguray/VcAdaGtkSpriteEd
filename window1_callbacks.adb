
with System;
with Glib;       use Glib;
with Glib.Properties;
with Gtk.Enums;  use Gtk.Enums;
with Gtk.Widget; use Gtk.Widget;
with Gtk.Window; use Gtk.Window;
with Gtk.File_Filter;         use Gtk.File_Filter;
with Gtk.Dialog;              use Gtk.Dialog;
with Gtkada.File_Selection;   use Gtkada.File_Selection;
with Gdk.Pixbuf;              use Gdk.Pixbuf;
with Glib.Error;              use Glib.Error;
with Gtk.File_Chooser_Dialog; use Gtk.File_Chooser_Dialog;
with Gtk.File_Chooser; use Gtk.File_Chooser;
with Gtk.Settings;            use Gtk.Settings;
with Gdk.Screen;        use Gdk.Screen;
with Gdk.Display;       use Gdk.Display;


-- units from Gtk
with Gtk.Main;       use Gtk.Main;

-- Ada predefined units
with Ada.Text_IO;    use Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

-- Application specific units
with my_rgba;           use my_rgba;
with sprite_ed_data;    use sprite_ed_data;
with widget_editarea;   use widget_editarea;
with widget_palette;    use widget_palette;
with widget_spritesbar;    use widget_spritesbar;

package body Window1_Callbacks  is

   -----------------------------------------------
   -- On_Window1_Delete_Event
   -----------------------------------------------
   procedure on_window1_destroy  (Builder : access Gtkada_Builder_Record'Class) is
      pragma Unreferenced (Builder);
   begin
      widget_palette.SavePalette(palette1);

      Gtk.Main.Main_Quit;
   
   end on_window1_destroy;

   -----------------------------------------------
   -- On_SelectMode_Clicked
   -----------------------------------------------
   procedure on_select_mode (Builder : access Gtkada_Builder_Record'Class) is
      pragma Unreferenced (Builder);
   begin
      widget_editarea.SetSelectMode(editarea1);

   end on_select_mode;

   -----------------------------------------------
   -- On_PencilMode_Clicked
   -----------------------------------------------
   procedure on_pencil_mode (Builder : access Gtkada_Builder_Record'Class) is
      pragma Unreferenced (Builder);
   begin
      widget_editarea.SetPencilMode(editarea1);

   end on_pencil_mode;

   -----------------------------------------------
   -- On_RectangleMode_Clicked
   -----------------------------------------------
   procedure on_rectangle_mode (Builder : access Gtkada_Builder_Record'Class) is
      pragma Unreferenced (Builder);
   begin
      widget_editarea.SetRectangleMode(editarea1);

   end on_rectangle_mode;

   -----------------------------------------------
   -- On_EllipseMode_Clicked
   -----------------------------------------------
   procedure on_ellipse_mode (Builder : access Gtkada_Builder_Record'Class) is
      pragma Unreferenced (Builder);
   begin
      widget_editarea.SetEllipseMode(editarea1);

   end on_ellipse_mode;

   -----------------------------------------------
   -- On_FloodFillMode_Clicked
   -----------------------------------------------
   procedure on_flood_fill_mode (Builder : access Gtkada_Builder_Record'Class) is
      pragma Unreferenced (Builder);
   begin
      widget_editarea.SetFillMode(editarea1);

   end on_flood_fill_mode;

   -----------------------------------------------
   -- Menu File Quit
   -----------------------------------------------
   procedure on_menu_quit  (Builder : access Gtkada_Builder_Record'Class) is
      pragma Unreferenced (Builder);
   begin
      
      widget_palette.SavePalette(palette1);

      Gtk.Main.Main_Quit;
   
   end on_menu_quit;

   -----------------------------------------------
   -- Menu File New
   -----------------------------------------------
   procedure on_menu_new  (Builder : access Gtkada_Builder_Record'Class) is
      pragma Unreferenced (Builder);
      idSelect     : Gint;
   begin
      idSelect := GetSelectSpriteIndex(spritesbar1);
      Unref(curSprite);
      curSprite := Gdk_New(Colorspace=> Colorspace_RGB,Has_Alpha => True,Width => 32, Height => 32);
      fullPathName := To_Unbounded_String("");
      tblSprites(IndexSpriteArray(idSelect)) := curSprite;
      SetCurrentSprite(editarea1,curSprite);
      tblFileNames(IndexSpriteArray(idSelect)) := fullPathName;
      spritesbar1.Queue_Draw;
      editarea1.Queue_Draw;

   end on_menu_new;

   -----------------------------------------------
   -- Menu File Open
   -----------------------------------------------
   procedure on_menu_open  (Builder : access Gtkada_Builder_Record'Class) 
   is
      file_dialog1 : Gtk_File_Chooser_Dialog;
      filter1 : Gtk_File_Filter;
      filter2 : Gtk_File_Filter;
      ok_widget : Gtk_Widget;
      no_widget : Gtk_Widget;
      res          : Gtk_Response_Type;
      Error        : Glib.Error.GError;
      resString    : Unbounded_String;
      idSelect     : Gint;
   begin
      --
      file_dialog1 := Gtk_File_Chooser_Dialog_New( "Select file",Gtk_Window (Builder.Get_Object("window1")), Action_Open);
      filter1 := Gtk_File_Filter_New;
      filter1.Set_Name("PNG Files");
      filter1.Add_Pattern("*.png");
      file_dialog1.Add_Filter(filter1);
      filter2 := Gtk_File_Filter_New;
      filter2.Set_Name("All Files");
      filter2.Add_Pattern("*");
      file_dialog1.Add_Filter(filter2);
      ok_widget := Gtk.Dialog.Add_Button(Gtk_Dialog(file_dialog1),"Load", Gtk_Response_OK);
      no_widget := Gtk.Dialog.Add_Button(Gtk_Dialog(file_dialog1),"Cancel", Gtk_Response_No);
      res := Gtk.Dialog.Run(Gtk_Dialog(file_dialog1));
      if res=Gtk_Response_OK then
         declare
            l         : Natural;
            resString : Unbounded_String := To_Unbounded_String(file_dialog1.Get_Filename);
         begin
            l := Length(resString);
            if l>0 then
               --
               if l>4 then
                  declare
                     suffixe : Unbounded_String := Unbounded_Slice(resString,(l-3),l);
                  begin
                     if suffixe=".png" or suffixe=".PNG" then
                        fullPathName := resString;
                        Unref(curSprite);
                        Gdk_New_From_File (curSprite, To_String(resString), Error);
                        idSelect := GetSelectSpriteIndex(spritesbar1);
                        tblSprites(IndexSpriteArray(idSelect)) := curSprite;
                        SetCurrentSprite(editarea1,curSprite);
                        tblFileNames(IndexSpriteArray(idSelect)) := fullPathName;
                        spritesbar1.Queue_Draw;
                        editarea1.Queue_Draw;
                     end if;       
                  end;
               end if;
            end if;
         end;
      end if;
      file_dialog1.Destroy;

   end on_menu_open;

   -----------------------------------------------
   -- Menu File Save
   -----------------------------------------------
   procedure on_menu_save  (Builder : access Gtkada_Builder_Record'Class) 
   is
      Error        : Glib.Error.GError;
   begin
      if fullPathName="" then
         --
         on_menu_save_as(Builder);
      
      else
         --
         Save(curSprite, To_String(fullPathName), PNG, Error);

      end if;

   end on_menu_save;
   
   -----------------------------------------------
   -- Menu File Save As
   -----------------------------------------------
   procedure on_menu_save_as  (Builder : access Gtkada_Builder_Record'Class) 
   is
      --pragma Unreferenced (Builder);
      file_dialog1 : Gtk_File_Chooser_Dialog;
      filter1     : Gtk_File_Filter;
      filter2     : Gtk_File_Filter;
      ok_widget   : Gtk_Widget;
      no_widget   : Gtk_Widget;
      res         : Gtk_Response_Type;
      Error       : Glib.Error.GError;
   begin
      --
      file_dialog1 := Gtk_File_Chooser_Dialog_New( "Save as ...",Gtk_Window (Builder.Get_Object("window1")), Action_Save);
      filter1 := Gtk_File_Filter_New;
      filter1.Set_Name("PNG Files");
      filter1.Add_Pattern("*.png");
      file_dialog1.Add_Filter(filter1);
      filter2 := Gtk_File_Filter_New;
      filter2.Set_Name("All Files");
      filter2.Add_Pattern("*");
      file_dialog1.Add_Filter(filter2);
      ok_widget := Gtk.Dialog.Add_Button(Gtk_Dialog(file_dialog1),"Save", Gtk_Response_OK);
      no_widget := Gtk.Dialog.Add_Button(Gtk_Dialog(file_dialog1),"Cancel", Gtk_Response_No);
      res := Gtk.Dialog.Run(Gtk_Dialog(file_dialog1));
      if res=Gtk_Response_OK then
         declare
            l           : Natural;
            idSelect    : Gint;
            resString   : Unbounded_String := To_Unbounded_String(file_dialog1.Get_Filename);
         begin
            l := Length(resString);
            if l>0 then
               --
               if l>4 then
                  declare
                     suffixe : Unbounded_String := Unbounded_Slice(resString,(l-3),l);
                  begin
                     --Put_Line("suffixe --> " & To_String(suffixe));
                     if suffixe/=".png" and suffixe/=".PNG" then
                        fullPathName := resString & ".png";
                     else
                        fullPathName := resString;
                     end if;       
                  end;
               else
                  fullPathName := resString & ".png";
               end if;
               --
               Save(curSprite, To_String(fullPathName), PNG, Error);
               idSelect := GetSelectSpriteIndex(spritesbar1);
               tblFileNames(IndexSpriteArray(idSelect)) := fullPathName;
               spritesbar1.Queue_Draw;
               editarea1.Queue_Draw;

            end if;
         end;
      end if;
      file_dialog1.Destroy;

   end on_menu_save_as;

   -----------------------------------------------
   -- Menu Edit Undo
   -----------------------------------------------
   procedure on_menu_undo  (Builder : access Gtkada_Builder_Record'Class) 
   is
      Error        : Glib.Error.GError;
   begin
      UndoEdit(editarea1);

   end on_menu_undo;

   -----------------------------------------------
   -- Menu Edit Cut
   -----------------------------------------------
   procedure on_menu_cut  (Builder : access Gtkada_Builder_Record'Class) 
   is
      Error        : Glib.Error.GError;
   begin
      CutSelect(editarea1);

   end on_menu_cut;

   -----------------------------------------------
   -- Menu Edit Copy
   -----------------------------------------------
   procedure on_menu_copy  (Builder : access Gtkada_Builder_Record'Class) 
   is
      Error        : Glib.Error.GError;
   begin
      CopySelect(editarea1);

   end on_menu_copy;

   -----------------------------------------------
   -- Menu Edit Paste
   -----------------------------------------------
   procedure on_menu_paste  (Builder : access Gtkada_Builder_Record'Class) 
   is
      Error        : Glib.Error.GError;
   begin
      PasteSelect(editarea1);
      
   end on_menu_paste;

   -----------------------------------------------
   -- Menu Edit About
   -----------------------------------------------
   procedure on_menu_about  (Builder : access Gtkada_Builder_Record'Class) 
   is
      res          : Gtk_Response_Type;
      Error        : Glib.Error.GError;
   begin
      Gtk.Dialog.Set_Destroy_With_Parent(aboutDlg,true);
      Gtk.Dialog.Set_Modal(aboutDlg);
      Gtk.Dialog.Set_Transient_For(aboutDlg,mainWin);
      Gtk.Dialog.Set_Position(aboutDlg, Win_Pos_Center_On_Parent);
      res := Gtk.Dialog.Run(aboutDlg);
      Gtk.Dialog.Hide(aboutDlg);
      
   end on_menu_about;

   -----------------------------------------------
   -- Menu Flip Horizontaly
   -----------------------------------------------
   procedure on_menu_flip_horizontaly  (Builder : access Gtkada_Builder_Record'Class) 
   is
      res          : Gtk_Response_Type;
      Error        : Glib.Error.GError;
   begin
      BackupSprite;
      flip_horizontaly( bakSprite, curSprite);
      editarea1.Queue_Draw;

   end on_menu_flip_horizontaly;

   -----------------------------------------------
   -- Menu Flip Horizontaly
   -----------------------------------------------
   procedure on_menu_flip_verticaly  (Builder : access Gtkada_Builder_Record'Class) 
   is
      res          : Gtk_Response_Type;
      Error        : Glib.Error.GError;
   begin
      BackupSprite;
      flip_verticaly( bakSprite, curSprite);
      editarea1.Queue_Draw;

   end on_menu_flip_verticaly;

   -----------------------------------------------
   -- Menu Swing Left
   -----------------------------------------------
   procedure on_menu_swing_left  (Builder : access Gtkada_Builder_Record'Class) 
   is
      res          : Gtk_Response_Type;
      Error        : Glib.Error.GError;
   begin
      BackupSprite;
      swing_left( bakSprite, curSprite);
      editarea1.Queue_Draw;

   end on_menu_swing_left;

   -----------------------------------------------
   -- Menu Swing Right
   -----------------------------------------------
   procedure on_menu_swing_right  (Builder : access Gtkada_Builder_Record'Class) 
   is
      res          : Gtk_Response_Type;
      Error        : Glib.Error.GError;
   begin
      BackupSprite;
      swing_right( bakSprite, curSprite);
      editarea1.Queue_Draw;

   end on_menu_swing_right;



   procedure editarea_changed
      (Widget  : access editarea_record'Class; userdat : Gint)
   is
   begin
      --Put_Line ("Editarea Changed");
      spritesbar1.Queue_Draw;
   end editarea_changed;

   procedure editarea_pick_color
      (Widget  : access editarea_record'Class; userdat : Gint)
   is
      color : Rgba_Record;
   begin
      Put_Line ("EditArea Pick Color");
      color := widget_editarea.GetForegroundColor(editarea1);  
      widget_palette.SetForegroundColor(palette1,color);
      color := widget_editarea.GetBackgroundColor(editarea1);  
      widget_palette.SetBackgroundColor(palette1,color);
   end editarea_pick_color;

   procedure palette_color_changed_cb
      (Widget  : access palette_record'Class; userdat : Gint)
   is
      color : Rgba_Record;
   begin
      Put_Line ("Palette Color Changed");
      color := widget_palette.GetForegroundColor(palette1);
      widget_editarea.SetForegroundColor(editarea1, color);
      color := widget_palette.GetBackgroundColor(palette1);
      widget_editarea.SetBackgroundColor(editarea1, color);
      
   end palette_color_changed_cb;

   procedure palette_color_dialog_cb
      (Widget  : access palette_record'Class; userdat : Gint)
   is
      myColor  : Rgba_Record;
      col      : Gdk_RGBA;
   begin
      -----------------------------------------------------------
      -- Color Dialog
      Gtk_New(colorDlg,"--");
      Set_Has_Palette (Get_Color_Selection (colorDlg), True);
      Set_Has_Opacity_Control (Get_Color_Selection (colorDlg), True);
      myColor := widget_palette.GetCurrentCellColor(palette1);
      col.Red := Gdouble(myColor.Red) / 255.0;
      col.Green := Gdouble(myColor.Green) / 255.0;
      col.Blue := Gdouble(myColor.Blue) / 255.0;
      col.Alpha := Gdouble(myColor.Alpha) / 255.0;
      Set_Current_Rgba(Get_Color_Selection (colorDlg), col);

      --Set_Change_Palette_With_Screen_Hook (On_Color_Dialog_Palette_Changed'Access);
      Destroy_Color_Dialog_Cb.Connect(colorDlg, "destroy",
                           Destroy_Color_Dialog_Cb.To_Marshaller (Destroy_Color_Dialog'Access),
                           colorDlg'Access);
      Color_Dialog_Sel_Cb.Object_Connect(Gtk_Button
                           (Glib.Properties.Get_Property (colorDlg, Ok_Button_Property)),
                           "clicked",
                           Color_Dialog_Sel_Cb.To_Marshaller (Color_Dialog_Ok'Access),
                           Slot_Object => colorDlg);
      Color_Dialog_Cancel_Cb.Object_Connect(Gtk_Button
                           (Glib.Properties.Get_Property (colorDlg, Cancel_Button_Property)),
                           "clicked",
                           Color_Dialog_Cancel_Cb.To_Marshaller (Color_Dialog_Cancel'Access),
                           Slot_Object => colorDlg);

      Show_All(colorDlg);
      
   end palette_color_dialog_cb;

   procedure spritesbar_changed
      (Widget  : access spritesbar_record'Class; userdat : Gint)
   is
      id : Gint;
   begin
      Put_Line ("SpritesBar Changed");
      id := GetSelectSpriteIndex(spritesbar1);
      SetCurrentSprite(editarea1,tblSprites(IndexSpriteArray(id)));
      fullPathName := tblFileNames(IndexSpriteArray(id));
      editarea1.Queue_Draw;

   end spritesbar_changed;

   procedure Destroy_Color_Dialog
     (Win : access Gtk_Color_Selection_Dialog_Record'Class;
      Ptr : Gtk_Color_Dialog_Access)
   is
      pragma Warnings (Off, Win);
   begin
      Ptr.all := null;
   end Destroy_Color_Dialog;

   --  procedure On_Color_Dialog_Palette_Changed
   --    (Screen : System.Address;
   --     Colors : Gdk.Color.Gdk_Color_Unconstrained_Array;
   --     N_Colors : Gint)
   --  is
   --     pragma Unreferenced (Screen);
   --     Palette : constant Gdk_Color_Array := To_Array (Colors, N_Colors);
   --     Str : constant String := Palette_To_String (Palette);
   --  begin
   --     Put_Line ("Palette has changed, and became " & Str);
   --     Glib.Properties.Set_Property
   --        (Gtk.Settings.Get_Default, Gtk_Color_Palette_Property, Str);
   --  end On_Color_Dialog_Palette_Changed;

   procedure Color_Dialog_Ok
     (Dialog : access Gtk_Color_Selection_Dialog_Record'Class)
   is
      myColor  : Rgba_Record;
      Color : Gdk_RGBA;
   begin
      Get_Current_Rgba (Get_Color_Selection (Dialog), Color);

      myColor.Red   := Guchar(Color.Red * 255.0);
      myColor.Green := Guchar(Color.Green * 255.0);
      myColor.Blue  := Guchar(Color.Blue * 255.0);
      myColor.Alpha := Guchar(Color.Alpha * 255.0);
      widget_palette.SetCurrentCellColor(palette1,myColor);

      --  Put_Line ("Selected color is: ");
      --  Put ("Red=" & Color.Red'Img);
      --  Put (" Green=" & Color.Green'Img);
      --  Put (" Blue=" & Color.Blue'Img);
      --  Put_Line (" Alpha=" & Color.Alpha'Img);
      Destroy(Dialog);
   end Color_Dialog_Ok;

   procedure Color_Dialog_Cancel
     (Dialog : access Gtk_Color_Selection_Dialog_Record'Class)
   is
      Color : Gdk_RGBA;
   begin
      Destroy(Dialog);
   end Color_Dialog_Cancel;

end Window1_Callbacks;

