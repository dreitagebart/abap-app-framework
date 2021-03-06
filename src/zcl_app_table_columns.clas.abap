CLASS zcl_app_table_columns DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: BEGIN OF ts_columns,
             name   TYPE string,
             column TYPE REF TO zcl_app_table_column,
           END OF ts_columns,

           tt_columns TYPE TABLE OF ts_columns WITH KEY name.

    CONSTANTS: BEGIN OF mc_apply_ddic,
                 columnname TYPE salv_de_constant VALUE cl_salv_ddic_apply=>c_apply_ddic_by_columnname,
                 rollname   TYPE salv_de_constant VALUE cl_salv_ddic_apply=>c_apply_ddic_by_rollname,
                 domain     TYPE salv_de_constant VALUE cl_salv_ddic_apply=>c_apply_ddic_by_domain,
               END OF mc_apply_ddic.

    METHODS:
      constructor
        IMPORTING
          io_columns TYPE REF TO cl_salv_columns_table,
      get_cell_type_column
        RETURNING VALUE(rv_result) TYPE string,
      get_color_column
        RETURNING VALUE(rv_result) TYPE string,
      get_count_column
        RETURNING VALUE(rv_result) TYPE string,
      get_dropdown_entry_column
        RETURNING VALUE(rv_result) TYPE string,
      get_enabled_column
        RETURNING VALUE(rv_result) TYPE string,
      get_exception_column
        RETURNING VALUE(rv_result) TYPE string,
      get_exception_settings
        EXPORTING
          !ev_group     TYPE char1
          !ev_condensed TYPE abap_bool,
      get_hyperlink_entry_column
        RETURNING VALUE(rv_result) TYPE string,
      has_key_fixation
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_exception_condensed
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_headers_visible
        RETURNING VALUE(rv_result) TYPE abap_bool,
      set_cell_type_column
        IMPORTING
          iv_value TYPE string
        RAISING
          cx_salv_data_error,
      set_color_column
        IMPORTING
          iv_value TYPE string
        RAISING
          cx_salv_data_error,
      set_count_column
        IMPORTING
          iv_value TYPE string
        RAISING
          cx_salv_data_error,
      set_dropdown_entry_column
        IMPORTING
          iv_value TYPE string
        RAISING
          cx_salv_data_error,
      set_enabled_column
        IMPORTING
          iv_value TYPE string
        RAISING
          cx_salv_data_error,
      set_exception_column
        IMPORTING
          iv_value     TYPE string
          iv_group     TYPE char1 DEFAULT space
          iv_condensed TYPE abap_bool DEFAULT abap_false
        RAISING
          cx_salv_data_error,
      set_headers_visible
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_hyperlink_entry_column
        IMPORTING
          iv_value TYPE string
        RAISING
          cx_salv_data_error,
      set_key_fixation
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      apply_ddic_structure
        IMPORTING
          iv_name         TYPE any
          iv_apply_method TYPE int4 DEFAULT mc_apply_ddic-columnname,
      get
        RETURNING VALUE(rt_result) TYPE tt_columns,
      get_column
        IMPORTING
                  iv_name          TYPE string
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_table_column
        RAISING
                  cx_salv_not_found,
      get_column_position
        IMPORTING
                  iv_name          TYPE string
        RETURNING VALUE(rv_result) TYPE int4
        RAISING
                  cx_salv_not_found,
      is_optimized
        RETURNING VALUE(rv_result) TYPE abap_bool,
      set_column_position
        IMPORTING
          iv_name     TYPE string
          iv_position TYPE int4 OPTIONAL,
      set_optimize
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true.


  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mo_columns TYPE REF TO cl_salv_columns_table,
          mt_columns TYPE tt_columns.

ENDCLASS.



CLASS zcl_app_table_columns IMPLEMENTATION.
  METHOD constructor.
    mo_columns = io_columns.

    LOOP AT mo_columns->get( ) REFERENCE INTO DATA(lr_column).
      APPEND VALUE ts_columns(
        name   = lr_column->columnname
        column = NEW zcl_app_table_column( CAST cl_salv_column_table( lr_column->r_column ) )
      ) TO mt_columns.
    ENDLOOP.
  ENDMETHOD.

  METHOD apply_ddic_structure.
    mo_columns->apply_ddic_structure(
      name         = iv_name
      apply_method = iv_apply_method
    ).
  ENDMETHOD.

  METHOD get.
    rt_result = mt_columns.
  ENDMETHOD.

  METHOD get_cell_type_column.
    rv_result = mo_columns->get_cell_type_column( ).
  ENDMETHOD.

  METHOD get_color_column.
    rv_result = mo_columns->get_color_column( ).
  ENDMETHOD.

  METHOD get_column.
    TRY.
        ro_result = mt_columns[ name = iv_name ]-column.
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.

  METHOD get_column_position.
    TRY.
        rv_result = mo_columns->get_column_position( CONV #( iv_name ) ).
      CATCH cx_salv_not_found INTO DATA(lx_error).
        RAISE EXCEPTION lx_error.
    ENDTRY.
  ENDMETHOD.

  METHOD get_count_column.
    rv_result = mo_columns->get_count_column( ).
  ENDMETHOD.

  METHOD get_dropdown_entry_column.
    rv_result = mo_columns->get_dropdown_entry_column( ).
  ENDMETHOD.

  METHOD get_enabled_column.
    rv_result = mo_columns->get_enabled_column( ).
  ENDMETHOD.

  METHOD get_exception_column.
    rv_result = mo_columns->get_exception_column( ).
  ENDMETHOD.

  METHOD get_exception_settings.
    mo_columns->get_exception_settings(
      IMPORTING
        group     = ev_group
        condensed = ev_condensed
    ).
  ENDMETHOD.

  METHOD get_hyperlink_entry_column.
    rv_result = mo_columns->get_hyperlink_entry_column( ).
  ENDMETHOD.

  METHOD has_key_fixation.
    rv_result = mo_columns->has_key_fixation( ).
  ENDMETHOD.

  METHOD is_exception_condensed.
    rv_result = mo_columns->is_exception_condensed( ).
  ENDMETHOD.

  METHOD is_headers_visible.
    rv_result = mo_columns->is_headers_visible( ).
  ENDMETHOD.

  METHOD is_optimized.
    rv_result = mo_columns->is_optimized( ).
  ENDMETHOD.

  METHOD set_cell_type_column.
    TRY.
        mo_columns->set_cell_type_column( CONV #( iv_value ) ).
      CATCH cx_salv_data_error INTO DATA(lx_error).
        RAISE EXCEPTION lx_error.
    ENDTRY.
  ENDMETHOD.

  METHOD set_color_column.
    TRY.
        mo_columns->set_color_column( CONV #( iv_value ) ).
      CATCH cx_salv_data_error INTO DATA(lx_error).
    ENDTRY.
  ENDMETHOD.

  METHOD set_column_position.
    mo_columns->set_column_position(
      columnname = CONV #( iv_name )
      position   = iv_position
    ).
  ENDMETHOD.

  METHOD set_count_column.
    TRY.
        mo_columns->set_count_column( CONV #( iv_value ) ).
      CATCH cx_salv_data_error INTO DATA(lx_error).
        RAISE EXCEPTION lx_error.
    ENDTRY.
  ENDMETHOD.

  METHOD set_dropdown_entry_column.
    TRY.
        mo_columns->set_dropdown_entry_column( CONV #( iv_value ) ).
      CATCH cx_salv_data_error INTO DATA(lx_error).
        RAISE EXCEPTION lx_error.
    ENDTRY.
  ENDMETHOD.

  METHOD set_enabled_column.
    TRY.
        mo_columns->set_enabled_column( CONV #( iv_value ) ).
      CATCH cx_salv_data_error INTO DATA(lx_error).
        RAISE EXCEPTION lx_error.
    ENDTRY.
  ENDMETHOD.

  METHOD set_exception_column.
    TRY.
        mo_columns->set_exception_column(
          value     = CONV #( iv_value )
          group     = iv_group
          condensed = iv_condensed
        ).
      CATCH cx_salv_data_error INTO DATA(lx_error).
        RAISE EXCEPTION lx_error.
    ENDTRY.
  ENDMETHOD.

  METHOD set_headers_visible.
    mo_columns->set_headers_visible( iv_value ).
  ENDMETHOD.

  METHOD set_hyperlink_entry_column.
    TRY.
        mo_columns->set_hyperlink_entry_column( CONV #( iv_value ) ).
      CATCH cx_salv_data_error INTO DATA(lx_error).
        RAISE EXCEPTION lx_error.
    ENDTRY.
  ENDMETHOD.

  METHOD set_key_fixation.
    mo_columns->set_key_fixation( iv_value ).
  ENDMETHOD.

  METHOD set_optimize.
    mo_columns->set_optimize( iv_value ).
  ENDMETHOD.
ENDCLASS.
