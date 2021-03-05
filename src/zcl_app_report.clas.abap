CLASS zcl_app_report DEFINITION
  INHERITING FROM zca_app
  ABSTRACT
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      pai REDEFINITION,
      pbo REDEFINITION,
      setup_selscreen ABSTRACT,
      setup_output ABSTRACT,
      selection_get_data ABSTRACT,
      start_of_selection.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_app_report IMPLEMENTATION.
  METHOD pai.
    on_pai( sy-dynnr ).
  ENDMETHOD.

  METHOD pbo.
    DATA(lv_screen) = sy-dynnr.

    LOOP AT mt_dynpro_stack REFERENCE INTO DATA(lr_dynpro).
      IF lv_screen = lr_dynpro->*->mv_screen.
        DATA(lv_stack) = abap_true.

        EXIT.
      ENDIF.
    ENDLOOP.

    IF lv_stack = abap_false.
      DATA(lo_dynpro) = NEW zcl_app_dynpro(
        iv_screen  = lv_screen
        iv_program = get_program_name( )
      ).

      on_init( lv_screen ).
    ENDIF.

    on_pbo( lv_screen ).
  ENDMETHOD.

  METHOD start_of_selection.
    selection_get_data( ).
  ENDMETHOD.
ENDCLASS.
