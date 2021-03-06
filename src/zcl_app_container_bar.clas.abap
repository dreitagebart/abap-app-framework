CLASS zcl_app_container_bar DEFINITION
  PUBLIC
  INHERITING FROM zca_app_container
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      create REDEFINITION,
      constructor
        IMPORTING
          iv_name TYPE string
          iv_side TYPE i DEFAULT mc_sides-custom,
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

ENDCLASS.



CLASS zcl_app_container_bar IMPLEMENTATION.
  METHOD constructor.
    super->constructor(
      iv_name = iv_name
      iv_side = iv_side
    ).
  ENDMETHOD.

  METHOD add_container.
    APPEND VALUE sbptcaptn(
      caption      = iv_title
      icon         = iv_icon
      no_close     = abap_true
      name         = io_container->get_name( )
*      invisible    =
*      pre_inst     =
*      reuse_cnt_of =
    ) TO mt_captions.

    APPEND io_container TO mt_children.
  ENDMETHOD.

  METHOD create.
    mo_bar = NEW cl_gui_container_bar_xt(
*      active_id     =
       captions      = mt_captions
       parent        = get_parent( )
*      style         = c_style_outlook
*      close_buttons = space
    ).

    LOOP AT mt_children REFERENCE INTO DATA(lr_child).
      lr_child->*->create( ).
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
