with Glib;            use Glib;
with Interfaces.C;

package my_rgba is

    type Rgba_Record is record
        Red, Green, Blue, Alpha : Glib.Guchar;
    end record;
    pragma Convention (C, Rgba_Record);

    type Unchecked_Rgba_Buffer is array (Glib.Guint) of Rgba_Record;
    pragma Convention (C, Unchecked_Rgba_Buffer);
    type Rgba_Buffer_Access is access all Unchecked_Rgba_Buffer;
    pragma Convention (C, Rgba_Buffer_Access);

end my_rgba; 