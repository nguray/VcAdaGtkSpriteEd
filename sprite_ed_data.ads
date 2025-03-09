
with Gtk.Tool_Button;       use Gtk.Tool_Button;
with Gtk.Image;             use Gtk.Image;
with Gtk.Widget;            use Gtk.Widget;
with Gtk.Dialog;            use Gtk.Dialog;
with Gtk.Window;            use Gtk.Window;
with Gdk.Rectangle;         use Gdk.Rectangle;
with Gdk.Pixbuf;            use Gdk.Pixbuf;
with Gtk.Color_Selection_Dialog;  use Gtk.Color_Selection_Dialog;

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with widget_editarea;       use widget_editarea;
with widget_palette;        use widget_palette;
with widget_spritesbar;     use widget_spritesbar;
with p_select;              use p_select;
with p_pencil_mode;         use p_pencil_mode;

package sprite_ed_data is

    type IndexSpriteArray is range 0..7;
    type SpriteArray is array (IndexSpriteArray) of Gdk_Pixbuf;

    currToolBtn     : Gtk_Tool_Button;
    selectImage     : Gtk_Image;
    pencilImage     : Gtk_Image;
    rectangleImage  : Gtk_Image;
    ellipseImage    : Gtk_Image;
    floodFillImage  : Gtk_Image;
    playImage       : Gtk_Image;
    aboutDlg        : Gtk_Dialog;
    mainWin         : Gtk_Window;

    curSprite       : Gdk_Pixbuf;
    bakSprite       : Gdk_Pixbuf := Null_Pixbuf;
    copySprite      : Gdk_Pixbuf := Null_Pixbuf;
    fullPathName    : Unbounded_String := To_Unbounded_String("");
    tblSprites      : array (IndexSpriteArray) of Gdk_Pixbuf := (others=>null);
    tblFileNames    : array (IndexSpriteArray) of Unbounded_String := (others=>To_Unbounded_String(""));

    editarea1       : editarea;
    palette1        : palette;
    spritesbar1     : spritesbar;

    colorDlg        : aliased Gtk_Color_Selection_Dialog;
    selRect         : selectrect;
    cpyrect         : selectrect;

    button_press_cb : Cb_Gtk_Widget_Gdk_Event_Button_Boolean := p_pencil_mode.btn_press_evt_cb'Access;
    motion_notify_evt_cb : Cb_Gtk_Widget_Gdk_Event_Motion_Boolean := p_pencil_mode.motion_notify_evt_cb'Access;

end sprite_ed_data;