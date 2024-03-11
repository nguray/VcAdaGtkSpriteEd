pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__gtk_sprite_ed.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__gtk_sprite_ed.adb");
pragma Suppress (Overflow_Check);
with Ada.Exceptions;

package body ada_main is

   E076 : Short_Integer; pragma Import (Ada, E076, "system__os_lib_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__exceptions_E");
   E011 : Short_Integer; pragma Import (Ada, E011, "system__soft_links_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__exception_table_E");
   E046 : Short_Integer; pragma Import (Ada, E046, "ada__containers_E");
   E072 : Short_Integer; pragma Import (Ada, E072, "ada__io_exceptions_E");
   E030 : Short_Integer; pragma Import (Ada, E030, "ada__numerics_E");
   E058 : Short_Integer; pragma Import (Ada, E058, "ada__strings_E");
   E060 : Short_Integer; pragma Import (Ada, E060, "ada__strings__maps_E");
   E063 : Short_Integer; pragma Import (Ada, E063, "ada__strings__maps__constants_E");
   E083 : Short_Integer; pragma Import (Ada, E083, "interfaces__c_E");
   E024 : Short_Integer; pragma Import (Ada, E024, "system__exceptions_E");
   E087 : Short_Integer; pragma Import (Ada, E087, "system__object_reader_E");
   E053 : Short_Integer; pragma Import (Ada, E053, "system__dwarf_lines_E");
   E019 : Short_Integer; pragma Import (Ada, E019, "system__soft_links__initialize_E");
   E045 : Short_Integer; pragma Import (Ada, E045, "system__traceback__symbolic_E");
   E029 : Short_Integer; pragma Import (Ada, E029, "system__img_int_E");
   E067 : Short_Integer; pragma Import (Ada, E067, "system__img_uns_E");
   E399 : Short_Integer; pragma Import (Ada, E399, "ada__assertions_E");
   E104 : Short_Integer; pragma Import (Ada, E104, "ada__strings__utf_encoding_E");
   E112 : Short_Integer; pragma Import (Ada, E112, "ada__tags_E");
   E102 : Short_Integer; pragma Import (Ada, E102, "ada__strings__text_buffers_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "gnat_E");
   E140 : Short_Integer; pragma Import (Ada, E140, "interfaces__c__strings_E");
   E120 : Short_Integer; pragma Import (Ada, E120, "ada__streams_E");
   E132 : Short_Integer; pragma Import (Ada, E132, "system__file_control_block_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "system__finalization_root_E");
   E129 : Short_Integer; pragma Import (Ada, E129, "ada__finalization_E");
   E128 : Short_Integer; pragma Import (Ada, E128, "system__file_io_E");
   E144 : Short_Integer; pragma Import (Ada, E144, "system__storage_pools_E");
   E142 : Short_Integer; pragma Import (Ada, E142, "system__finalization_masters_E");
   E166 : Short_Integer; pragma Import (Ada, E166, "system__storage_pools__subpools_E");
   E413 : Short_Integer; pragma Import (Ada, E413, "ada__strings__unbounded_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "ada__text_io_E");
   E146 : Short_Integer; pragma Import (Ada, E146, "system__pool_global_E");
   E135 : Short_Integer; pragma Import (Ada, E135, "glib_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "gtkada__types_E");
   E228 : Short_Integer; pragma Import (Ada, E228, "gdk__frame_timings_E");
   E182 : Short_Integer; pragma Import (Ada, E182, "glib__glist_E");
   E212 : Short_Integer; pragma Import (Ada, E212, "gdk__visual_E");
   E184 : Short_Integer; pragma Import (Ada, E184, "glib__gslist_E");
   E176 : Short_Integer; pragma Import (Ada, E176, "gtkada__c_E");
   E162 : Short_Integer; pragma Import (Ada, E162, "glib__object_E");
   E164 : Short_Integer; pragma Import (Ada, E164, "glib__type_conversion_hooks_E");
   E178 : Short_Integer; pragma Import (Ada, E178, "glib__types_E");
   E180 : Short_Integer; pragma Import (Ada, E180, "glib__values_E");
   E170 : Short_Integer; pragma Import (Ada, E170, "gtkada__bindings_E");
   E193 : Short_Integer; pragma Import (Ada, E193, "cairo_E");
   E195 : Short_Integer; pragma Import (Ada, E195, "cairo__region_E");
   E207 : Short_Integer; pragma Import (Ada, E207, "gdk__rectangle_E");
   E160 : Short_Integer; pragma Import (Ada, E160, "glib__generic_properties_E");
   E158 : Short_Integer; pragma Import (Ada, E158, "gdk__color_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "gdk__rgba_E");
   E337 : Short_Integer; pragma Import (Ada, E337, "glib__key_file_E");
   E205 : Short_Integer; pragma Import (Ada, E205, "glib__properties_E");
   E203 : Short_Integer; pragma Import (Ada, E203, "gdk__device_tool_E");
   E291 : Short_Integer; pragma Import (Ada, E291, "gdk__drawing_context_E");
   E201 : Short_Integer; pragma Import (Ada, E201, "gdk__event_E");
   E430 : Short_Integer; pragma Import (Ada, E430, "glib__properties__creation_E");
   E236 : Short_Integer; pragma Import (Ada, E236, "glib__string_E");
   E232 : Short_Integer; pragma Import (Ada, E232, "glib__variant_E");
   E299 : Short_Integer; pragma Import (Ada, E299, "glib__g_icon_E");
   E375 : Short_Integer; pragma Import (Ada, E375, "gtk__actionable_E");
   E240 : Short_Integer; pragma Import (Ada, E240, "gtk__builder_E");
   E279 : Short_Integer; pragma Import (Ada, E279, "gtk__buildable_E");
   E311 : Short_Integer; pragma Import (Ada, E311, "gtk__cell_area_context_E");
   E327 : Short_Integer; pragma Import (Ada, E327, "gtk__css_section_E");
   E220 : Short_Integer; pragma Import (Ada, E220, "gtk__enums_E");
   E459 : Short_Integer; pragma Import (Ada, E459, "gtk__file_filter_E");
   E285 : Short_Integer; pragma Import (Ada, E285, "gtk__orientable_E");
   E339 : Short_Integer; pragma Import (Ada, E339, "gtk__paper_size_E");
   E335 : Short_Integer; pragma Import (Ada, E335, "gtk__page_setup_E");
   E345 : Short_Integer; pragma Import (Ada, E345, "gtk__print_settings_E");
   E466 : Short_Integer; pragma Import (Ada, E466, "gtk__stock_E");
   E248 : Short_Integer; pragma Import (Ada, E248, "gtk__target_entry_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "gtk__target_list_E");
   E365 : Short_Integer; pragma Import (Ada, E365, "gtk__text_mark_E");
   E425 : Short_Integer; pragma Import (Ada, E425, "p_select_E");
   E253 : Short_Integer; pragma Import (Ada, E253, "pango__enums_E");
   E273 : Short_Integer; pragma Import (Ada, E273, "pango__attributes_E");
   E257 : Short_Integer; pragma Import (Ada, E257, "pango__font_metrics_E");
   E259 : Short_Integer; pragma Import (Ada, E259, "pango__language_E");
   E255 : Short_Integer; pragma Import (Ada, E255, "pango__font_E");
   E351 : Short_Integer; pragma Import (Ada, E351, "gtk__text_attributes_E");
   E353 : Short_Integer; pragma Import (Ada, E353, "gtk__text_tag_E");
   E263 : Short_Integer; pragma Import (Ada, E263, "pango__font_face_E");
   E261 : Short_Integer; pragma Import (Ada, E261, "pango__font_family_E");
   E265 : Short_Integer; pragma Import (Ada, E265, "pango__fontset_E");
   E267 : Short_Integer; pragma Import (Ada, E267, "pango__matrix_E");
   E251 : Short_Integer; pragma Import (Ada, E251, "pango__context_E");
   E269 : Short_Integer; pragma Import (Ada, E269, "pango__font_map_E");
   E275 : Short_Integer; pragma Import (Ada, E275, "pango__tabs_E");
   E271 : Short_Integer; pragma Import (Ada, E271, "pango__layout_E");
   E341 : Short_Integer; pragma Import (Ada, E341, "gtk__print_context_E");
   E226 : Short_Integer; pragma Import (Ada, E226, "gdk__frame_clock_E");
   E369 : Short_Integer; pragma Import (Ada, E369, "gdk__monitor_E");
   E188 : Short_Integer; pragma Import (Ada, E188, "gdk__display_E");
   E293 : Short_Integer; pragma Import (Ada, E293, "gdk__glcontext_E");
   E186 : Short_Integer; pragma Import (Ada, E186, "gdk__pixbuf_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "gdk__screen_E");
   E199 : Short_Integer; pragma Import (Ada, E199, "gdk__device_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "gdk__drag_contexts_E");
   E289 : Short_Integer; pragma Import (Ada, E289, "gdk__window_E");
   E230 : Short_Integer; pragma Import (Ada, E230, "glib__action_group_E");
   E238 : Short_Integer; pragma Import (Ada, E238, "gtk__accel_group_E");
   E283 : Short_Integer; pragma Import (Ada, E283, "gtk__adjustment_E");
   E301 : Short_Integer; pragma Import (Ada, E301, "gtk__cell_editable_E");
   E303 : Short_Integer; pragma Import (Ada, E303, "gtk__editable_E");
   E305 : Short_Integer; pragma Import (Ada, E305, "gtk__entry_buffer_E");
   E323 : Short_Integer; pragma Import (Ada, E323, "gtk__icon_source_E");
   E343 : Short_Integer; pragma Import (Ada, E343, "gtk__print_operation_preview_E");
   E242 : Short_Integer; pragma Import (Ada, E242, "gtk__selection_data_E");
   E361 : Short_Integer; pragma Import (Ada, E361, "gtk__clipboard_E");
   E244 : Short_Integer; pragma Import (Ada, E244, "gtk__style_E");
   E357 : Short_Integer; pragma Import (Ada, E357, "gtk__scrollable_E");
   E349 : Short_Integer; pragma Import (Ada, E349, "gtk__text_iter_E");
   E367 : Short_Integer; pragma Import (Ada, E367, "gtk__text_tag_table_E");
   E317 : Short_Integer; pragma Import (Ada, E317, "gtk__tree_model_E");
   E224 : Short_Integer; pragma Import (Ada, E224, "gtk__widget_E");
   E315 : Short_Integer; pragma Import (Ada, E315, "gtk__cell_renderer_E");
   E313 : Short_Integer; pragma Import (Ada, E313, "gtk__cell_layout_E");
   E309 : Short_Integer; pragma Import (Ada, E309, "gtk__cell_area_E");
   E281 : Short_Integer; pragma Import (Ada, E281, "gtk__container_E");
   E295 : Short_Integer; pragma Import (Ada, E295, "gtk__bin_E");
   E277 : Short_Integer; pragma Import (Ada, E277, "gtk__box_E");
   E307 : Short_Integer; pragma Import (Ada, E307, "gtk__entry_completion_E");
   E329 : Short_Integer; pragma Import (Ada, E329, "gtk__misc_E");
   E331 : Short_Integer; pragma Import (Ada, E331, "gtk__notebook_E");
   E347 : Short_Integer; pragma Import (Ada, E347, "gtk__status_bar_E");
   E222 : Short_Integer; pragma Import (Ada, E222, "gtk__style_provider_E");
   E218 : Short_Integer; pragma Import (Ada, E218, "gtk__settings_E");
   E325 : Short_Integer; pragma Import (Ada, E325, "gtk__style_context_E");
   E321 : Short_Integer; pragma Import (Ada, E321, "gtk__icon_set_E");
   E319 : Short_Integer; pragma Import (Ada, E319, "gtk__image_E");
   E297 : Short_Integer; pragma Import (Ada, E297, "gtk__gentry_E");
   E363 : Short_Integer; pragma Import (Ada, E363, "gtk__text_child_anchor_E");
   E359 : Short_Integer; pragma Import (Ada, E359, "gtk__text_buffer_E");
   E355 : Short_Integer; pragma Import (Ada, E355, "gtk__text_view_E");
   E287 : Short_Integer; pragma Import (Ada, E287, "gtk__window_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "gtk__dialog_E");
   E333 : Short_Integer; pragma Import (Ada, E333, "gtk__print_operation_E");
   E191 : Short_Integer; pragma Import (Ada, E191, "gtk__arguments_E");
   E434 : Short_Integer; pragma Import (Ada, E434, "gdk__cairo_E");
   E373 : Short_Integer; pragma Import (Ada, E373, "gtk__action_E");
   E377 : Short_Integer; pragma Import (Ada, E377, "gtk__activatable_E");
   E371 : Short_Integer; pragma Import (Ada, E371, "gtk__button_E");
   E379 : Short_Integer; pragma Import (Ada, E379, "gtk__color_selection_E");
   E381 : Short_Integer; pragma Import (Ada, E381, "gtk__color_selection_dialog_E");
   E446 : Short_Integer; pragma Import (Ada, E446, "gtk__drawing_area_E");
   E457 : Short_Integer; pragma Import (Ada, E457, "gtk__file_chooser_E");
   E461 : Short_Integer; pragma Import (Ada, E461, "gtk__file_chooser_dialog_E");
   E383 : Short_Integer; pragma Import (Ada, E383, "gtk__main_E");
   E401 : Short_Integer; pragma Import (Ada, E401, "gtk__marshallers_E");
   E389 : Short_Integer; pragma Import (Ada, E389, "gtk__menu_item_E");
   E391 : Short_Integer; pragma Import (Ada, E391, "gtk__size_group_E");
   E387 : Short_Integer; pragma Import (Ada, E387, "gtk__tool_item_E");
   E385 : Short_Integer; pragma Import (Ada, E385, "gtk__tool_button_E");
   E403 : Short_Integer; pragma Import (Ada, E403, "gtk__tree_view_column_E");
   E404 : Short_Integer; pragma Import (Ada, E404, "gtkada__handlers_E");
   E393 : Short_Integer; pragma Import (Ada, E393, "gtkada__builder_E");
   E463 : Short_Integer; pragma Import (Ada, E463, "gtkada__file_selection_E");
   E432 : Short_Integer; pragma Import (Ada, E432, "widget_editarea_E");
   E436 : Short_Integer; pragma Import (Ada, E436, "p_ellipse_mode_E");
   E438 : Short_Integer; pragma Import (Ada, E438, "p_fill_mode_E");
   E428 : Short_Integer; pragma Import (Ada, E428, "p_pencil_mode_E");
   E440 : Short_Integer; pragma Import (Ada, E440, "p_rectangle_mode_E");
   E442 : Short_Integer; pragma Import (Ada, E442, "p_select_mode_E");
   E449 : Short_Integer; pragma Import (Ada, E449, "widget_palette_E");
   E453 : Short_Integer; pragma Import (Ada, E453, "widget_spritesbar_E");
   E426 : Short_Integer; pragma Import (Ada, E426, "sprite_ed_data_E");
   E455 : Short_Integer; pragma Import (Ada, E455, "window1_callbacks_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E455 := E455 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "window1_callbacks__finalize_spec");
      begin
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "widget_spritesbar__finalize_body");
      begin
         E453 := E453 - 1;
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "widget_palette__finalize_body");
      begin
         E449 := E449 - 1;
         F3;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "widget_editarea__finalize_body");
      begin
         E432 := E432 - 1;
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "p_select_mode__finalize_body");
      begin
         E442 := E442 - 1;
         F5;
      end;
      declare
         procedure F6;
         pragma Import (Ada, F6, "p_rectangle_mode__finalize_body");
      begin
         E440 := E440 - 1;
         F6;
      end;
      declare
         procedure F7;
         pragma Import (Ada, F7, "p_pencil_mode__finalize_body");
      begin
         E428 := E428 - 1;
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "p_fill_mode__finalize_body");
      begin
         E438 := E438 - 1;
         F8;
      end;
      declare
         procedure F9;
         pragma Import (Ada, F9, "p_ellipse_mode__finalize_body");
      begin
         E436 := E436 - 1;
         F9;
      end;
      declare
         procedure F10;
         pragma Import (Ada, F10, "widget_spritesbar__finalize_spec");
      begin
         F10;
      end;
      declare
         procedure F11;
         pragma Import (Ada, F11, "widget_palette__finalize_spec");
      begin
         F11;
      end;
      declare
         procedure F12;
         pragma Import (Ada, F12, "widget_editarea__finalize_spec");
      begin
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "gtkada__file_selection__finalize_body");
      begin
         E463 := E463 - 1;
         F13;
      end;
      declare
         procedure F14;
         pragma Import (Ada, F14, "gtkada__builder__finalize_body");
      begin
         E393 := E393 - 1;
         F14;
      end;
      declare
         procedure F15;
         pragma Import (Ada, F15, "gtkada__builder__finalize_spec");
      begin
         F15;
      end;
      declare
         procedure F16;
         pragma Import (Ada, F16, "gtkada__handlers__finalize_spec");
      begin
         E404 := E404 - 1;
         F16;
      end;
      E403 := E403 - 1;
      declare
         procedure F17;
         pragma Import (Ada, F17, "gtk__tree_view_column__finalize_spec");
      begin
         F17;
      end;
      E385 := E385 - 1;
      declare
         procedure F18;
         pragma Import (Ada, F18, "gtk__tool_button__finalize_spec");
      begin
         F18;
      end;
      E387 := E387 - 1;
      declare
         procedure F19;
         pragma Import (Ada, F19, "gtk__tool_item__finalize_spec");
      begin
         F19;
      end;
      E391 := E391 - 1;
      declare
         procedure F20;
         pragma Import (Ada, F20, "gtk__size_group__finalize_spec");
      begin
         F20;
      end;
      E389 := E389 - 1;
      declare
         procedure F21;
         pragma Import (Ada, F21, "gtk__menu_item__finalize_spec");
      begin
         F21;
      end;
      E461 := E461 - 1;
      declare
         procedure F22;
         pragma Import (Ada, F22, "gtk__file_chooser_dialog__finalize_spec");
      begin
         F22;
      end;
      E446 := E446 - 1;
      declare
         procedure F23;
         pragma Import (Ada, F23, "gtk__drawing_area__finalize_spec");
      begin
         F23;
      end;
      E381 := E381 - 1;
      declare
         procedure F24;
         pragma Import (Ada, F24, "gtk__color_selection_dialog__finalize_spec");
      begin
         F24;
      end;
      E379 := E379 - 1;
      declare
         procedure F25;
         pragma Import (Ada, F25, "gtk__color_selection__finalize_spec");
      begin
         F25;
      end;
      E371 := E371 - 1;
      declare
         procedure F26;
         pragma Import (Ada, F26, "gtk__button__finalize_spec");
      begin
         F26;
      end;
      E373 := E373 - 1;
      declare
         procedure F27;
         pragma Import (Ada, F27, "gtk__action__finalize_spec");
      begin
         F27;
      end;
      E287 := E287 - 1;
      E224 := E224 - 1;
      E317 := E317 - 1;
      E355 := E355 - 1;
      E367 := E367 - 1;
      E359 := E359 - 1;
      E325 := E325 - 1;
      E244 := E244 - 1;
      E347 := E347 - 1;
      E333 := E333 - 1;
      E331 := E331 - 1;
      E297 := E297 - 1;
      E307 := E307 - 1;
      E305 := E305 - 1;
      E216 := E216 - 1;
      E281 := E281 - 1;
      E361 := E361 - 1;
      E315 := E315 - 1;
      E309 := E309 - 1;
      E283 := E283 - 1;
      E238 := E238 - 1;
      E369 := E369 - 1;
      E226 := E226 - 1;
      E197 := E197 - 1;
      E188 := E188 - 1;
      E199 := E199 - 1;
      declare
         procedure F28;
         pragma Import (Ada, F28, "gtk__print_operation__finalize_spec");
      begin
         F28;
      end;
      declare
         procedure F29;
         pragma Import (Ada, F29, "gtk__dialog__finalize_spec");
      begin
         F29;
      end;
      declare
         procedure F30;
         pragma Import (Ada, F30, "gtk__window__finalize_spec");
      begin
         F30;
      end;
      declare
         procedure F31;
         pragma Import (Ada, F31, "gtk__text_view__finalize_spec");
      begin
         F31;
      end;
      declare
         procedure F32;
         pragma Import (Ada, F32, "gtk__text_buffer__finalize_spec");
      begin
         F32;
      end;
      E363 := E363 - 1;
      declare
         procedure F33;
         pragma Import (Ada, F33, "gtk__text_child_anchor__finalize_spec");
      begin
         F33;
      end;
      declare
         procedure F34;
         pragma Import (Ada, F34, "gtk__gentry__finalize_spec");
      begin
         F34;
      end;
      E319 := E319 - 1;
      declare
         procedure F35;
         pragma Import (Ada, F35, "gtk__image__finalize_spec");
      begin
         F35;
      end;
      E321 := E321 - 1;
      declare
         procedure F36;
         pragma Import (Ada, F36, "gtk__icon_set__finalize_spec");
      begin
         F36;
      end;
      declare
         procedure F37;
         pragma Import (Ada, F37, "gtk__style_context__finalize_spec");
      begin
         F37;
      end;
      E218 := E218 - 1;
      declare
         procedure F38;
         pragma Import (Ada, F38, "gtk__settings__finalize_spec");
      begin
         F38;
      end;
      declare
         procedure F39;
         pragma Import (Ada, F39, "gtk__status_bar__finalize_spec");
      begin
         F39;
      end;
      declare
         procedure F40;
         pragma Import (Ada, F40, "gtk__notebook__finalize_spec");
      begin
         F40;
      end;
      E329 := E329 - 1;
      declare
         procedure F41;
         pragma Import (Ada, F41, "gtk__misc__finalize_spec");
      begin
         F41;
      end;
      declare
         procedure F42;
         pragma Import (Ada, F42, "gtk__entry_completion__finalize_spec");
      begin
         F42;
      end;
      E277 := E277 - 1;
      declare
         procedure F43;
         pragma Import (Ada, F43, "gtk__box__finalize_spec");
      begin
         F43;
      end;
      E295 := E295 - 1;
      declare
         procedure F44;
         pragma Import (Ada, F44, "gtk__bin__finalize_spec");
      begin
         F44;
      end;
      declare
         procedure F45;
         pragma Import (Ada, F45, "gtk__container__finalize_spec");
      begin
         F45;
      end;
      declare
         procedure F46;
         pragma Import (Ada, F46, "gtk__cell_area__finalize_spec");
      begin
         F46;
      end;
      declare
         procedure F47;
         pragma Import (Ada, F47, "gtk__cell_renderer__finalize_spec");
      begin
         F47;
      end;
      declare
         procedure F48;
         pragma Import (Ada, F48, "gtk__widget__finalize_spec");
      begin
         F48;
      end;
      declare
         procedure F49;
         pragma Import (Ada, F49, "gtk__tree_model__finalize_spec");
      begin
         F49;
      end;
      declare
         procedure F50;
         pragma Import (Ada, F50, "gtk__text_tag_table__finalize_spec");
      begin
         F50;
      end;
      declare
         procedure F51;
         pragma Import (Ada, F51, "gtk__style__finalize_spec");
      begin
         F51;
      end;
      declare
         procedure F52;
         pragma Import (Ada, F52, "gtk__clipboard__finalize_spec");
      begin
         F52;
      end;
      E242 := E242 - 1;
      declare
         procedure F53;
         pragma Import (Ada, F53, "gtk__selection_data__finalize_spec");
      begin
         F53;
      end;
      E323 := E323 - 1;
      declare
         procedure F54;
         pragma Import (Ada, F54, "gtk__icon_source__finalize_spec");
      begin
         F54;
      end;
      declare
         procedure F55;
         pragma Import (Ada, F55, "gtk__entry_buffer__finalize_spec");
      begin
         F55;
      end;
      declare
         procedure F56;
         pragma Import (Ada, F56, "gtk__adjustment__finalize_spec");
      begin
         F56;
      end;
      declare
         procedure F57;
         pragma Import (Ada, F57, "gtk__accel_group__finalize_spec");
      begin
         F57;
      end;
      declare
         procedure F58;
         pragma Import (Ada, F58, "gdk__drag_contexts__finalize_spec");
      begin
         F58;
      end;
      declare
         procedure F59;
         pragma Import (Ada, F59, "gdk__device__finalize_spec");
      begin
         F59;
      end;
      E210 := E210 - 1;
      declare
         procedure F60;
         pragma Import (Ada, F60, "gdk__screen__finalize_spec");
      begin
         F60;
      end;
      E186 := E186 - 1;
      declare
         procedure F61;
         pragma Import (Ada, F61, "gdk__pixbuf__finalize_spec");
      begin
         F61;
      end;
      E293 := E293 - 1;
      declare
         procedure F62;
         pragma Import (Ada, F62, "gdk__glcontext__finalize_spec");
      begin
         F62;
      end;
      declare
         procedure F63;
         pragma Import (Ada, F63, "gdk__display__finalize_spec");
      begin
         F63;
      end;
      declare
         procedure F64;
         pragma Import (Ada, F64, "gdk__monitor__finalize_spec");
      begin
         F64;
      end;
      declare
         procedure F65;
         pragma Import (Ada, F65, "gdk__frame_clock__finalize_spec");
      begin
         F65;
      end;
      E341 := E341 - 1;
      declare
         procedure F66;
         pragma Import (Ada, F66, "gtk__print_context__finalize_spec");
      begin
         F66;
      end;
      E271 := E271 - 1;
      declare
         procedure F67;
         pragma Import (Ada, F67, "pango__layout__finalize_spec");
      begin
         F67;
      end;
      E275 := E275 - 1;
      declare
         procedure F68;
         pragma Import (Ada, F68, "pango__tabs__finalize_spec");
      begin
         F68;
      end;
      E269 := E269 - 1;
      declare
         procedure F69;
         pragma Import (Ada, F69, "pango__font_map__finalize_spec");
      begin
         F69;
      end;
      E251 := E251 - 1;
      declare
         procedure F70;
         pragma Import (Ada, F70, "pango__context__finalize_spec");
      begin
         F70;
      end;
      E265 := E265 - 1;
      declare
         procedure F71;
         pragma Import (Ada, F71, "pango__fontset__finalize_spec");
      begin
         F71;
      end;
      E261 := E261 - 1;
      declare
         procedure F72;
         pragma Import (Ada, F72, "pango__font_family__finalize_spec");
      begin
         F72;
      end;
      E263 := E263 - 1;
      declare
         procedure F73;
         pragma Import (Ada, F73, "pango__font_face__finalize_spec");
      begin
         F73;
      end;
      E353 := E353 - 1;
      declare
         procedure F74;
         pragma Import (Ada, F74, "gtk__text_tag__finalize_spec");
      begin
         F74;
      end;
      E255 := E255 - 1;
      declare
         procedure F75;
         pragma Import (Ada, F75, "pango__font__finalize_spec");
      begin
         F75;
      end;
      E259 := E259 - 1;
      declare
         procedure F76;
         pragma Import (Ada, F76, "pango__language__finalize_spec");
      begin
         F76;
      end;
      E257 := E257 - 1;
      declare
         procedure F77;
         pragma Import (Ada, F77, "pango__font_metrics__finalize_spec");
      begin
         F77;
      end;
      E273 := E273 - 1;
      declare
         procedure F78;
         pragma Import (Ada, F78, "pango__attributes__finalize_spec");
      begin
         F78;
      end;
      E425 := E425 - 1;
      declare
         procedure F79;
         pragma Import (Ada, F79, "p_select__finalize_spec");
      begin
         F79;
      end;
      E365 := E365 - 1;
      declare
         procedure F80;
         pragma Import (Ada, F80, "gtk__text_mark__finalize_spec");
      begin
         F80;
      end;
      E246 := E246 - 1;
      declare
         procedure F81;
         pragma Import (Ada, F81, "gtk__target_list__finalize_spec");
      begin
         F81;
      end;
      E345 := E345 - 1;
      declare
         procedure F82;
         pragma Import (Ada, F82, "gtk__print_settings__finalize_spec");
      begin
         F82;
      end;
      E335 := E335 - 1;
      declare
         procedure F83;
         pragma Import (Ada, F83, "gtk__page_setup__finalize_spec");
      begin
         F83;
      end;
      E339 := E339 - 1;
      declare
         procedure F84;
         pragma Import (Ada, F84, "gtk__paper_size__finalize_spec");
      begin
         F84;
      end;
      E459 := E459 - 1;
      declare
         procedure F85;
         pragma Import (Ada, F85, "gtk__file_filter__finalize_spec");
      begin
         F85;
      end;
      E327 := E327 - 1;
      declare
         procedure F86;
         pragma Import (Ada, F86, "gtk__css_section__finalize_spec");
      begin
         F86;
      end;
      E311 := E311 - 1;
      declare
         procedure F87;
         pragma Import (Ada, F87, "gtk__cell_area_context__finalize_spec");
      begin
         F87;
      end;
      E240 := E240 - 1;
      declare
         procedure F88;
         pragma Import (Ada, F88, "gtk__builder__finalize_spec");
      begin
         F88;
      end;
      E232 := E232 - 1;
      declare
         procedure F89;
         pragma Import (Ada, F89, "glib__variant__finalize_spec");
      begin
         F89;
      end;
      E291 := E291 - 1;
      declare
         procedure F90;
         pragma Import (Ada, F90, "gdk__drawing_context__finalize_spec");
      begin
         F90;
      end;
      E203 := E203 - 1;
      declare
         procedure F91;
         pragma Import (Ada, F91, "gdk__device_tool__finalize_spec");
      begin
         F91;
      end;
      E162 := E162 - 1;
      declare
         procedure F92;
         pragma Import (Ada, F92, "glib__object__finalize_spec");
      begin
         F92;
      end;
      E228 := E228 - 1;
      declare
         procedure F93;
         pragma Import (Ada, F93, "gdk__frame_timings__finalize_spec");
      begin
         F93;
      end;
      E135 := E135 - 1;
      declare
         procedure F94;
         pragma Import (Ada, F94, "glib__finalize_spec");
      begin
         F94;
      end;
      E146 := E146 - 1;
      declare
         procedure F95;
         pragma Import (Ada, F95, "system__pool_global__finalize_spec");
      begin
         F95;
      end;
      E118 := E118 - 1;
      declare
         procedure F96;
         pragma Import (Ada, F96, "ada__text_io__finalize_spec");
      begin
         F96;
      end;
      E413 := E413 - 1;
      declare
         procedure F97;
         pragma Import (Ada, F97, "ada__strings__unbounded__finalize_spec");
      begin
         F97;
      end;
      E166 := E166 - 1;
      declare
         procedure F98;
         pragma Import (Ada, F98, "system__storage_pools__subpools__finalize_spec");
      begin
         F98;
      end;
      E142 := E142 - 1;
      declare
         procedure F99;
         pragma Import (Ada, F99, "system__finalization_masters__finalize_spec");
      begin
         F99;
      end;
      declare
         procedure F100;
         pragma Import (Ada, F100, "system__file_io__finalize_body");
      begin
         E128 := E128 - 1;
         F100;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E023 := E023 + 1;
      Ada.Containers'Elab_Spec;
      E046 := E046 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E072 := E072 + 1;
      Ada.Numerics'Elab_Spec;
      E030 := E030 + 1;
      Ada.Strings'Elab_Spec;
      E058 := E058 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E060 := E060 + 1;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E063 := E063 + 1;
      Interfaces.C'Elab_Spec;
      E083 := E083 + 1;
      System.Exceptions'Elab_Spec;
      E024 := E024 + 1;
      System.Object_Reader'Elab_Spec;
      E087 := E087 + 1;
      System.Dwarf_Lines'Elab_Spec;
      System.Os_Lib'Elab_Body;
      E076 := E076 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E019 := E019 + 1;
      E011 := E011 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E045 := E045 + 1;
      System.Img_Int'Elab_Spec;
      E029 := E029 + 1;
      E006 := E006 + 1;
      System.Img_Uns'Elab_Spec;
      E067 := E067 + 1;
      E053 := E053 + 1;
      Ada.Assertions'Elab_Spec;
      E399 := E399 + 1;
      Ada.Strings.Utf_Encoding'Elab_Spec;
      E104 := E104 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E112 := E112 + 1;
      Ada.Strings.Text_Buffers'Elab_Spec;
      E102 := E102 + 1;
      Gnat'Elab_Spec;
      E171 := E171 + 1;
      Interfaces.C.Strings'Elab_Spec;
      E140 := E140 + 1;
      Ada.Streams'Elab_Spec;
      E120 := E120 + 1;
      System.File_Control_Block'Elab_Spec;
      E132 := E132 + 1;
      System.Finalization_Root'Elab_Spec;
      E131 := E131 + 1;
      Ada.Finalization'Elab_Spec;
      E129 := E129 + 1;
      System.File_Io'Elab_Body;
      E128 := E128 + 1;
      System.Storage_Pools'Elab_Spec;
      E144 := E144 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E142 := E142 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      E166 := E166 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E413 := E413 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E118 := E118 + 1;
      System.Pool_Global'Elab_Spec;
      E146 := E146 + 1;
      Glib'Elab_Spec;
      Gtkada.Types'Elab_Spec;
      E138 := E138 + 1;
      E135 := E135 + 1;
      Gdk.Frame_Timings'Elab_Spec;
      Gdk.Frame_Timings'Elab_Body;
      E228 := E228 + 1;
      E182 := E182 + 1;
      Gdk.Visual'Elab_Body;
      E212 := E212 + 1;
      E184 := E184 + 1;
      E176 := E176 + 1;
      Glib.Object'Elab_Spec;
      E164 := E164 + 1;
      Glib.Values'Elab_Body;
      E180 := E180 + 1;
      E170 := E170 + 1;
      Glib.Object'Elab_Body;
      E162 := E162 + 1;
      E178 := E178 + 1;
      E193 := E193 + 1;
      E195 := E195 + 1;
      E207 := E207 + 1;
      Glib.Generic_Properties'Elab_Spec;
      Glib.Generic_Properties'Elab_Body;
      E160 := E160 + 1;
      Gdk.Color'Elab_Spec;
      E158 := E158 + 1;
      E214 := E214 + 1;
      E337 := E337 + 1;
      E205 := E205 + 1;
      Gdk.Device_Tool'Elab_Spec;
      Gdk.Device_Tool'Elab_Body;
      E203 := E203 + 1;
      Gdk.Drawing_Context'Elab_Spec;
      Gdk.Drawing_Context'Elab_Body;
      E291 := E291 + 1;
      E201 := E201 + 1;
      E430 := E430 + 1;
      E236 := E236 + 1;
      Glib.Variant'Elab_Spec;
      Glib.Variant'Elab_Body;
      E232 := E232 + 1;
      E299 := E299 + 1;
      Gtk.Actionable'Elab_Spec;
      E375 := E375 + 1;
      Gtk.Builder'Elab_Spec;
      Gtk.Builder'Elab_Body;
      E240 := E240 + 1;
      E279 := E279 + 1;
      Gtk.Cell_Area_Context'Elab_Spec;
      Gtk.Cell_Area_Context'Elab_Body;
      E311 := E311 + 1;
      Gtk.Css_Section'Elab_Spec;
      Gtk.Css_Section'Elab_Body;
      E327 := E327 + 1;
      E220 := E220 + 1;
      Gtk.File_Filter'Elab_Spec;
      Gtk.File_Filter'Elab_Body;
      E459 := E459 + 1;
      Gtk.Orientable'Elab_Spec;
      E285 := E285 + 1;
      Gtk.Paper_Size'Elab_Spec;
      Gtk.Paper_Size'Elab_Body;
      E339 := E339 + 1;
      Gtk.Page_Setup'Elab_Spec;
      Gtk.Page_Setup'Elab_Body;
      E335 := E335 + 1;
      Gtk.Print_Settings'Elab_Spec;
      Gtk.Print_Settings'Elab_Body;
      E345 := E345 + 1;
      E466 := E466 + 1;
      E248 := E248 + 1;
      Gtk.Target_List'Elab_Spec;
      Gtk.Target_List'Elab_Body;
      E246 := E246 + 1;
      Gtk.Text_Mark'Elab_Spec;
      Gtk.Text_Mark'Elab_Body;
      E365 := E365 + 1;
      P_Select'Elab_Spec;
      P_Select'Elab_Body;
      E425 := E425 + 1;
      E253 := E253 + 1;
      Pango.Attributes'Elab_Spec;
      Pango.Attributes'Elab_Body;
      E273 := E273 + 1;
      Pango.Font_Metrics'Elab_Spec;
      Pango.Font_Metrics'Elab_Body;
      E257 := E257 + 1;
      Pango.Language'Elab_Spec;
      Pango.Language'Elab_Body;
      E259 := E259 + 1;
      Pango.Font'Elab_Spec;
      Pango.Font'Elab_Body;
      E255 := E255 + 1;
      E351 := E351 + 1;
      Gtk.Text_Tag'Elab_Spec;
      Gtk.Text_Tag'Elab_Body;
      E353 := E353 + 1;
      Pango.Font_Face'Elab_Spec;
      Pango.Font_Face'Elab_Body;
      E263 := E263 + 1;
      Pango.Font_Family'Elab_Spec;
      Pango.Font_Family'Elab_Body;
      E261 := E261 + 1;
      Pango.Fontset'Elab_Spec;
      Pango.Fontset'Elab_Body;
      E265 := E265 + 1;
      E267 := E267 + 1;
      Pango.Context'Elab_Spec;
      Pango.Context'Elab_Body;
      E251 := E251 + 1;
      Pango.Font_Map'Elab_Spec;
      Pango.Font_Map'Elab_Body;
      E269 := E269 + 1;
      Pango.Tabs'Elab_Spec;
      Pango.Tabs'Elab_Body;
      E275 := E275 + 1;
      Pango.Layout'Elab_Spec;
      Pango.Layout'Elab_Body;
      E271 := E271 + 1;
      Gtk.Print_Context'Elab_Spec;
      Gtk.Print_Context'Elab_Body;
      E341 := E341 + 1;
      Gdk.Frame_Clock'Elab_Spec;
      Gdk.Monitor'Elab_Spec;
      Gdk.Display'Elab_Spec;
      Gdk.Glcontext'Elab_Spec;
      Gdk.Glcontext'Elab_Body;
      E293 := E293 + 1;
      Gdk.Pixbuf'Elab_Spec;
      E186 := E186 + 1;
      Gdk.Screen'Elab_Spec;
      Gdk.Screen'Elab_Body;
      E210 := E210 + 1;
      Gdk.Device'Elab_Spec;
      Gdk.Drag_Contexts'Elab_Spec;
      Gdk.Window'Elab_Spec;
      E289 := E289 + 1;
      Gtk.Accel_Group'Elab_Spec;
      Gtk.Adjustment'Elab_Spec;
      Gtk.Cell_Editable'Elab_Spec;
      Gtk.Entry_Buffer'Elab_Spec;
      Gtk.Icon_Source'Elab_Spec;
      Gtk.Icon_Source'Elab_Body;
      E323 := E323 + 1;
      Gtk.Selection_Data'Elab_Spec;
      Gtk.Selection_Data'Elab_Body;
      E242 := E242 + 1;
      Gtk.Clipboard'Elab_Spec;
      Gtk.Style'Elab_Spec;
      Gtk.Scrollable'Elab_Spec;
      E357 := E357 + 1;
      E349 := E349 + 1;
      Gtk.Text_Tag_Table'Elab_Spec;
      Gtk.Tree_Model'Elab_Spec;
      Gtk.Widget'Elab_Spec;
      Gtk.Cell_Renderer'Elab_Spec;
      E313 := E313 + 1;
      Gtk.Cell_Area'Elab_Spec;
      Gtk.Container'Elab_Spec;
      Gtk.Bin'Elab_Spec;
      Gtk.Bin'Elab_Body;
      E295 := E295 + 1;
      Gtk.Box'Elab_Spec;
      Gtk.Box'Elab_Body;
      E277 := E277 + 1;
      Gtk.Entry_Completion'Elab_Spec;
      Gtk.Misc'Elab_Spec;
      Gtk.Misc'Elab_Body;
      E329 := E329 + 1;
      Gtk.Notebook'Elab_Spec;
      Gtk.Status_Bar'Elab_Spec;
      E222 := E222 + 1;
      Gtk.Settings'Elab_Spec;
      Gtk.Settings'Elab_Body;
      E218 := E218 + 1;
      Gtk.Style_Context'Elab_Spec;
      Gtk.Icon_Set'Elab_Spec;
      Gtk.Icon_Set'Elab_Body;
      E321 := E321 + 1;
      Gtk.Image'Elab_Spec;
      Gtk.Image'Elab_Body;
      E319 := E319 + 1;
      Gtk.Gentry'Elab_Spec;
      Gtk.Text_Child_Anchor'Elab_Spec;
      Gtk.Text_Child_Anchor'Elab_Body;
      E363 := E363 + 1;
      Gtk.Text_Buffer'Elab_Spec;
      Gtk.Text_View'Elab_Spec;
      Gtk.Window'Elab_Spec;
      Gtk.Dialog'Elab_Spec;
      Gtk.Print_Operation'Elab_Spec;
      E191 := E191 + 1;
      Gdk.Device'Elab_Body;
      E199 := E199 + 1;
      Gdk.Display'Elab_Body;
      E188 := E188 + 1;
      Gdk.Drag_Contexts'Elab_Body;
      E197 := E197 + 1;
      Gdk.Frame_Clock'Elab_Body;
      E226 := E226 + 1;
      Gdk.Monitor'Elab_Body;
      E369 := E369 + 1;
      E230 := E230 + 1;
      Gtk.Accel_Group'Elab_Body;
      E238 := E238 + 1;
      Gtk.Adjustment'Elab_Body;
      E283 := E283 + 1;
      Gtk.Cell_Area'Elab_Body;
      E309 := E309 + 1;
      E301 := E301 + 1;
      Gtk.Cell_Renderer'Elab_Body;
      E315 := E315 + 1;
      Gtk.Clipboard'Elab_Body;
      E361 := E361 + 1;
      Gtk.Container'Elab_Body;
      E281 := E281 + 1;
      Gtk.Dialog'Elab_Body;
      E216 := E216 + 1;
      E303 := E303 + 1;
      Gtk.Entry_Buffer'Elab_Body;
      E305 := E305 + 1;
      Gtk.Entry_Completion'Elab_Body;
      E307 := E307 + 1;
      Gtk.Gentry'Elab_Body;
      E297 := E297 + 1;
      Gtk.Notebook'Elab_Body;
      E331 := E331 + 1;
      Gtk.Print_Operation'Elab_Body;
      E333 := E333 + 1;
      E343 := E343 + 1;
      Gtk.Status_Bar'Elab_Body;
      E347 := E347 + 1;
      Gtk.Style'Elab_Body;
      E244 := E244 + 1;
      Gtk.Style_Context'Elab_Body;
      E325 := E325 + 1;
      Gtk.Text_Buffer'Elab_Body;
      E359 := E359 + 1;
      Gtk.Text_Tag_Table'Elab_Body;
      E367 := E367 + 1;
      Gtk.Text_View'Elab_Body;
      E355 := E355 + 1;
      Gtk.Tree_Model'Elab_Body;
      E317 := E317 + 1;
      Gtk.Widget'Elab_Body;
      E224 := E224 + 1;
      Gtk.Window'Elab_Body;
      E287 := E287 + 1;
      E434 := E434 + 1;
      Gtk.Action'Elab_Spec;
      Gtk.Action'Elab_Body;
      E373 := E373 + 1;
      Gtk.Activatable'Elab_Spec;
      E377 := E377 + 1;
      Gtk.Button'Elab_Spec;
      Gtk.Button'Elab_Body;
      E371 := E371 + 1;
      Gtk.Color_Selection'Elab_Spec;
      Gtk.Color_Selection'Elab_Body;
      E379 := E379 + 1;
      Gtk.Color_Selection_Dialog'Elab_Spec;
      Gtk.Color_Selection_Dialog'Elab_Body;
      E381 := E381 + 1;
      Gtk.Drawing_Area'Elab_Spec;
      Gtk.Drawing_Area'Elab_Body;
      E446 := E446 + 1;
      Gtk.File_Chooser'Elab_Spec;
      E457 := E457 + 1;
      Gtk.File_Chooser_Dialog'Elab_Spec;
      Gtk.File_Chooser_Dialog'Elab_Body;
      E461 := E461 + 1;
      E383 := E383 + 1;
      E401 := E401 + 1;
      Gtk.Menu_Item'Elab_Spec;
      Gtk.Menu_Item'Elab_Body;
      E389 := E389 + 1;
      Gtk.Size_Group'Elab_Spec;
      Gtk.Size_Group'Elab_Body;
      E391 := E391 + 1;
      Gtk.Tool_Item'Elab_Spec;
      Gtk.Tool_Item'Elab_Body;
      E387 := E387 + 1;
      Gtk.Tool_Button'Elab_Spec;
      Gtk.Tool_Button'Elab_Body;
      E385 := E385 + 1;
      Gtk.Tree_View_Column'Elab_Spec;
      Gtk.Tree_View_Column'Elab_Body;
      E403 := E403 + 1;
      Gtkada.Handlers'Elab_Spec;
      E404 := E404 + 1;
      Gtkada.Builder'Elab_Spec;
      Gtkada.Builder'Elab_Body;
      E393 := E393 + 1;
      Gtkada.File_Selection'Elab_Body;
      E463 := E463 + 1;
      widget_editarea'elab_spec;
      widget_palette'elab_spec;
      widget_spritesbar'elab_spec;
      sprite_ed_data'elab_spec;
      E426 := E426 + 1;
      p_ellipse_mode'elab_body;
      E436 := E436 + 1;
      p_fill_mode'elab_body;
      E438 := E438 + 1;
      p_pencil_mode'elab_body;
      E428 := E428 + 1;
      p_rectangle_mode'elab_body;
      E440 := E440 + 1;
      p_select_mode'elab_body;
      E442 := E442 + 1;
      widget_editarea'elab_body;
      E432 := E432 + 1;
      widget_palette'elab_body;
      E449 := E449 + 1;
      widget_spritesbar'elab_body;
      E453 := E453 + 1;
      Window1_Callbacks'Elab_Spec;
      E455 := E455 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_gtk_sprite_ed");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      if gnat_argc = 0 then
         gnat_argc := argc;
         gnat_argv := argv;
      end if;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   D:\VcAda\GtkAdaSpriteEd\obj\my_rgba.o
   --   D:\VcAda\GtkAdaSpriteEd\obj\p_select.o
   --   D:\VcAda\GtkAdaSpriteEd\obj\sprite_ed_data.o
   --   D:\VcAda\GtkAdaSpriteEd\obj\p_ellipse_mode.o
   --   D:\VcAda\GtkAdaSpriteEd\obj\p_fill_mode.o
   --   D:\VcAda\GtkAdaSpriteEd\obj\p_pencil_mode.o
   --   D:\VcAda\GtkAdaSpriteEd\obj\p_rectangle_mode.o
   --   D:\VcAda\GtkAdaSpriteEd\obj\p_select_mode.o
   --   D:\VcAda\GtkAdaSpriteEd\obj\widget_editarea.o
   --   D:\VcAda\GtkAdaSpriteEd\obj\widget_palette.o
   --   D:\VcAda\GtkAdaSpriteEd\obj\widget_spritesbar.o
   --   D:\VcAda\GtkAdaSpriteEd\obj\window1_callbacks.o
   --   D:\VcAda\GtkAdaSpriteEd\obj\gtk_sprite_ed.o
   --   -LD:\VcAda\GtkAdaSpriteEd\obj\
   --   -LD:\VcAda\GtkAdaSpriteEd\obj\
   --   -LC:\msys64\mingw64\lib\gtkada\gtkada.static-pic\gtkada\
   --   -LC:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/13.2.0/adalib/
   --   -static
   --   -shared-libgcc
   --   -shared-libgcc
   --   -shared-libgcc
   --   -lgnat
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
