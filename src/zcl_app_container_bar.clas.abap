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
          io_container TYPE REF TO zca_app_container,
      get_container
        IMPORTING
                  iv_name          TYPE string
        RETURNING VALUE(ro_result) TYPE REF TO zca_app_container
        RAISING   zcx_app.

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

  METHOD add_container.
    APPEND VALUE sbptcaptn(
      caption      = iv_title
      icon         = iv_icon
      no_close     = abap_false
      name         = io_container->get_name( )
      invisible    = abap_false
      pre_inst     = abap_false
      reuse_cnt_of = ''
    ) TO mt_captions.

    APPEND io_container TO mt_children.
  ENDMETHOD.

  METHOD on_click.
    BREAK developer.
    mo_app->on_bar_click(
      iv_id        = id
      io_container = container
      io_bar       = me
    ).
  ENDMETHOD.

  METHOD on_close.
    BREAK developer.
    mo_app->on_bar_close(
      iv_id  = id
      io_bar = me
    ).
  ENDMETHOD.

  METHOD on_empty.
    BREAK developer.
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

        LOOP AT mt_children REFERENCE INTO DATA(lr_children).
          IF lr_children->*->get_name( ) = iv_name.
            ro_result = lr_children->*.
          ENDIF.
        ENDLOOP.
      CATCH cx_sy_itab_line_not_found.
        RAISE EXCEPTION TYPE zcx_app
          MESSAGE e011 WITH iv_name.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
