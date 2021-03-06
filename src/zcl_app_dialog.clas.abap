CLASS zcl_app_dialog DEFINITION
  INHERITING FROM zca_app
  PUBLIC
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      init REDEFINITION,
      pai REDEFINITION,
      on_poh REDEFINITION,
      on_pov REDEFINITION,
      pbo REDEFINITION,
      poh REDEFINITION,
      pov REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_app_dialog IMPLEMENTATION.
  METHOD init.

  ENDMETHOD.

  METHOD on_poh.

  ENDMETHOD.

  METHOD on_pov.

  ENDMETHOD.

  METHOD pov.
    DATA(lv_screen) = sy-dynnr.

    LOOP AT mt_dynpro_stack REFERENCE INTO DATA(lr_dynpro).
      IF lv_screen = lr_dynpro->*->mv_screen.
        DATA(lv_stack) = abap_true.

        mo_dynpro = lr_dynpro->*.

        EXIT.
      ENDIF.
    ENDLOOP.

    IF lv_stack = abap_true.
      on_pov( mo_dynpro ).
    ENDIF.
  ENDMETHOD.

  METHOD poh.
    DATA(lv_screen) = sy-dynnr.

    LOOP AT mt_dynpro_stack REFERENCE INTO DATA(lr_dynpro).
      IF lv_screen = lr_dynpro->*->mv_screen.
        DATA(lv_stack) = abap_true.

        mo_dynpro = lr_dynpro->*.

        EXIT.
      ENDIF.
    ENDLOOP.

    IF lv_stack = abap_true.
      on_poh( mo_dynpro ).
    ENDIF.
  ENDMETHOD.

  METHOD pai.
    on_pai( mo_dynpro ).
  ENDMETHOD.

  METHOD pbo.
    DATA(lv_screen) = sy-dynnr.

    LOOP AT mt_dynpro_stack REFERENCE INTO DATA(lr_dynpro).
      IF lv_screen = lr_dynpro->*->mv_screen.
        DATA(lv_stack) = abap_true.

        mo_dynpro = lr_dynpro->*.

        EXIT.
      ENDIF.
    ENDLOOP.

    IF lv_stack = abap_false.
      mo_dynpro = NEW zcl_app_dynpro(
        iv_screen  = lv_screen
        iv_program = get_program_name( )
      ).

      APPEND mo_dynpro TO mt_dynpro_stack.

      on_init( mo_dynpro ).

      LOOP AT mt_container REFERENCE INTO DATA(lr_container).
        IF lr_container->*->mo_parent IS NOT BOUND.
          lr_container->*->create_parent( ).
          lr_container->*->create_instance( ).
        ENDIF.
      ENDLOOP.
    ENDIF.

    on_pbo( mo_dynpro ).

    mo_dynpro->show_gui_status( ).
    mo_dynpro->show_title( ).
  ENDMETHOD.
ENDCLASS.
