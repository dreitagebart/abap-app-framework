CLASS zcl_app_dynpro DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zcl_app_report
                 zcl_app_dialog.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_screen  TYPE sydynnr
          iv_program TYPE syrepid,
      get_screen
        RETURNING VALUE(rv_result) TYPE sydynnr,
      set_title
        IMPORTING
          iv_title TYPE string,
      add_button
        IMPORTING
          iv_button    TYPE syucomm
          iv_text      TYPE smp_dyntxt-text OPTIONAL
          iv_icon      TYPE smp_dyntxt-icon_id OPTIONAL
          iv_quickinfo TYPE smp_dyntxt-quickinfo OPTIONAL
          iv_allowed   TYPE abap_bool DEFAULT abap_true
        EXCEPTIONS
          button_already_filled
          button_does_not_exist
          icon_and_text_empty,
      hide_button
        IMPORTING
          iv_button TYPE syucomm,
      show_button
        IMPORTING
          iv_button TYPE syucomm,
      get_toolbar
        RETURNING VALUE(rs_result) TYPE zcl_app_gui_status=>ts_button,
      add_separator
        IMPORTING
          iv_button TYPE syucomm.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mv_screen  TYPE sydynnr,
          mv_program TYPE syrepid,
          mv_title   TYPE string,
          mo_gui     TYPE REF TO zcl_app_gui_status.

    METHODS:
      show_title,
      show_gui_status.

ENDCLASS.



CLASS zcl_app_dynpro IMPLEMENTATION.
  METHOD set_title.
    mv_title = iv_title.
  ENDMETHOD.

  METHOD get_screen.
    rv_result = mv_screen.
  ENDMETHOD.

  METHOD constructor.
    mv_screen = iv_screen.
    mv_program = iv_program.

    SELECT SINGLE text FROM trdirt INTO @mv_title WHERE sprsl = @sy-langu
                                                    AND name  = @mv_program.

    mo_gui = NEW zcl_app_gui_status( ).
  ENDMETHOD.

  METHOD add_button.
    mo_gui->add_button(
      EXPORTING
        iv_button             = iv_button
        iv_text               = iv_text
        iv_icon               = iv_icon
        iv_quickinfo          = iv_quickinfo
        iv_allowed            = iv_allowed
      EXCEPTIONS
        button_already_filled = 1
        button_does_not_exist = 2
        icon_and_text_empty   = 3
        OTHERS                = 4
    ).

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.

  METHOD add_separator.
    mo_gui->add_separator( iv_button ).
  ENDMETHOD.

  METHOD get_toolbar.
    rs_result = mo_gui->get_toolbar( ).
  ENDMETHOD.

  METHOD hide_button.
    mo_gui->hide_button( iv_button ).
  ENDMETHOD.

  METHOD show_button.
    mo_gui->show_button( iv_button ).
  ENDMETHOD.

  METHOD show_gui_status.
    mo_gui->show_gui_status( ).
  ENDMETHOD.

  METHOD show_title.
    mo_gui->show_title( mv_title ).
  ENDMETHOD.
ENDCLASS.
