CLASS zca_app DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_app_report
                 zcl_app_dialog.

  PUBLIC SECTION.
    TYPES: BEGIN OF ts_customizing,
             app_type      TYPE zapp_cust-app_type,
             app_name      TYPE zapp_cust-app_name,
             class_name    TYPE zapp_cust-class_name,
             message_class TYPE zapp_cust-message_class,
             program_name  TYPE zapp_cust-program_name,
           END OF ts_customizing,

           tt_container    TYPE TABLE OF REF TO zca_app_container,
           tt_dynpro_stack TYPE TABLE OF REF TO zcl_app_dynpro.

    CLASS-METHODS:
      get
        RETURNING VALUE(ro_result) TYPE REF TO zca_app.

    METHODS:
      on_table_double_click
        IMPORTING
          iv_row    TYPE int4
          iv_column TYPE string
          io_table  TYPE REF TO zcl_app_container_table,
      on_table_link_click
        IMPORTING
          iv_row    TYPE int4
          iv_column TYPE string
          io_table  TYPE REF TO zcl_app_container_table,
      on_table_added_function
        IMPORTING
          iv_function TYPE string
          io_table    TYPE REF TO zcl_app_container_table,
      on_table_before_function
        IMPORTING
          iv_function TYPE string
          io_table    TYPE REF TO zcl_app_container_table,
      on_table_after_function
        IMPORTING
          iv_function TYPE string
          io_table    TYPE REF TO zcl_app_container_table,
      on_tree_after_function
        IMPORTING
          iv_function TYPE string
          io_tree     TYPE REF TO zcl_app_container_tree,
      on_tree_before_function
        IMPORTING
          iv_function TYPE string
          io_tree     TYPE REF TO zcl_app_container_tree,
      on_tree_added_function
        IMPORTING
          iv_function TYPE string
          io_tree     TYPE REF TO zcl_app_container_tree,
      on_tree_checkbox_change
        IMPORTING
          iv_column  TYPE string
          iv_checked TYPE abap_bool
          iv_node    TYPE salv_de_node_key
          io_tree    TYPE REF TO zcl_app_container_tree,
      on_tree_double_click
        IMPORTING
          iv_column TYPE string
          iv_node   TYPE salv_de_node_key
          io_tree   TYPE REF TO zcl_app_container_tree,
      on_tree_expand_empty_folder
        IMPORTING
          iv_node TYPE salv_de_node_key
          io_tree TYPE REF TO zcl_app_container_tree,
      on_tree_keypress
        IMPORTING
          iv_column TYPE string
          iv_key    TYPE int4
          iv_node   TYPE salv_de_node_key
          io_tree   TYPE REF TO zcl_app_container_tree,
      on_tree_link_click
        IMPORTING
          iv_column TYPE string
          iv_node   TYPE salv_de_node_key
          io_tree   TYPE REF TO zcl_app_container_tree,
      on_bar_close
        IMPORTING
          iv_id  TYPE int4
          io_bar TYPE REF TO zcl_app_container_bar,
      on_bar_click
        IMPORTING
          iv_id        TYPE int4
          io_container TYPE REF TO cl_gui_container
          io_bar       TYPE REF TO zcl_app_container_bar,
      on_bar_empty
        IMPORTING
          io_bar TYPE REF TO zcl_app_container_bar,
      add_container
        IMPORTING
          io_container TYPE REF TO zca_app_container,
      get_container
        IMPORTING
                  iv_name          TYPE string
        RETURNING VALUE(ro_result) TYPE REF TO zca_app_container
        RAISING   zcx_app,
      get_message_class
        RETURNING VALUE(rv_result) TYPE ts_customizing-message_class,
      get_program_name
        RETURNING VALUE(rv_result) TYPE ts_customizing-program_name,
      get_class_name
        RETURNING VALUE(rv_result) TYPE ts_customizing-class_name,
      get_app_type
        RETURNING VALUE(rv_result) TYPE ts_customizing-app_type,
      get_app_name
        RETURNING VALUE(rv_result) TYPE ts_customizing-app_name,
      get_customizing
        RETURNING VALUE(rs_result) TYPE ts_customizing,
      on_pai ABSTRACT
        IMPORTING
          iv_screen TYPE sydynnr,
      on_pbo ABSTRACT
        IMPORTING
          io_dynpro TYPE REF TO zcl_app_dynpro,
      on_init ABSTRACT
        IMPORTING
          io_dynpro TYPE REF TO zcl_app_dynpro,
      init ABSTRACT,
      pai ABSTRACT,
      pbo ABSTRACT.

  PROTECTED SECTION.
    DATA: mt_dynpro_stack TYPE tt_dynpro_stack,
          mt_container    TYPE tt_container.

  PRIVATE SECTION.

    CLASS-DATA: mo_app TYPE REF TO zca_app.

    CLASS-METHODS:
      create_app
        RAISING zcx_app,
      check_customizing
        RETURNING VALUE(rs_result) TYPE ts_customizing
        RAISING   zcx_app.

    DATA: ms_customizing  TYPE ts_customizing.

    METHODS:
      constructor
        IMPORTING
          is_customizing TYPE ts_customizing.

ENDCLASS.



CLASS zca_app IMPLEMENTATION.
  METHOD on_bar_click.

  ENDMETHOD.

  METHOD on_bar_close.

  ENDMETHOD.

  METHOD on_bar_empty.

  ENDMETHOD.

  METHOD on_table_added_function.

  ENDMETHOD.

  METHOD on_table_after_function.

  ENDMETHOD.

  METHOD on_table_before_function.

  ENDMETHOD.

  METHOD on_table_double_click.

  ENDMETHOD.

  METHOD on_table_link_click.

  ENDMETHOD.

  METHOD check_customizing.
    SELECT SINGLE app_type,
                  app_name,
                  class_name,
                  message_class,
                  program_name FROM zapp_cust INTO @rs_result WHERE program_name = @sy-cprog.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_app
        MESSAGE e000 WITH sy-cprog.
    ENDIF.

    IF rs_result-message_class IS INITIAL.
      RAISE EXCEPTION TYPE zcx_app
        MESSAGE e001.
    ENDIF.

    SELECT SINGLE arbgb FROM t100a INTO @DATA(lv_message_class) WHERE arbgb = @rs_result-message_class.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_app
        MESSAGE e002 WITH rs_result-message_class.
    ENDIF.

    IF rs_result-class_name IS INITIAL.
      RAISE EXCEPTION TYPE zcx_app
        MESSAGE e003.
    ENDIF.

    SELECT SINGLE clsname FROM seoclass INTO @DATA(lv_class_name) WHERE clsname = @rs_result-class_name.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_app
        MESSAGE e004 WITH rs_result-class_name.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.
    ms_customizing = is_customizing.
  ENDMETHOD.

  METHOD create_app.
    TRY.
        DATA(ls_customizing) = check_customizing( ).
      CATCH zcx_app INTO DATA(lx_error).
        RAISE EXCEPTION lx_error.
    ENDTRY.

    CREATE OBJECT mo_app TYPE (ls_customizing-class_name)
      EXPORTING
        is_customizing = ls_customizing.

    mo_app->init( ).
  ENDMETHOD.

  METHOD add_container.
    io_container->mo_app = me.

    APPEND io_container TO mt_container.
  ENDMETHOD.

  METHOD get_container.
    LOOP AT mt_container REFERENCE INTO DATA(lr_container).
      IF lr_container->*->mv_name = iv_name.
        ro_result = lr_container->*.
        EXIT.
      ENDIF.
    ENDLOOP.

    IF ro_result IS NOT BOUND.
      RAISE EXCEPTION TYPE zcx_app
        MESSAGE e000 WITH iv_name.
    ENDIF.
  ENDMETHOD.

  METHOD get.
    IF mo_app IS NOT BOUND.
      TRY.
          create_app( ).
        CATCH zcx_app INTO DATA(lx_error).
          MESSAGE lx_error.
      ENDTRY.
    ENDIF.

    ro_result = mo_app.
  ENDMETHOD.

  METHOD get_app_name.
    rv_result = ms_customizing-app_name.
  ENDMETHOD.

  METHOD get_app_type.
    rv_result = ms_customizing-app_type.
  ENDMETHOD.

  METHOD get_class_name.
    rv_result = ms_customizing-class_name.
  ENDMETHOD.

  METHOD get_customizing.
    rs_result = ms_customizing.
  ENDMETHOD.

  METHOD get_message_class.
    rv_result = ms_customizing-message_class.
  ENDMETHOD.

  METHOD get_program_name.
    rv_result = ms_customizing-program_name.
  ENDMETHOD.

  METHOD on_tree_added_function.

  ENDMETHOD.

  METHOD on_tree_after_function.

  ENDMETHOD.

  METHOD on_tree_before_function.

  ENDMETHOD.

  METHOD on_tree_checkbox_change.

  ENDMETHOD.

  METHOD on_tree_double_click.

  ENDMETHOD.

  METHOD on_tree_expand_empty_folder.

  ENDMETHOD.

  METHOD on_tree_keypress.

  ENDMETHOD.

  METHOD on_tree_link_click.

  ENDMETHOD.
ENDCLASS.
