CLASS zcl_app_table_settings DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    CONSTANTS: BEGIN OF mc_header_sizes,
                 big    TYPE int4 VALUE 0,
                 small  TYPE int4 VALUE 1,
                 middle TYPE int4 VALUE 2,
               END OF mc_header_sizes.

    METHODS:
      constructor
        IMPORTING
          ir_layout TYPE REF TO lvc_s_layo,
*          io_settings TYPE REF TO cl_salv_display_settings,
      is_merged
        RETURNING VALUE(rv_result) TYPE abap_bool,
      set_no_merging
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_striped_pattern
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      is_striped_pattern
        RETURNING
          VALUE(rv_result) TYPE abap_bool,
      set_list_header_size
        IMPORTING
          iv_value TYPE int4 DEFAULT mc_header_sizes-big,
      get_list_header_size
        RETURNING
          VALUE(rv_result) TYPE int4,
      set_horizontal_lines
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      is_horizontal_lines
        RETURNING
          VALUE(rv_result) TYPE abap_bool,
      is_vertical_lines
        RETURNING
          VALUE(rv_result) TYPE abap_bool,
      set_vertical_lines
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_list_header
        IMPORTING
          iv_value TYPE string,
      get_list_header
        RETURNING
          VALUE(rv_result) TYPE string,
      get_suppress_empty_data
        RETURNING
          VALUE(rv_result) TYPE abap_bool,
      set_suppress_empty_data
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      set_fit_column_to_table_size
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true,
      get_fit_column_to_table_size
        RETURNING
          VALUE(rv_result) TYPE abap_bool,
      get_max_linesize
        RETURNING
          VALUE(rv_result) TYPE int4,
      get_min_linesize
        RETURNING
          VALUE(rv_result) TYPE int4,
      set_max_linesize
        IMPORTING
          iv_value TYPE int4,
      set_min_linesize
        IMPORTING
          iv_value TYPE int4.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mr_layout TYPE REF TO lvc_s_layo.
*    DATA: mo_settings TYPE REF TO cl_salv_display_settings.

ENDCLASS.



CLASS zcl_app_table_settings IMPLEMENTATION.
  METHOD constructor.
    mr_layout = ir_layout.

*    mo_settings = io_settings.
  ENDMETHOD.

  METHOD get_fit_column_to_table_size.
*    rv_result = mo_settings->get_fit_column_to_table_size( ).
  ENDMETHOD.

  METHOD get_list_header.
    rv_result = mr_layout->grid_title.

*    rv_result = mo_settings->get_list_header( ).
  ENDMETHOD.

  METHOD get_list_header_size.
    rv_result = mr_layout->smalltitle.
*    rv_result = mo_settings->get_list_header_size( ).
  ENDMETHOD.

  METHOD get_max_linesize.
*  rv_result = mr_layout-

*    rv_result = mo_settings->get_max_linesize( ).
  ENDMETHOD.

  METHOD get_min_linesize.
*    rv_result = mo_settings->get_min_linesize( ).
  ENDMETHOD.

  METHOD get_suppress_empty_data.
*  rv_result = mr_layout->

*    rv_result = mo_settings->get_suppress_empty_data( ).
  ENDMETHOD.

  METHOD is_horizontal_lines.
    rv_result = SWITCH #( mr_layout->no_hgridln WHEN abap_true  THEN abap_false
                                                WHEN abap_false THEN abap_true ).

*    rv_result = mo_settings->is_horizontal_lines( ).
  ENDMETHOD.

  METHOD is_merged.
    rv_result = SWITCH #( mr_layout->no_merging WHEN abap_true  THEN abap_false
                                                WHEN abap_false THEN abap_true ).

*    rv_result = mo_settings->is_merged( ).
  ENDMETHOD.

  METHOD is_striped_pattern.
    rv_result = mr_layout->zebra.

*    rv_result = mo_settings->is_striped_pattern( ).
  ENDMETHOD.

  METHOD is_vertical_lines.
    rv_result = SWITCH #( mr_layout->no_vgridln WHEN abap_true  THEN abap_false
                                                WHEN abap_false THEN abap_true ).

*    rv_result = mo_settings->is_striped_pattern( ).
  ENDMETHOD.

  METHOD set_fit_column_to_table_size.

*    mo_settings->set_fit_column_to_table_size( iv_value ).
  ENDMETHOD.

  METHOD set_horizontal_lines.
    mr_layout->no_hgridln = SWITCH #( iv_value WHEN abap_true  THEN abap_false
                                               WHEN abap_false THEN abap_true ).

*    mo_settings->set_horizontal_lines( iv_value ).
  ENDMETHOD.

  METHOD set_list_header.
    mr_layout->grid_title = iv_value.

*    mo_settings->set_list_header( CONV #( iv_value ) ).
  ENDMETHOD.

  METHOD set_list_header_size.
*  mr_layout->

*    mo_settings->set_list_header_size( iv_value ).
  ENDMETHOD.

  METHOD set_max_linesize.
*    mo_settings->set_max_linesize( iv_value ).
  ENDMETHOD.

  METHOD set_min_linesize.
*    mo_settings->set_min_linesize( iv_value ).
  ENDMETHOD.

  METHOD set_no_merging.
    mr_layout->no_merging = iv_value.

*    mo_settings->set_no_merging( iv_value ).
  ENDMETHOD.

  METHOD set_striped_pattern.
    mr_layout->zebra = iv_value.

*    mo_settings->set_striped_pattern( iv_value ).
  ENDMETHOD.

  METHOD set_suppress_empty_data.
*    mo_settings->set_suppress_empty_data( iv_value ).
  ENDMETHOD.

  METHOD set_vertical_lines.
    mr_layout->no_hgridln = SWITCH #( iv_value WHEN abap_true  THEN abap_false
                                               WHEN abap_false THEN abap_true ).

*    mo_settings->set_vertical_lines( iv_value ).
  ENDMETHOD.
ENDCLASS.
