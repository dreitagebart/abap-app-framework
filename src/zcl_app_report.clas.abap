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
      extend_output
        IMPORTING
          io_table TYPE REF TO zcl_app_alv_table,
      check_selection ABSTRACT
        RETURNING VALUE(rv_skip) TYPE abap_bool,
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
          mo_alv       TYPE REF TO zcl_app_alv_table,
          mo_selscreen TYPE REF TO zcl_app_selscreen.

    METHODS:
      call_output_screen,
      create_output.

ENDCLASS.



CLASS zcl_app_report IMPLEMENTATION.
  METHOD extend_output.

  ENDMETHOD.

  METHOD create_output.
    FIELD-SYMBOLS: <output> TYPE ANY TABLE.


    ASSIGN mr_output->* TO <output>.

    TRY.
        mo_alv = zcl_app_alv_table=>factory(
                   EXPORTING
                     io_parent = cl_gui_container=>default_screen
                   CHANGING
                     ct_table          = <output>
                 ).

        extend_output( mo_alv ).

        mo_alv->display( ).
      CATCH zcx_app.
    ENDTRY.
  ENDMETHOD.

  METHOD init.
    setup_selscreen( ).
    setup_output( ).
  ENDMETHOD.

  METHOD pai.
    mo_selscreen->get_selscreen_data( ).

    IF  mo_dynpro->is_selscreen( )
    AND sy-ucomm = 'ONLI'
    AND check_selection( ) = abap_true.
      LEAVE SCREEN.
    ENDIF.

    on_pai( mo_dynpro ).
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

  METHOD call_output_screen.
    CALL FUNCTION 'Z_APP_DISPLAY_OUTPUT'
      EXPORTING
        io_app = me.
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

      IF lv_screen = 2000.
        create_output( ).
      ENDIF.
    ENDIF.

    on_pbo( mo_dynpro ).

    mo_dynpro->show_gui_status( ).
    mo_dynpro->show_title( ).
  ENDMETHOD.

  METHOD start_of_selection.
    selection_get_data( ).
    call_output_screen( ).
  ENDMETHOD.
ENDCLASS.
