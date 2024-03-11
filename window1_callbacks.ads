------------------------------------------------------------------------------

-----------------------------------------------------------------------------
with System;
with Glib;              use Glib;
with Glib.Properties;
with Gtkada.Builder;    use Gtkada.Builder;
with Gtk.Tool_Button;   use Gtk.Tool_Button;
with Gtk.Image;         use Gtk.Image;
with Gtk.Handlers;

with Gdk.Color;                   use Gdk.Color;
with Gdk.RGBA;                    use Gdk.RGBA;
with Gtk.Color_Selection;         use Gtk.Color_Selection;
with Gtk.Color_Selection_Dialog;  use Gtk.Color_Selection_Dialog;
with Gtk.Widget;                  use Gtk.Widget;
with Gtk.Button;                  use Gtk.Button;
with Gtk.Enums;                   use Gtk.Enums;

-- Application specific units
with widget_editarea;   use widget_editarea;
with widget_palette;   use widget_palette;
with widget_spritesbar;   use widget_spritesbar;

package Window1_Callbacks  is

    package EditArea_Cb is new Gtk.Handlers.User_Callback(editarea_record,Gint);
    package Palette_Cb is new Gtk.Handlers.User_Callback(palette_record,Gint);
    package SpritesBar_Cb is new Gtk.Handlers.User_Callback(spritesbar_record,Gint);


    type Gtk_Color_Dialog_Access is access all Gtk_Color_Selection_Dialog;
    package Destroy_Color_Dialog_Cb is new Gtk.Handlers.User_Callback
        (Gtk_Color_Selection_Dialog_Record, Gtk_Color_Dialog_Access);

    package Color_Dialog_Sel_Cb is new Gtk.Handlers.Callback
        (Gtk_Color_Selection_Dialog_Record);

    package Color_Dialog_Cancel_Cb is new Gtk.Handlers.Callback
        (Gtk_Color_Selection_Dialog_Record);

    procedure Destroy_Color_Dialog
     (Win : access Gtk_Color_Selection_Dialog_Record'Class;
      Ptr : Gtk_Color_Dialog_Access);

    --  procedure On_Color_Dialog_Palette_Changed
    --      (Screen : System.Address;
    --      Colors : Gdk.Color.Gdk_Color_Unconstrained_Array;
    --      N_Colors : Gint);
    --  pragma Convention (C, On_Color_Dialog_Palette_Changed);

    procedure Color_Dialog_Ok
        (Dialog : access Gtk_Color_Selection_Dialog_Record'Class);
    procedure Color_Dialog_Cancel
        (Dialog : access Gtk_Color_Selection_Dialog_Record'Class);


    procedure on_window1_destroy  (Builder : access Gtkada_Builder_Record'Class);

    procedure on_select_mode (Builder : access Gtkada_Builder_Record'Class);

    procedure on_pencil_mode (Builder : access Gtkada_Builder_Record'Class);

    procedure on_rectangle_mode (Builder : access Gtkada_Builder_Record'Class);

    procedure on_ellipse_mode (Builder : access Gtkada_Builder_Record'Class);

    procedure on_flood_fill_mode (Builder : access Gtkada_Builder_Record'Class);

    procedure on_menu_quit (Builder : access Gtkada_Builder_Record'Class);

    procedure on_menu_new (Builder : access Gtkada_Builder_Record'Class);

    procedure on_menu_open (Builder : access Gtkada_Builder_Record'Class);

    procedure on_menu_save (Builder : access Gtkada_Builder_Record'Class);

    procedure on_menu_save_as (Builder : access Gtkada_Builder_Record'Class);

    procedure on_menu_undo (Builder : access Gtkada_Builder_Record'Class);

    procedure on_menu_cut (Builder : access Gtkada_Builder_Record'Class);

    procedure on_menu_copy (Builder : access Gtkada_Builder_Record'Class);

    procedure on_menu_paste (Builder : access Gtkada_Builder_Record'Class);

    procedure on_menu_about (Builder : access Gtkada_Builder_Record'Class);

    procedure editarea_pick_color (Widget : access editarea_record'Class; userdat : Gint);

    procedure editarea_changed(Widget : access editarea_record'Class; userdat : Gint);

    procedure spritesbar_changed(Widget : access spritesbar_record'Class; userdat : Gint);

    procedure palette_color_changed_cb(Widget : access palette_record'Class; userdat : Gint);

    procedure palette_color_dialog_cb(Widget : access palette_record'Class; userdat : Gint);

   procedure on_menu_flip_horizontaly  (Builder : access Gtkada_Builder_Record'Class);

   procedure on_menu_flip_verticaly  (Builder : access Gtkada_Builder_Record'Class);

   procedure on_menu_swing_left  (Builder : access Gtkada_Builder_Record'Class);

   procedure on_menu_swing_right  (Builder : access Gtkada_Builder_Record'Class);

end Window1_Callbacks;
