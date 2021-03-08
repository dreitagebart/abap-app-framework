CLASS zcl_app_table_function DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zcl_app_table_functions
                 zcl_app_alv_table.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_function TYPE string
          iv_text     TYPE string
          iv_tooltip  TYPE string
          iv_icon     TYPE icon_d,
      is_visible
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_invisible
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_enabled
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_disabled
        RETURNING VALUE(rv_result) TYPE abap_bool,
      get_group
        RETURNING VALUE(rv_result) TYPE salv_de_function,
      get_icon
        RETURNING VALUE(rv_result) TYPE string,
      get_name
        RETURNING VALUE(rv_result) TYPE string,
      get_text
        RETURNING VALUE(rv_result) TYPE string,
      get_tooltip
        RETURNING VALUE(rv_result) TYPE string,
      get_visible
        RETURNING VALUE(rv_result) TYPE abap_bool,
      set_enable
        IMPORTING
          iv_value TYPE abap_bool,
      set_group
        IMPORTING
          iv_value TYPE salv_de_function,
      set_icon
        IMPORTING
          iv_value TYPE string,
      set_name
        IMPORTING
          iv_value TYPE string,
      set_text
        IMPORTING
          iv_value TYPE string,
      set_tooltip
        IMPORTING
          iv_value TYPE string,
      set_visible
        IMPORTING
          iv_value TYPE abap_bool DEFAULT abap_true.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mv_enabled  TYPE abap_bool,
          mv_visible  TYPE abap_bool,
          mv_icon     TYPE icon_d,
          mv_text     TYPE string,
          mv_tooltip  TYPE string,
          mv_function TYPE string,
          mv_group    TYPE string.

ENDCLASS.



CLASS zcl_app_table_function IMPLEMENTATION.
  METHOD constructor.
    mv_function = iv_function.
    mv_icon     = iv_icon.
    mv_text     = iv_text.
    mv_tooltip  = iv_tooltip.
    mv_enabled  = abap_true.
    mv_visible  = abap_true.
  ENDMETHOD.

  METHOD get_group.
    rv_result = mv_group.
  ENDMETHOD.

  METHOD get_icon.
    rv_result = mv_icon.
  ENDMETHOD.

  METHOD get_name.
    rv_result = mv_function.
  ENDMETHOD.

  METHOD get_text.
    rv_result = mv_text.
  ENDMETHOD.

  METHOD get_tooltip.
    rv_result = mv_tooltip.
  ENDMETHOD.

  METHOD get_visible.
    rv_result = mv_visible.
  ENDMETHOD.

  METHOD is_disabled.
    rv_result = SWITCH #( mv_enabled WHEN abap_true THEN abap_false
                                     ELSE abap_true ).
  ENDMETHOD.

  METHOD is_enabled.
    rv_result = SWITCH #( mv_enabled WHEN abap_true THEN abap_true
                                     ELSE abap_false ).
  ENDMETHOD.

  METHOD is_invisible.
    rv_result = SWITCH #( mv_visible WHEN abap_true THEN abap_false
                                     ELSE abap_true ).
  ENDMETHOD.

  METHOD is_visible.
    rv_result = SWITCH #( mv_visible WHEN abap_true THEN abap_true
                                     ELSE abap_false ).
  ENDMETHOD.

  METHOD set_visible.
    mv_visible = iv_value.
  ENDMETHOD.

  METHOD set_enable.
    mv_enabled = iv_value.
  ENDMETHOD.

  METHOD set_group.
    mv_group = iv_value.
  ENDMETHOD.

  METHOD set_icon.
    mv_icon = iv_value.
  ENDMETHOD.

  METHOD set_name.
    mv_function = iv_value.
  ENDMETHOD.

  METHOD set_text.
    mv_text = iv_value.
  ENDMETHOD.

  METHOD set_tooltip.
    mv_tooltip = iv_value.
  ENDMETHOD.
ENDCLASS.
