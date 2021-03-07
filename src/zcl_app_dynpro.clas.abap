CLASS zcl_app_dynpro DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zcl_app_report
                 zcl_app_dialog.

  PUBLIC SECTION.
    CONSTANTS: BEGIN OF mc_commands,
                 enter         TYPE syucomm VALUE 'ENTER',
                 back          TYPE syucomm VALUE 'BACK',
                 exit          TYPE syucomm VALUE 'EXIT',
                 cancel        TYPE syucomm VALUE 'CANCEL',
                 save          TYPE syucomm VALUE 'SAVE',
                 print         TYPE syucomm VALUE 'PRINT',
                 find          TYPE syucomm VALUE 'FIND',
                 find_more     TYPE syucomm VALUE 'FIND_MORE',
                 first_page    TYPE syucomm VALUE 'FIRST_PAGE',
                 previous_page TYPE syucomm VALUE 'PREV_PAGE',
                 next_page     TYPE syucomm VALUE 'NEXT_PAGE',
                 last_page     TYPE syucomm VALUE 'LAST_PAGE',
                 new_mode      TYPE syucomm VALUE 'NEW_MODE',
               END OF mc_commands,

               BEGIN OF mc_buttons,
                 button1  TYPE sy-ucomm VALUE 'F01',
                 button2  TYPE sy-ucomm VALUE 'F02',
                 button3  TYPE sy-ucomm VALUE 'F03',
                 button4  TYPE sy-ucomm VALUE 'F04',
                 button5  TYPE sy-ucomm VALUE 'F05',
                 button6  TYPE sy-ucomm VALUE 'F06',
                 button7  TYPE sy-ucomm VALUE 'F07',
                 button8  TYPE sy-ucomm VALUE 'F08',
                 button9  TYPE sy-ucomm VALUE 'F09',
                 button10 TYPE sy-ucomm VALUE 'F10',
                 button11 TYPE sy-ucomm VALUE 'F11',
                 button12 TYPE sy-ucomm VALUE 'F12',
                 button13 TYPE sy-ucomm VALUE 'F13',
                 button14 TYPE sy-ucomm VALUE 'F14',
                 button15 TYPE sy-ucomm VALUE 'F15',
                 button16 TYPE sy-ucomm VALUE 'F16',
                 button17 TYPE sy-ucomm VALUE 'F17',
                 button18 TYPE sy-ucomm VALUE 'F18',
                 button19 TYPE sy-ucomm VALUE 'F19',
                 button20 TYPE sy-ucomm VALUE 'F20',
                 button21 TYPE sy-ucomm VALUE 'F21',
                 button22 TYPE sy-ucomm VALUE 'F22',
                 button23 TYPE sy-ucomm VALUE 'F23',
                 button24 TYPE sy-ucomm VALUE 'F24',
                 button25 TYPE sy-ucomm VALUE 'F25',
               END OF mc_buttons.

    METHODS:
      constructor
        IMPORTING
          iv_screen  TYPE sydynnr
          iv_program TYPE syrepid,
      is_selscreen
        RETURNING VALUE(rv_result) TYPE abap_bool,
      is_modal
        RETURNING VALUE(rv_result) TYPE abap_bool,
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
        RAISING   zcx_app,
      hide_button
        IMPORTING
          iv_button TYPE syucomm,
      reduce_command
        RETURNING VALUE(rv_result) TYPE syucomm,
      show_button
        IMPORTING
          iv_button TYPE syucomm,
      get_toolbar
        RETURNING VALUE(rs_result) TYPE zcl_app_gui_status=>ts_button,
      add_separator
        IMPORTING
                  iv_button TYPE syucomm
        RAISING   zcx_app.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mv_screen       TYPE sydynnr,
          mv_program      TYPE syrepid,
          mv_title        TYPE string,
          mv_is_modal     TYPE abap_bool,
          mv_is_selscreen TYPE abap_bool,
          mo_gui          TYPE REF TO zcl_app_gui_status.

    METHODS:
      show_title,
      show_gui_status.

ENDCLASS.



CLASS zcl_app_dynpro IMPLEMENTATION.
  METHOD is_modal.
    rv_result = mv_is_modal.
  ENDMETHOD.

  METHOD is_selscreen.
    rv_result = mv_is_selscreen.
  ENDMETHOD.

  METHOD reduce_command.
    rv_result = sy-ucomm.

    CLEAR sy-ucomm.
  ENDMETHOD.

  METHOD set_title.
    mv_title = iv_title.
  ENDMETHOD.

  METHOD get_screen.
    rv_result = mv_screen.
  ENDMETHOD.

  METHOD constructor.
    DATA: lt_fields      TYPE TABLE OF d021s,
          lt_screen_flow TYPE TABLE OF d022s,
          ls_header      TYPE d020s.

    mv_screen = iv_screen.
    mv_program = iv_program.

    SELECT SINGLE text FROM trdirt INTO @mv_title WHERE sprsl = @sy-langu
                                                    AND name  = @mv_program.

    SELECT SINGLE type FROM d020s INTO @DATA(lv_type) WHERE prog = @mv_program
                                                        AND dnum = @mv_screen.

    IF sy-subrc = 0.
      CASE lv_type.
        WHEN 'M'.
          mv_is_modal = abap_true.
        WHEN 'S'.
          mv_is_selscreen = abap_true.
      ENDCASE.
    ENDIF.

    mo_gui = NEW zcl_app_gui_status( ).
  ENDMETHOD.

  METHOD add_button.
    TRY.
        mo_gui->add_button(
          iv_button             = iv_button
          iv_text               = iv_text
          iv_icon               = iv_icon
          iv_quickinfo          = iv_quickinfo
          iv_allowed            = iv_allowed
        ).
      CATCH zcx_app INTO DATA(lx_error).
        RAISE EXCEPTION lx_error.
    ENDTRY.
  ENDMETHOD.

  METHOD add_separator.
    TRY.
        mo_gui->add_separator( iv_button ).
      CATCH zcx_app INTO DATA(lx_error).
        RAISE EXCEPTION lx_error.
    ENDTRY.
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
    CHECK mv_is_selscreen = abap_false.

    mo_gui->show_gui_status( mv_is_modal ).
  ENDMETHOD.

  METHOD show_title.
    mo_gui->show_title( mv_title ).
  ENDMETHOD.
ENDCLASS.
