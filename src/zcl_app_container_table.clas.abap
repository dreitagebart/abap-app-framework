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
      register_events REDEFINITION,
      get_functions
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_table_functions,
      get_columns
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_table_columns,
      get_settings
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_table_settings,
      get_selections
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_table_selections.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mo_table TYPE REF TO zcl_app_alv_table,
          mr_table TYPE REF TO data.

    METHODS:
      constructor
        IMPORTING
          iv_name TYPE string
          iv_side TYPE i DEFAULT mc_sides-custom,
      on_added_function FOR EVENT on_added_function OF zcl_app_alv_table
        IMPORTING
          iv_function,
      on_link_click FOR EVENT on_link_click OF zcl_app_alv_table
        IMPORTING
          iv_row
          iv_column,
      on_double_click FOR EVENT on_double_click OF zcl_app_alv_table
        IMPORTING
          iv_row
          iv_column,
      on_after_function FOR EVENT on_after_function OF zcl_app_alv_table
        IMPORTING
          iv_function,
      on_before_function FOR EVENT on_before_function OF zcl_app_alv_table
        IMPORTING
          iv_function.

ENDCLASS.



CLASS zcl_app_container_table IMPLEMENTATION.
  METHOD get_columns.
    ro_result = mo_table->get_columns( ).
  ENDMETHOD.

  METHOD get_functions.
    ro_result = mo_table->get_functions( ).
  ENDMETHOD.

  METHOD get_selections.
    ro_result = mo_table->get_selections( ).
  ENDMETHOD.

  METHOD get_settings.
*    ro_result = mo_table->get_settings( ).
  ENDMETHOD.

  METHOD constructor.
    super->constructor(
      iv_name = iv_name
      iv_side = iv_side
    ).
  ENDMETHOD.

  METHOD register_events.
    SET HANDLER on_added_function FOR mo_table.
    SET HANDLER on_after_function FOR mo_table.
    SET HANDLER on_before_function FOR mo_table.
    SET HANDLER on_double_click FOR mo_table.
    SET HANDLER on_link_click FOR mo_table.
  ENDMETHOD.

  METHOD on_added_function.
    BREAK developer.
    mo_app->on_table_added_function(
      iv_function = iv_function
      io_table    = me
    ).
  ENDMETHOD.

  METHOD on_after_function.
    BREAK developer.
    mo_app->on_table_after_function(
      iv_function = iv_function
      io_table    = me
    ).
  ENDMETHOD.

  METHOD on_before_function.
    BREAK developer.
    mo_app->on_table_before_function(
      iv_function = iv_function
      io_table    = me
    ).
  ENDMETHOD.

  METHOD on_double_click.
    BREAK developer.
    mo_app->on_table_double_click(
      iv_row    = iv_row
      iv_column = iv_column
      io_table  = me
    ).
  ENDMETHOD.

  METHOD on_link_click.
    BREAK developer.
    mo_app->on_table_link_click(
      iv_row    = iv_row
      iv_column = iv_column
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
    BREAK developer.
    ASSIGN mr_table->* TO <table>.

    TRY.
        mo_table = zcl_app_alv_table=>factory(
          EXPORTING
            io_parent         = get_parent( )
          CHANGING
            ct_table          = <table>
        ).

        mo_app->on_table_extension( me ).

        mo_table->display( ).
      CATCH zcx_app.
    ENDTRY.

    register_events( ).
  ENDMETHOD.
ENDCLASS.
