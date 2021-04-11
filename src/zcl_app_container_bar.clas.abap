CLASS zcl_app_container_bar DEFINITION
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
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_container_bar.

    METHODS:
      create_instance REDEFINITION,
      register_events REDEFINITION,
      add_container
        IMPORTING
          iv_title     TYPE string
          iv_icon      TYPE icon_d
          iv_close     TYPE abap_bool DEFAULT abap_false
          io_container TYPE REF TO zca_app_container,
      get_active
        RETURNING VALUE(rv_result) TYPE string,
      get_container
        IMPORTING
                  iv_name          TYPE string
        RETURNING VALUE(ro_result) TYPE REF TO zca_app_container
        RAISING   zcx_app,
      remove
        IMPORTING
          iv_name TYPE string,
      set_active
        IMPORTING
          iv_name TYPE string,
      set_close
        IMPORTING
          iv_name  TYPE string
          iv_close TYPE abap_bool DEFAULT abap_true,
      set_title
        IMPORTING
          iv_name  TYPE string
          iv_title TYPE string.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mt_children TYPE tt_children,
          mt_captions TYPE sbptcaptns,
          mo_bar      TYPE REF TO cl_gui_container_bar_xt.

    METHODS: constructor
      IMPORTING
        iv_name TYPE string
        iv_side TYPE i DEFAULT mc_sides-custom,
      on_click FOR EVENT clicked OF cl_gui_container_bar_xt
        IMPORTING
          id
          container
          sender,
      on_empty FOR EVENT empty OF cl_gui_container_bar_xt
        IMPORTING
          sender,
      on_close FOR EVENT closed OF cl_gui_container_bar_xt
        IMPORTING
          id
          sender.

ENDCLASS.



CLASS zcl_app_container_bar IMPLEMENTATION.
  METHOD constructor.
    super->constructor(
      iv_name = iv_name
      iv_side = iv_side
    ).
  ENDMETHOD.

  METHOD register_events.
    SET HANDLER on_close FOR mo_bar.
    SET HANDLER on_click FOR mo_bar.
    SET HANDLER on_empty FOR mo_bar.
  ENDMETHOD.

  METHOD set_title.
    LOOP AT mt_captions REFERENCE INTO DATA(lr_caption) WHERE name = iv_name.
      DATA(lv_id) = sy-tabix.

      lr_caption->caption = iv_title.

      mo_bar->set_cell_caption(
        id                  = lv_id
        caption             = lr_caption->*
      ).
    ENDLOOP.
  ENDMETHOD.

  METHOD add_container.
    APPEND INITIAL LINE TO mt_captions REFERENCE INTO DATA(lr_caption).
    lr_caption->caption      = iv_title.
    lr_caption->icon         = iv_icon.
    lr_caption->no_close     = SWITCH #( iv_close WHEN abap_false THEN abap_true ELSE abap_false ).
    lr_caption->name         = io_container->get_name( ).
    lr_caption->invisible    = abap_false.
    lr_caption->pre_inst     = abap_false.
    lr_caption->reuse_cnt_of = ''.

    APPEND io_container TO mt_children.

    IF mo_bar IS BOUND.
      mo_bar->add_cell( lr_caption->* ).
    ENDIF.
  ENDMETHOD.

  METHOD set_active.
    LOOP AT mt_captions REFERENCE INTO DATA(lr_caption) WHERE name = iv_name.
      DATA(lv_id) = sy-tabix.

      mo_bar->set_active( lv_id ).
    ENDLOOP.
  ENDMETHOD.

  METHOD set_close.
    LOOP AT mt_captions REFERENCE INTO DATA(lr_caption) WHERE name = iv_name.
      DATA(lv_id) = sy-tabix.

      lr_caption->no_close = SWITCH #( iv_close WHEN abap_true THEN abap_false ELSE abap_true ).

      mo_bar->set_cell_caption(
        id                  = lv_id
        caption             = lr_caption->*
      ).
    ENDLOOP.
  ENDMETHOD.

  METHOD remove.
    LOOP AT mt_captions REFERENCE INTO DATA(lr_caption) WHERE name = iv_name.
      DATA(lv_id) = sy-tabix.

      mo_bar->remove_cell( lv_id ).
    ENDLOOP.

    TRY.
        DATA(lo_container) = mt_children[ lv_id ].
        DATA(lo_parent) = lo_container->get_parent( ).
        lo_parent->free( ).
        CLEAR lo_parent.
        CLEAR lo_container.
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.

  METHOD get_active.
    mo_bar->get_active(
      IMPORTING
        id = DATA(lv_id)
    ).

    TRY.
        rv_result = mt_children[ lv_id ]->get_name( ).
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.

  METHOD on_click.
    mo_app->debug( ).
    mo_app->on_bar_click(
      iv_id        = id
      io_container = container
      io_bar       = me
    ).
  ENDMETHOD.

  METHOD on_close.
    mo_app->debug( ).
    mo_app->on_bar_close(
      iv_id  = id
      io_bar = me
    ).
  ENDMETHOD.

  METHOD on_empty.
    mo_app->debug( ).
    mo_app->on_bar_empty( me ).
  ENDMETHOD.

  METHOD create.
    ro_result = NEW zcl_app_container_bar(
      iv_name = iv_name
      iv_side = iv_side
    ).
  ENDMETHOD.

  METHOD create_instance.
    mo_bar = NEW cl_gui_container_bar_xt(
      active_id     = 1
      captions      = mt_captions
      parent        = get_parent( )
      style         = cl_gui_container_bar_xt=>c_style_fix
      close_buttons = abap_true
    ).

    register_events( ).

    LOOP AT mt_children REFERENCE INTO DATA(lr_child).
      TRY.
          DATA(lr_caption) = REF #( mt_captions[ name = lr_child->*->get_name( ) ] ).

          DATA(lv_id) = sy-tabix.
        CATCH cx_sy_itab_line_not_found.
      ENDTRY.

      lr_child->*->mo_parent = mo_bar->get_container( lv_id ).

      lr_child->*->create_instance( ).
    ENDLOOP.
  ENDMETHOD.

  METHOD get_container.
    TRY.
        DATA(lr_caption) = REF #( mt_captions[ name = iv_name ] ).

        LOOP AT mt_children REFERENCE INTO DATA(lr_child).
          IF lr_child->*->get_name( ) = iv_name.
            ro_result = lr_child->*.
          ENDIF.
        ENDLOOP.
      CATCH cx_sy_itab_line_not_found.
        RAISE EXCEPTION TYPE zcx_app
          MESSAGE e011 WITH iv_name.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
