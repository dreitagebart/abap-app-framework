CLASS zcl_app_table_layout DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          io_layout TYPE REF TO cl_salv_layout,
      get_current_layout
        RETURNING
          VALUE(rs_result) TYPE salv_s_layout,
      get_default_layout
        RETURNING
          VALUE(rs_result) TYPE salv_s_layout,
      get_initial_layout
        RETURNING
          VALUE(rv_result) TYPE slis_vari,
      get_key
        RETURNING
          VALUE(rs_result) TYPE salv_s_layout_key,
      get_layouts
        RETURNING
          VALUE(rt_result) TYPE salv_t_layout_info,
      get_save_restriction
        RETURNING
          VALUE(rv_result) TYPE salv_de_layout_restriction,
      has_default
        RETURNING
          VALUE(rv_result) TYPE abap_bool,
      set_default
        IMPORTING
          iv_default TYPE abap_bool DEFAULT abap_true,
      set_initial_layout
        IMPORTING
          iv_layout TYPE slis_vari,
      set_key
        IMPORTING
          is_key TYPE salv_s_layout_key,
      set_save_restriction
        IMPORTING
          iv_restriction TYPE salv_de_layout_restriction DEFAULT if_salv_c_layout=>restrict_none .

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mo_layout TYPE REF TO cl_salv_layout.

ENDCLASS.



CLASS zcl_app_table_layout IMPLEMENTATION.
  METHOD constructor.
    mo_layout = io_layout.
  ENDMETHOD.

  METHOD get_layouts.
    rt_result = mo_layout->get_layouts( ).
  ENDMETHOD.

  METHOD get_current_layout.
    rs_result = mo_layout->get_current_layout( ).
  ENDMETHOD.

  METHOD get_default_layout.
    rs_result = mo_layout->get_default_layout( ).
  ENDMETHOD.

  METHOD get_initial_layout.
    rv_result = mo_layout->get_initial_layout( ).
  ENDMETHOD.

  METHOD get_key.
    rs_result = mo_layout->get_key( ).
  ENDMETHOD.

  METHOD get_save_restriction.
    rv_result = mo_layout->get_save_restriction( ).
  ENDMETHOD.

  METHOD has_default.
    rv_result = mo_layout->has_default( ).
  ENDMETHOD.

  METHOD set_default.
    mo_layout->set_default( iv_default ).
  ENDMETHOD.

  METHOD set_initial_layout.
    mo_layout->set_initial_layout( iv_layout ).
  ENDMETHOD.

  METHOD set_key.
    mo_layout->set_key( is_key ).
  ENDMETHOD.

  METHOD set_save_restriction.
    mo_layout->set_save_restriction( iv_restriction ).
  ENDMETHOD.
ENDCLASS.
