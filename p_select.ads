with GLib;              use GLib;

-- Ada predefined units
with Ada.Text_IO;    use Ada.Text_IO;

package P_Select is

    type selectrect is tagged record
        left    : Gint := 0;
        top     : Gint := 0;
        right   : Gint := 0;
        bottom  : Gint := 0;
        mode    : Gint := 0;
        sel_corner : Gint := -1;
        mouseStartX : Gdouble := 0.0;
        mouseStartY : Gdouble := 0.0;
        bak_left    : Gint;
        bak_top     : Gint;
        bak_right   : Gint;
        bak_bottom  : Gint;

    end record;

    procedure SetRect(rect : in out selectrect; l :Gint; t :Gint; r :Gint; b :Gint);
    procedure BackupPosition(rect : in out selectrect);
    procedure RestorePosition(rect : in out selectrect);
    procedure Normalize(rect : in out selectrect);
    procedure GetCorner(rect : in out selectrect; n : in Gint; x : out Gint; y : out Gint);
    procedure SetCorner(rect : in out selectrect; n : in Gint; x : in Gint; y : in Gint);
    procedure Empty(rect : in out selectrect);
    function  IsEmpty(rect : in selectrect) return Boolean;
    function  Width(rect : in selectrect) return Gint;
    function  Height(rect : in selectrect) return Gint;
    procedure Offset(rect : in out selectrect; dx : in Gint; dy : in Gint);
    procedure Init(rect : in out selectrect);


end P_Select;