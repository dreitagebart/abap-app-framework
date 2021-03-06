CLASS zcl_app_container_tree DEFINITION
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
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_container_tree.

    METHODS:
      constructor
        IMPORTING
          iv_name TYPE string
          iv_side TYPE i DEFAULT mc_sides-custom,
      create_instance REDEFINITION,
      register_events REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mr_table TYPE REF TO data,
          mo_salv  TYPE REF TO cl_salv_tree.

    METHODS:
      on_after_function FOR EVENT after_salv_function OF cl_salv_events_tree
        IMPORTING
          e_salv_function
          sender,
      on_before_function FOR EVENT before_salv_function OF cl_salv_events_tree
        IMPORTING
          e_salv_function
          sender,
      on_added_function FOR EVENT added_function OF cl_salv_events_tree
        IMPORTING
          e_salv_function
          sender,
      on_link_click FOR EVENT link_click OF cl_salv_events_tree
        IMPORTING
          columnname
          node_key
          sender,
      on_checkbox_change FOR EVENT checkbox_change OF cl_salv_events_tree
        IMPORTING
          columnname
          checked
          node_key
          sender,
      on_double_click FOR EVENT double_click OF cl_salv_events_tree
        IMPORTING
          columnname
          node_key
          sender,
      on_expand_empty_folder FOR EVENT expand_empty_folder OF cl_salv_events_tree
        IMPORTING
          node_key
          sender,
      on_keypress FOR EVENT keypress OF cl_salv_events_tree
        IMPORTING
          columnname
          key
          node_key
          sender.

ENDCLASS.



CLASS zcl_app_container_tree IMPLEMENTATION.
  METHOD on_after_function.
    BREAK developer.
    mo_app->on_tree_after_function(
      iv_function = CONV #( e_salv_function )
      io_tree     = me
    ).
  ENDMETHOD.

  METHOD on_before_function.
    BREAK developer.
    mo_app->on_tree_before_function(
      iv_function = CONV #( e_salv_function )
      io_tree     = me
    ).
  ENDMETHOD.

  METHOD on_added_function.
    BREAK developer.
    mo_app->on_tree_added_function(
      iv_function = CONV #( e_salv_function )
      io_tree     = me
    ).
  ENDMETHOD.

  METHOD on_checkbox_change.
    BREAK developer.
    mo_app->on_tree_checkbox_change(
      iv_column  = CONV #( columnname )
      iv_checked = checked
      iv_node    = node_key
      io_tree    = me
    ).
  ENDMETHOD.

  METHOD on_double_click.
    BREAK developer.
    mo_app->on_tree_double_click(
      iv_column = CONV #( columnname )
      iv_node   = node_key
      io_tree   = me
    ).
  ENDMETHOD.

  METHOD on_expand_empty_folder.
    BREAK developer.
    mo_app->on_tree_expand_empty_folder(
      iv_node = node_key
      io_tree = me
    ).
  ENDMETHOD.

  METHOD on_keypress.
    BREAK developer.
    mo_app->on_tree_keypress(
      iv_column = CONV #( columnname )
      iv_key    = key
      iv_node   = node_key
      io_tree   = me
    ).
  ENDMETHOD.

  METHOD on_link_click.
    BREAK developer.
    mo_app->on_tree_link_click(
      iv_column = CONV #( columnname )
      iv_node   = node_key
      io_tree   = me
    ).
  ENDMETHOD.

  METHOD register_events.
    DATA(lo_event) = mo_salv->get_event( ).

    SET HANDLER on_after_function FOR lo_event.
    SET HANDLER on_before_function FOR lo_event.
    SET HANDLER on_added_function FOR lo_event.
    SET HANDLER on_checkbox_change FOR lo_event.
    SET HANDLER on_double_click FOR lo_event.
    SET HANDLER on_expand_empty_folder FOR lo_event.
    SET HANDLER on_keypress FOR lo_event.
    SET HANDLER on_link_click FOR lo_event.
  ENDMETHOD.

  METHOD create.
    ro_result = NEW zcl_app_container_tree(
      iv_name = iv_name
      iv_side = iv_side
    ).

    GET REFERENCE OF ct_table INTO ro_result->mr_table.
  ENDMETHOD.

  METHOD constructor.
    super->constructor(
      iv_name = iv_name
      iv_side = iv_side
    ).
  ENDMETHOD.

  METHOD create_instance.
    FIELD-SYMBOLS: <table> TYPE ANY TABLE.

    ASSIGN mr_table->* TO <table>.

    TRY.
        cl_salv_tree=>factory(
          EXPORTING
            r_container = get_parent( )
*           hide_header =                  " Do Not Show Header
          IMPORTING
            r_salv_tree = mo_salv                 " ALV: Tree Model
          CHANGING
            t_table     = <table>
        ).

        mo_salv->display( ).
      CATCH cx_salv_error. " ALV: General Error Class (Checked During Syntax Check)
    ENDTRY.

    register_events( ).
  ENDMETHOD.
ENDCLASS.
