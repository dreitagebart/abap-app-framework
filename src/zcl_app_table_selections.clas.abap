CLASS zcl_app_table_selections DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          ir_layout TYPE REF TO lvc_s_layo
          io_alv    TYPE REF TO cl_gui_alv_grid,
      set_selection_mode
        IMPORTING
          iv_selmode TYPE char1 DEFAULT zcl_app_alv_table=>mc_selmodes-row_column,
      get_selected_rows
        RETURNING VALUE(rt_result) TYPE lvc_t_row,
      get_selected_columns
        RETURNING VALUE(rt_result) TYPE lvc_t_col.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mo_alv    TYPE REF TO cl_gui_alv_grid,
          mr_layout TYPE REF TO lvc_s_layo.

ENDCLASS.



CLASS zcl_app_table_selections IMPLEMENTATION.


  METHOD constructor.
    mr_layout = ir_layout.
  ENDMETHOD.


  METHOD get_selected_columns.
    mo_alv->get_selected_columns(
      IMPORTING
        et_index_columns = rt_result
    ).
  ENDMETHOD.


  METHOD get_selected_rows.
    mo_alv->get_selected_rows(
      IMPORTING
        et_index_rows = rt_result
        et_row_no     = DATA(lt_rows)
    ).
  ENDMETHOD.


  METHOD set_selection_mode.
    mr_layout->sel_mode = iv_selmode.
  ENDMETHOD.
ENDCLASS.
