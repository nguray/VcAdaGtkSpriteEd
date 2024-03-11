with GLib;              use GLib;


package body P_Select is

procedure SetRect(rect : in out selectrect; l :Gint; t :Gint; r :Gint; b :Gint)
is
begin
    --
    rect.left   := l;
    rect.top    := t;
    rect.right  := r;
    rect.bottom := b;

end SetRect;

procedure BackupPosition(rect : in out selectrect) 
is
begin
    --
    rect.bak_left := rect.left;
    rect.bak_top := rect.top;
    rect.bak_right := rect.right;
    rect.bak_bottom := rect.bottom;

end BackupPosition;

procedure RestorePosition(rect : in out selectrect) 
is
begin
    --
    rect.left := rect.bak_left;
    rect.top := rect.bak_top;
    rect.right := rect.bak_right;
    rect.bottom := rect.bak_bottom;

end RestorePosition;

procedure Normalize(rect : in out selectrect)
is
    dum : Gint;
begin
    --
    if rect.left>rect.right then
        dum := rect.left;
        rect.left := rect.right;
        rect.right := dum;
    end if;
    if rect.top>rect.bottom then
        dum := rect.top;
        rect.top := rect.bottom;
        rect.bottom := dum; 
    end if;

end Normalize;

procedure GetCorner(rect : in out selectrect; n : in Gint; x : out Gint; y : out Gint ) 
is
begin

    case n is
    when 0 =>
        x := rect.left;
        y := rect.top;
    when 1 =>
        x := rect.right;
        y := rect.top;
    when 2 =>
        x := rect.right;
        y := rect.bottom;
    when 3 =>
        x := rect.left;
        y := rect.bottom;
    when others =>
        null;
    end case;

end GetCorner;

procedure SetCorner(rect : in out selectrect; n : in Gint; x : in Gint; y : in Gint) 
is
begin

    case n is
    when 0 =>
        rect.left := x;
        rect.top := y;
    when 1 =>
        rect.right := x;
        rect.top := y;
    when 2 =>
        rect.right := x;
        rect.bottom := y;
    when 3 =>
        rect.left := x;
        rect.bottom := y;
    when others =>
        null;
    end case;

end SetCorner;

procedure Empty(rect : in out selectrect)
is
begin
    rect.left   := 0;
    rect.top    := 0;
    rect.right  := 0;
    rect.bottom := 0;

end Empty;

function IsEmpty(rect : in selectrect) return Boolean
is
begin
    return rect.left=rect.right and rect.top=rect.bottom;
end IsEmpty;

function Width(rect : in selectrect) return Gint
is
begin
    return rect.right - rect.left + 1;
end Width;

function Height(rect : in selectrect) return Gint
is
begin
    return rect.bottom - rect.top + 1;
end Height;

procedure Offset(rect : in out selectrect; dx : in Gint; dy : in Gint) 
is
begin
    rect.left := rect.left + dx;
    rect.right := rect.right + dx;
    rect.top := rect.top + dy;
    rect.bottom := rect.bottom + dy;

end Offset;

procedure Init(rect : in out selectrect) 
is
begin
    rect.left      := 0;
    rect.top       := 0;
    rect.right     := 0;
    rect.bottom    := 0;
    rect.mode      := 0;
    rect.sel_corner:= -1;
    rect.mode := 0;
    rect.mouseStartX := 0.0;
    rect.mouseStartY := 0.0;

end Init;

end P_Select;

