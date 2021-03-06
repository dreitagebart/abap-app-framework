CLASS zcl_app_table_functions DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      add_function
        IMPORTING
          iv_name      TYPE string
          iv_icon      TYPE icon_d
          iv_text      TYPE string
          iv_quickinfo TYPE string
          iv_position  TYPE salv_de_function_pos DEFAULT if_salv_c_function_position=>right_of_salv_functions,
      enable_function
        IMPORTING
          iv_name    TYPE string
          iv_enabled TYPE abap_bool DEFAULT abap_true,
      get_functions
        RETURNING VALUE(rt_result) TYPE salv_t_ui_func,
      is_item
        IMPORTING
                  iv_name          TYPE string
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_salv_function
        IMPORTING
                  iv_name          TYPE string
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_enabled
        IMPORTING
                  iv_name          TYPE string
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_visible
        IMPORTING
                  iv_name          TYPE string
        RETURNING VALUE(rv_result) TYPE abap_bool,
      remove_function
        IMPORTING
          iv_name TYPE string,
      constructor
        IMPORTING
          io_functions TYPE REF TO cl_salv_functions_list,
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
    DATA: mo_functions TYPE REF TO cl_salv_functions_list.

ENDCLASS.



CLASS zcl_app_table_functions IMPLEMENTATION.
  METHOD constructor.
    mo_functions = io_functions.
  ENDMETHOD.

  METHOD set_abc_analysis.
    mo_functions->set_abc_analysis( iv_active ).
  ENDMETHOD.

  METHOD set_aggregation_average.
    mo_functions->set_aggregation_average( iv_active ).
  ENDMETHOD.

  METHOD set_aggregation_count.
    mo_functions->set_aggregation_count( iv_active ).
  ENDMETHOD.

  METHOD set_aggregation_maximum.
    mo_functions->set_aggregation_maximum( iv_active ).
  ENDMETHOD.

  METHOD set_aggregation_minimum.
    mo_functions->set_aggregation_minimum( iv_active ).
  ENDMETHOD.

  METHOD set_aggregation_total.
    mo_functions->set_aggregation_total( iv_active ).
  ENDMETHOD.

  METHOD set_default.
    mo_functions->set_default( iv_active ).
  ENDMETHOD.

  METHOD set_detail.
    mo_functions->set_detail( iv_active ).
  ENDMETHOD.

  METHOD set_export_folder.
    mo_functions->set_export_folder( iv_active ).
  ENDMETHOD.

  METHOD set_export_html.
    mo_functions->set_export_html( iv_active ).
  ENDMETHOD.

  METHOD set_export_localfile.
    mo_functions->set_export_localfile( iv_active ).
  ENDMETHOD.

  METHOD set_export_mail.
    mo_functions->set_export_mail( iv_active ).
  ENDMETHOD.

  METHOD set_export_send.
    mo_functions->set_export_send( iv_active ).
  ENDMETHOD.

  METHOD set_export_spreadsheet.
    mo_functions->set_export_spreadsheet( iv_active ).
  ENDMETHOD.

  METHOD set_export_wordprocessor.
    mo_functions->set_export_wordprocessor( iv_active ).
  ENDMETHOD.

  METHOD set_export_xml.
    mo_functions->set_export_xml( iv_active ).
  ENDMETHOD.

  METHOD set_filter.
    mo_functions->set_filter( iv_active ).
  ENDMETHOD.

  METHOD set_filter_delete.
    mo_functions->set_filter_delete( iv_active ).
  ENDMETHOD.

  METHOD set_find.
    mo_functions->set_find( iv_active ).
  ENDMETHOD.

  METHOD set_find_more.
    mo_functions->set_find_more( iv_active ).
  ENDMETHOD.

  METHOD set_graphics.
    mo_functions->set_graphics( iv_active ).
  ENDMETHOD.

  METHOD set_group_aggregation.
    mo_functions->set_group_aggregation( iv_active ).
  ENDMETHOD.

  METHOD set_group_export.
    mo_functions->set_group_export( iv_active ).
  ENDMETHOD.

  METHOD set_group_filter.
    mo_functions->set_group_filter( iv_active ).
  ENDMETHOD.

  METHOD set_group_layout.
    mo_functions->set_group_layout( iv_active ).
  ENDMETHOD.

  METHOD set_group_sort.
    mo_functions->set_group_sort( iv_active ).
  ENDMETHOD.

  METHOD set_group_subtotal.
    mo_functions->set_group_subtotal( iv_active ).
  ENDMETHOD.

  METHOD set_group_view.
    mo_functions->set_group_view( iv_active ).
  ENDMETHOD.

  METHOD set_layout_change.
    mo_functions->set_layout_change( iv_active ).
  ENDMETHOD.

  METHOD set_layout_load.
    mo_functions->set_layout_load( iv_active ).
  ENDMETHOD.

  METHOD set_layout_maintain.
    mo_functions->set_layout_maintain( iv_active ).
  ENDMETHOD.

  METHOD set_layout_save.
    mo_functions->set_layout_maintain( iv_active ).
  ENDMETHOD.

  METHOD set_print.
    mo_functions->set_print( iv_active ).
  ENDMETHOD.

  METHOD set_print_preview.
    mo_functions->set_print_preview( iv_active ).
  ENDMETHOD.

  METHOD set_sort_asc.
    mo_functions->set_sort_asc( iv_active ).
  ENDMETHOD.

  METHOD set_sort_desc.
    mo_functions->set_sort_desc( iv_active ).
  ENDMETHOD.

  METHOD set_subtotals.
    mo_functions->set_subtotals( iv_active ).
  ENDMETHOD.

  METHOD set_subtotals_outline.
    mo_functions->set_subtotals_outline( iv_active ).
  ENDMETHOD.

  METHOD set_view_crystal.
    mo_functions->set_view_crystal( iv_active ).
  ENDMETHOD.

  METHOD set_view_excel.
    mo_functions->set_view_excel( iv_active ).
  ENDMETHOD.

  METHOD set_view_grid.
    mo_functions->set_view_grid( iv_active ).
  ENDMETHOD.

  METHOD set_view_lotus.
    mo_functions->set_view_lotus( iv_active ).
  ENDMETHOD.

  METHOD is_item.
    rv_result = mo_functions->is_item( CONV #( iv_name ) ).
  ENDMETHOD.

  METHOD is_salv_function.
    rv_result = mo_functions->is_salv_function( CONV #( iv_name ) ).
  ENDMETHOD.

  METHOD is_enabled.
    rv_result = mo_functions->is_enabled( CONV #( iv_name ) ).
  ENDMETHOD.

  METHOD get_functions.
    rt_result = mo_functions->get_functions( ).
  ENDMETHOD.

  METHOD is_visible.
    rv_result = mo_functions->is_visible( CONV #( iv_name ) ).
  ENDMETHOD.

  METHOD remove_function.
    TRY.
        mo_functions->remove_function( CONV #( iv_name ) ).
      CATCH cx_salv_not_found.
      CATCH cx_salv_wrong_call.
    ENDTRY.
  ENDMETHOD.

  METHOD enable_function.
    TRY.
        mo_functions->enable_function(
          name    = CONV #( iv_name )
          boolean = iv_enabled
        ).
      CATCH cx_salv_wrong_call.
      CATCH cx_salv_not_found.
    ENDTRY.
  ENDMETHOD.

  METHOD add_function.


    TRY.
        mo_functions->add_function(
          name     = CONV #( iv_name )
          icon     = CONV #( iv_icon )
          text     = iv_text
          tooltip  = iv_text
          position = iv_position
        ).
      CATCH cx_salv_existing.
      CATCH cx_salv_wrong_call.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
