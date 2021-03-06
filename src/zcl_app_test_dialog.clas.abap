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
        io_dynpro->add_button(
          EXPORTING
            iv_button             = io_dynpro->mo_gui->b_01
            iv_text               = 'Hallo Welt'
            iv_icon               = icon_cancel
*    iv_quickinfo          =
*    iv_allowed            = abap_true
*  EXCEPTIONS
*    button_already_filled = 1
*    button_does_not_exist = 2
*    icon_and_text_empty   = 3
*    others                = 4
        ).

        IF sy-subrc <> 0.
          MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
        ENDIF.
    ENDCASE.
  ENDMETHOD.

  METHOD on_pai.

  ENDMETHOD.

  METHOD on_pbo.

  ENDMETHOD.
ENDCLASS.
