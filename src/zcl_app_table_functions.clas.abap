CLASS zcl_app_table_functions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: BEGIN OF ts_function,
             name     TYPE string,
             function TYPE REF TO zcl_app_table_function,
           END OF ts_function,

           tt_function TYPE TABLE OF ts_function WITH KEY name.

    METHODS:
      add_function
        IMPORTING
                  iv_name     TYPE string
                  iv_icon     TYPE icon_d
                  iv_text     TYPE string OPTIONAL
                  iv_tooltip  TYPE string OPTIONAL
                  iv_position TYPE salv_de_function_pos DEFAULT if_salv_c_function_position=>right_of_salv_functions
        RAISING   zcx_app,
      disable_function
        IMPORTING
                  iv_name TYPE string
        RAISING   zcx_app,
      enable_function
        IMPORTING
                  iv_name TYPE string
        RAISING   zcx_app,
      get_functions
        RETURNING VALUE(rt_result) TYPE tt_function,
      is_function
        IMPORTING
                  iv_name          TYPE string
        RETURNING VALUE(rv_result) TYPE abap_bool
        RAISING   zcx_app,
      is_enabled
        IMPORTING
                  iv_name          TYPE string
        RETURNING VALUE(rv_result) TYPE abap_bool
        RAISING   zcx_app,
      is_visible
        IMPORTING
                  iv_name          TYPE string
        RETURNING VALUE(rv_result) TYPE abap_bool
        RAISING   zcx_app,
      remove_function
        IMPORTING
                  iv_name TYPE string
        RAISING   zcx_app,
      constructor,
      set_abc_analysis
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_aggregation_average
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_aggregation_count
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_aggregation_maximum
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_aggregation_minimum
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_aggregation_total
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_default
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_detail
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_export_folder
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_export_html
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_export_localfile
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_export_mail
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_export_send
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_export_spreadsheet
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_export_wordprocessor
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_export_xml
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_filter
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_filter_delete
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_group_aggregation
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_group_export
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_group_filter
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_group_layout
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_group_sort
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_group_subtotal
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_group_view
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_layout_change
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_layout_load
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_layout_maintain
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_layout_save
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_print
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_print_preview
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_sort_asc
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_sort_desc
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_subtotals
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_subtotals_outline
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_view_crystal
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_view_excel
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_view_grid
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_view_lotus
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_find
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_find_more
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true,
      set_graphics
        IMPORTING
          iv_active TYPE abap_bool DEFAULT abap_true.


  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mt_exclude   TYPE lvc_t_excl,
          mt_functions TYPE tt_function.
*    DATA: mo_functions TYPE REF TO cl_salv_functions_list.

ENDCLASS.



CLASS zcl_app_table_functions IMPLEMENTATION.
  METHOD constructor.


*    mo_functions = io_functions.
  ENDMETHOD.

  METHOD set_abc_analysis.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_call_abc TO mt_exclude.
    ENDIF.

*    mo_functions->set_abc_analysis( iv_active ).
  ENDMETHOD.

  METHOD set_aggregation_average.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_average TO mt_exclude.
    ENDIF.

*    mo_functions->set_aggregation_average( iv_active ).
  ENDMETHOD.

  METHOD set_aggregation_count.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_count TO mt_exclude.
    ENDIF.

*    mo_functions->set_aggregation_count( iv_active ).
  ENDMETHOD.

  METHOD set_aggregation_maximum.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_maximum TO mt_exclude.
    ENDIF.

*    mo_functions->set_aggregation_maximum( iv_active ).
  ENDMETHOD.

  METHOD set_aggregation_minimum.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_minimum TO mt_exclude.
    ENDIF.

*    mo_functions->set_aggregation_minimum( iv_active ).
  ENDMETHOD.

  METHOD set_aggregation_total.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_auf TO mt_exclude.
    ENDIF.

*    mo_functions->set_aggregation_total( iv_active ).
  ENDMETHOD.

  METHOD set_default.
*    mo_functions->set_default( iv_active ).
  ENDMETHOD.

  METHOD set_detail.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_detail TO mt_exclude.
    ENDIF.

*    mo_functions->set_detail( iv_active ).
  ENDMETHOD.

  METHOD set_export_folder.
*        IF iv_active = abap_false.
*      APPEND cl_gui_alv_grid=>mc_mb TO mt_exclude.
*    ENDIF.

*    mo_functions->set_export_folder( iv_active ).
  ENDMETHOD.

  METHOD set_export_html.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_html TO mt_exclude.
    ENDIF.

*    mo_functions->set_export_html( iv_active ).
  ENDMETHOD.

  METHOD set_export_localfile.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_pc_file TO mt_exclude.
    ENDIF.

*    mo_functions->set_export_localfile( iv_active ).
  ENDMETHOD.

  METHOD set_export_mail.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_to_office TO mt_exclude.
    ENDIF.

*    mo_functions->set_export_mail( iv_active ).
  ENDMETHOD.

  METHOD set_export_send.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_send TO mt_exclude.
    ENDIF.

*    mo_functions->set_export_send( iv_active ).
  ENDMETHOD.

  METHOD set_export_spreadsheet.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_to_office TO mt_exclude.
    ENDIF.

*    mo_functions->set_export_spreadsheet( iv_active ).
  ENDMETHOD.

  METHOD set_export_wordprocessor.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_word_processor TO mt_exclude.
    ENDIF.
*    mo_functions->set_export_wordprocessor( iv_active ).
  ENDMETHOD.

  METHOD set_export_xml.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_call_xml_export TO mt_exclude.
    ENDIF.

*    mo_functions->set_export_xml( iv_active ).
  ENDMETHOD.

  METHOD set_filter.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_filter TO mt_exclude.
    ENDIF.

*    mo_functions->set_filter( iv_active ).
  ENDMETHOD.

  METHOD set_filter_delete.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_delete_filter TO mt_exclude.
    ENDIF.

*    mo_functions->set_filter_delete( iv_active ).
  ENDMETHOD.

  METHOD set_find.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_find TO mt_exclude.
    ENDIF.
*    mo_functions->set_find( iv_active ).
  ENDMETHOD.

  METHOD set_find_more.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_find_more TO mt_exclude.
    ENDIF.
*    mo_functions->set_find_more( iv_active ).
  ENDMETHOD.

  METHOD set_graphics.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_graph TO mt_exclude.
    ENDIF.
*    mo_functions->set_graphics( iv_active ).
  ENDMETHOD.

  METHOD set_group_aggregation.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_mb_sum TO mt_exclude.
    ENDIF.

*    mo_functions->set_group_aggregation( iv_active ).
  ENDMETHOD.

  METHOD set_group_export.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_mb_export TO mt_exclude.
    ENDIF.

*    mo_functions->set_group_export( iv_active ).
  ENDMETHOD.

  METHOD set_group_filter.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_mb_filter TO mt_exclude.
    ENDIF.

*    mo_functions->set_group_filter( iv_active ).
  ENDMETHOD.

  METHOD set_group_layout.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_mb_variant TO mt_exclude.
    ENDIF.
*    mo_functions->set_group_layout( iv_active ).
  ENDMETHOD.

  METHOD set_group_sort.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_sort TO mt_exclude.
    ENDIF.
*    mo_functions->set_group_sort( iv_active ).
  ENDMETHOD.

  METHOD set_group_subtotal.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_mb_subtot TO mt_exclude.
    ENDIF.
*    mo_functions->set_group_subtotal( iv_active ).
  ENDMETHOD.

  METHOD set_group_view.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_mb_view TO mt_exclude.
    ENDIF.
*    mo_functions->set_group_view( iv_active ).
  ENDMETHOD.

  METHOD set_layout_change.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_variant_admin TO mt_exclude.
    ENDIF.

*    mo_functions->set_layout_change( iv_active ).
  ENDMETHOD.

  METHOD set_layout_load.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_load_variant TO mt_exclude.
    ENDIF.

*    mo_functions->set_layout_load( iv_active ).
  ENDMETHOD.

  METHOD set_layout_maintain.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_maintain_variant TO mt_exclude.
    ENDIF.

*    mo_functions->set_layout_maintain( iv_active ).
  ENDMETHOD.

  METHOD set_layout_save.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_save_variant TO mt_exclude.
    ENDIF.

*    mo_functions->set_layout_maintain( iv_active ).
  ENDMETHOD.

  METHOD set_print.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_print TO mt_exclude.
    ENDIF.

*    mo_functions->set_print( iv_active ).
  ENDMETHOD.

  METHOD set_print_preview.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_print_prev TO mt_exclude.
    ENDIF.
*    mo_functions->set_print_preview( iv_active ).
  ENDMETHOD.

  METHOD set_sort_asc.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_sort_asc TO mt_exclude.
    ENDIF.
*    mo_functions->set_sort_asc( iv_active ).
  ENDMETHOD.

  METHOD set_sort_desc.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_sort_dsc TO mt_exclude.
    ENDIF.
*    mo_functions->set_sort_desc( iv_active ).
  ENDMETHOD.

  METHOD set_subtotals.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_subtot TO mt_exclude.
    ENDIF.
*    mo_functions->set_subtotals( iv_active ).
  ENDMETHOD.

  METHOD set_subtotals_outline.
*        IF iv_active = abap_false.
*      APPEND cl_gui_alv_grid=>mc_fc_ TO mt_exclude.
*    ENDIF.
*    mo_functions->set_subtotals_outline( iv_active ).
  ENDMETHOD.

  METHOD set_view_crystal.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_view_crystal TO mt_exclude.
    ENDIF.
*    mo_functions->set_view_crystal( iv_active ).
  ENDMETHOD.

  METHOD set_view_excel.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_view_excel TO mt_exclude.
    ENDIF.
*    mo_functions->set_view_excel( iv_active ).
  ENDMETHOD.

  METHOD set_view_grid.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_view_grid TO mt_exclude.
    ENDIF.
  ENDMETHOD.

  METHOD set_view_lotus.
    IF iv_active = abap_false.
      APPEND cl_gui_alv_grid=>mc_fc_view_lotus TO mt_exclude.
    ENDIF.

  ENDMETHOD.

  METHOD is_function.
    IF line_exists( mt_functions[ name = iv_name ] ).
      rv_result = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD is_enabled.
    TRY.
        DATA(lr_function) = REF #( mt_functions[ name = iv_name ] ).

        rv_result = lr_function->function->mv_enabled.
      CATCH cx_sy_itab_line_not_found.
        RAISE EXCEPTION TYPE zcx_app
          MESSAGE e018 WITH iv_name.
    ENDTRY.
  ENDMETHOD.

  METHOD get_functions.
    rt_result = mt_functions.
  ENDMETHOD.

  METHOD is_visible.
    TRY.
        DATA(lr_function) = REF #( mt_functions[ name = iv_name ] ).

        rv_result = lr_function->function->mv_visible.
      CATCH cx_sy_itab_line_not_found.
        RAISE EXCEPTION TYPE zcx_app
          MESSAGE e018 WITH iv_name.
    ENDTRY.
  ENDMETHOD.

  METHOD remove_function.
    TRY.
        DATA(lr_function) = REF #( mt_functions[ name = iv_name ] ).

        CLEAR lr_function->*.
        DELETE mt_functions INDEX sy-tabix.
      CATCH cx_sy_itab_line_not_found.
        RAISE EXCEPTION TYPE zcx_app
          MESSAGE e018 WITH iv_name.
    ENDTRY.
  ENDMETHOD.

  METHOD disable_function.
    TRY.
        DATA(lr_function) = REF #( mt_functions[ name = iv_name ] ).

        lr_function->function->mv_enabled = abap_false.
      CATCH cx_sy_itab_line_not_found.
        RAISE EXCEPTION TYPE zcx_app
          MESSAGE e018 WITH iv_name.
    ENDTRY.
  ENDMETHOD.

  METHOD enable_function.
    TRY.
        DATA(lr_function) = REF #( mt_functions[ name = iv_name ] ).

        lr_function->function->mv_enabled = abap_true.
      CATCH cx_sy_itab_line_not_found.
        RAISE EXCEPTION TYPE zcx_app
          MESSAGE e018 WITH iv_name.
    ENDTRY.
  ENDMETHOD.

  METHOD add_function.
    IF line_exists( mt_functions[ name = iv_name ] ).
      RAISE EXCEPTION TYPE zcx_app
        MESSAGE e019 WITH iv_name.
    ENDIF.

    DATA(lo_function) = NEW zcl_app_table_function(
      iv_function = iv_name
      iv_icon     = iv_icon
      iv_text     = iv_text
      iv_tooltip  = iv_tooltip
    ).

    APPEND VALUE ts_function( name     = iv_name
                              function = lo_function ) TO mt_functions.
  ENDMETHOD.
ENDCLASS.
