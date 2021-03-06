CLASS zcl_app_dialog DEFINITION
  INHERITING FROM zca_app
  PUBLIC
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      init REDEFINITION,
      pai REDEFINITION,
      pbo REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_app_dialog IMPLEMENTATION.


  METHOD init.

  ENDMETHOD.


  METHOD pai.
    on_pai( sy-dynnr ).
  ENDMETHOD.


  METHOD pbo.
    DATA(lv_screen) = sy-dynnr.

    LOOP AT mt_dynpro_stack REFERENCE INTO DATA(lr_dynpro).
      IF lv_screen = lr_dynpro->*->mv_screen.
        DATA(lv_stack) = abap_true.

        DATA(lo_dynpro) = lr_dynpro->*.

        EXIT.
      ENDIF.
    ENDLOOP.

    IF lv_stack = abap_false.
      lo_dynpro = NEW zcl_app_dynpro(
        iv_screen  = lv_screen
        iv_program = get_program_name( )
      ).

      APPEND lo_dynpro TO mt_dynpro_stack.

      on_init( lo_dynpro ).

      LOOP AT mt_container REFERENCE INTO DATA(lr_container).
        IF lr_container->*->mo_parent IS NOT BOUND.
          lr_container->*->create_parent( ).
          lr_container->*->create_instance( ).
        ENDIF.
      ENDLOOP.
    ENDIF.

    on_pbo( lo_dynpro ).

    lo_dynpro->show_gui_status( ).
    lo_dynpro->show_title( ).
  ENDMETHOD.
ENDCLASS.
