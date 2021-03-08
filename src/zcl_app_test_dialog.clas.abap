CLASS zcl_app_test_dialog DEFINITION
  PUBLIC
  INHERITING FROM zcl_app_dialog
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      on_init REDEFINITION,
      on_pbo REDEFINITION,
      on_pai REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_app_test_dialog IMPLEMENTATION.
  METHOD on_init.
    CASE io_dynpro->get_screen( ).
      WHEN 1000.
        TRY.
            io_dynpro->add_button(
              iv_button             = io_dynpro->mc_buttons-button10
              iv_text               = 'Hallo Welt'
              iv_icon               = icon_cancel
              iv_quickinfo          = 'Hallo Welt'
            ).
          CATCH zcx_app INTO DATA(lx_error).
            MESSAGE lx_error.
        ENDTRY.
    ENDCASE.
  ENDMETHOD.

  METHOD on_pai.
    CASE io_dynpro->get_screen( ).
      WHEN 1000.
        CASE io_dynpro->reduce_command( ).
          WHEN io_dynpro->mc_commands-back
            OR io_dynpro->mc_commands-exit
            OR io_dynpro->mc_commands-cancel.
            LEAVE PROGRAM.
          WHEN io_dynpro->mc_buttons-button10.
            call_modal( '2000' ).
        ENDCASE.
      WHEN 2000.
        CASE io_dynpro->reduce_command( ).
          WHEN io_dynpro->mc_commands-back
            OR io_dynpro->mc_commands-exit
            OR io_dynpro->mc_commands-cancel.
            LEAVE TO SCREEN 0.
        ENDCASE.
    ENDCASE.
  ENDMETHOD.

  METHOD on_pbo.

  ENDMETHOD.
ENDCLASS.
