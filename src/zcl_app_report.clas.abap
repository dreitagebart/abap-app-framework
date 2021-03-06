CLASS zcl_app_report DEFINITION
  INHERITING FROM zca_app
  ABSTRACT
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      init REDEFINITION,
      pai REDEFINITION,
      pbo REDEFINITION,
      set_selscreen
        CHANGING
          cs_data TYPE any,
      set_output
        CHANGING
          ct_data TYPE any,
      setup_selscreen ABSTRACT,
      setup_output ABSTRACT,
      selection_get_data ABSTRACT,
      start_of_selection.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mr_output    TYPE REF TO data,
          mo_selscreen TYPE REF TO zcl_app_selscreen.

ENDCLASS.



CLASS zcl_app_report IMPLEMENTATION.
  METHOD init.
    setup_selscreen( ).
    setup_output( ).
  ENDMETHOD.

  METHOD pai.
    mo_selscreen->get_selscreen_data( ).

    on_pai( sy-dynnr ).
  ENDMETHOD.

  METHOD set_output.
    DATA(lo_type) = cl_abap_datadescr=>describe_by_data( ct_data ).

    CASE lo_type->kind.
      WHEN lo_type->kind_table.
        DATA(lo_table) = CAST cl_abap_tabledescr( lo_type ).

        GET REFERENCE OF ct_data INTO mr_output.
      WHEN OTHERS.
        MESSAGE a005 DISPLAY LIKE 'E'.
    ENDCASE.
  ENDMETHOD.

  METHOD set_selscreen.
    DATA lr_ref TYPE REF TO data.

    GET REFERENCE OF cs_data INTO lr_ref.

    TRY.
        mo_selscreen = NEW #(
                         ir_data = lr_ref
                         iv_program = get_program_name( )
                       ).
      CATCH zcx_app INTO DATA(lx_error).
        MESSAGE lx_error.
    ENDTRY.
  ENDMETHOD.

  METHOD pbo.
    mo_selscreen->get_selscreen_data( ).

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

  METHOD start_of_selection.
    selection_get_data( ).
  ENDMETHOD.
ENDCLASS.
