CLASS zcl_app_container_table DEFINITION
  PUBLIC
  INHERITING FROM zca_app_container
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
      create
        IMPORTING
                  iv_name          TYPE string
                  iv_side          TYPE i DEFAULT mc_sides-custom
        CHANGING
                  ct_table         TYPE table
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_container_table.

    METHODS:
      create_instance REDEFINITION,
      register_events REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mo_salv  TYPE REF TO cl_salv_table,
          mr_table TYPE REF TO data.

    METHODS:
      constructor
        IMPORTING
          iv_name TYPE string
          iv_side TYPE i DEFAULT mc_sides-custom,
      on_added_function FOR EVENT added_function OF cl_salv_events_table
        IMPORTING
          e_salv_function
          sender,
      on_link_click FOR EVENT link_click OF cl_salv_events_table
        IMPORTING
          column
          row
          sender,
      on_double_click FOR EVENT double_click OF cl_salv_events_table
        IMPORTING
          column
          row
          sender,
      on_after_function FOR EVENT after_salv_function OF cl_salv_events_table
        IMPORTING
          e_salv_function
          sender,
      on_before_function FOR EVENT before_salv_function OF cl_salv_events_table
        IMPORTING
          e_salv_function
          sender.

ENDCLASS.



CLASS zcl_app_container_table IMPLEMENTATION.
  METHOD constructor.
    super->constructor(
      iv_name = iv_name
      iv_side = iv_side
    ).
  ENDMETHOD.

  METHOD register_events.
    DATA(lo_event) = mo_salv->get_event( ).

    SET HANDLER on_added_function FOR lo_event.
    SET HANDLER on_after_function FOR lo_event.
    SET HANDLER on_before_function FOR lo_event.
    SET HANDLER on_double_click FOR lo_event.
    SET HANDLER on_link_click FOR lo_event.
  ENDMETHOD.

  METHOD on_added_function.
    BREAK developer.
    mo_app->on_table_added_function(
      iv_function = CONV #( e_salv_function )
      io_table    = me
    ).
  ENDMETHOD.

  METHOD on_after_function.
    BREAK developer.
    mo_app->on_table_after_function(
      iv_function = CONV #( e_salv_function )
      io_table    = me
    ).
  ENDMETHOD.

  METHOD on_before_function.
    BREAK developer.
    mo_app->on_table_before_function(
      iv_function = CONV #( e_salv_function )
      io_table    = me
    ).
  ENDMETHOD.

  METHOD on_double_click.
    BREAK developer.
    mo_app->on_table_double_click(
      iv_row    = row
      iv_column = CONV #( column )
      io_table  = me
    ).
  ENDMETHOD.

  METHOD on_link_click.
    BREAK developer.
    mo_app->on_table_double_click(
      iv_row    = row
      iv_column = CONV #( column )
      io_table  = me
    ).
  ENDMETHOD.

  METHOD create.
    ro_result = NEW zcl_app_container_table(
      iv_name = iv_name
      iv_side = iv_side
    ).

    GET REFERENCE OF ct_table INTO ro_result->mr_table.
  ENDMETHOD.

  METHOD create_instance.
    FIELD-SYMBOLS: <table> TYPE ANY TABLE.

    ASSIGN mr_table->* TO <table>.

    TRY.
        cl_salv_table=>factory(
          EXPORTING
*           list_display   = if_salv_c_bool_sap=>false
            r_container    = get_parent( )
*           container_name =
          IMPORTING
            r_salv_table   = mo_salv
          CHANGING
            t_table        = <table>
        ).

        mo_salv->display( ).
      CATCH cx_salv_msg.
    ENDTRY.

    register_events( ).
  ENDMETHOD.
ENDCLASS.
