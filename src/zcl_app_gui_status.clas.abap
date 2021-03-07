CLASS zcl_app_gui_status DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES: if_os_clone.

    TYPES: BEGIN OF ts_button,
             f01 TYPE rsfunc_txt,
             f02 TYPE rsfunc_txt,
             f03 TYPE rsfunc_txt,
             f04 TYPE rsfunc_txt,
             f05 TYPE rsfunc_txt,
             f06 TYPE rsfunc_txt,
             f07 TYPE rsfunc_txt,
             f08 TYPE rsfunc_txt,
             f09 TYPE rsfunc_txt,
             f10 TYPE rsfunc_txt,
             f11 TYPE rsfunc_txt,
             f12 TYPE rsfunc_txt,
             f13 TYPE rsfunc_txt,
             f14 TYPE rsfunc_txt,
             f15 TYPE rsfunc_txt,
             f16 TYPE rsfunc_txt,
             f17 TYPE rsfunc_txt,
             f18 TYPE rsfunc_txt,
             f19 TYPE rsfunc_txt,
             f20 TYPE rsfunc_txt,
             f21 TYPE rsfunc_txt,
             f22 TYPE rsfunc_txt,
             f23 TYPE rsfunc_txt,
             f24 TYPE rsfunc_txt,
             f25 TYPE rsfunc_txt,
           END OF ts_button,

           tt_exclude TYPE TABLE OF syucomm,
           tt_allowed TYPE TABLE OF syucomm.

    CLASS-DATA: ms_buttons  TYPE ts_button.

    CONSTANTS: mc_function_group TYPE string VALUE 'SAPLZAPP_GUI'.

    METHODS:
      constructor,
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
      show_button
        IMPORTING
          iv_button TYPE syucomm,
      get_toolbar
        RETURNING VALUE(rs_result) TYPE ts_button,
      add_separator
        IMPORTING
                  iv_button TYPE syucomm
        RAISING   zcx_app,
      show_title
        IMPORTING
          iv_text1 TYPE string
          iv_text2 TYPE string OPTIONAL
          iv_text3 TYPE string OPTIONAL
          iv_text4 TYPE string OPTIONAL,
      show_gui_status
        IMPORTING
          iv_modal TYPE abap_bool.

  PROTECTED SECTION.
    DATA: mt_allowed TYPE tt_allowed.

  PRIVATE SECTION.
    DATA: mv_dynamic  TYPE abap_bool,
          mt_excluded TYPE tt_exclude.

ENDCLASS.



CLASS zcl_app_gui_status IMPLEMENTATION.
  METHOD add_button.
    DATA ls_button TYPE smp_dyntxt.

    FIELD-SYMBOLS: <button> TYPE rsfunc_txt.

    CHECK iv_button IS NOT INITIAL.

    IF iv_text IS INITIAL AND iv_icon IS INITIAL.
      RAISE EXCEPTION TYPE zcx_app
        MESSAGE e014 WITH iv_button.
    ENDIF.

    ls_button-icon_id   = iv_icon.
    ls_button-icon_text = iv_text.
    ls_button-text      = iv_text.
    ls_button-quickinfo = iv_quickinfo.

    ASSIGN COMPONENT iv_button OF STRUCTURE ms_buttons TO <button>.

    IF <button> IS ASSIGNED.
      IF <button> IS INITIAL.
        <button> = ls_button.
        IF iv_allowed = abap_true.
          show_button( iv_button = iv_button ).
        ENDIF.
      ELSE.
        RAISE EXCEPTION TYPE zcx_app
          MESSAGE e012 WITH iv_button.
      ENDIF.
    ELSE.
      RAISE EXCEPTION TYPE zcx_app
        MESSAGE e013 WITH iv_button.
    ENDIF.
  ENDMETHOD.

  METHOD add_separator.
    TRY.
        add_button(
          iv_button              = iv_button
          iv_text                = |{ cl_abap_char_utilities=>minchar }|
          iv_allowed             = abap_true
        ).
      CATCH zcx_app INTO DATA(lx_error).
        RAISE EXCEPTION lx_error.
    ENDTRY.
  ENDMETHOD.

  METHOD if_os_clone~clone.
    SYSTEM-CALL OBJMGR CLONE me TO result.
  ENDMETHOD.

  METHOD constructor.
    CLEAR mt_excluded.

    APPEND zcl_app_dynpro=>mc_buttons-button1 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button2 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button3 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button4 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button5 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button6 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button7 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button8 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button9 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button10 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button11 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button12 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button13 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button14 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button15 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button16 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button17 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button18 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button19 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button20 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button21 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button22 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button23 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button24 TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_buttons-button25 TO mt_excluded.

    APPEND zcl_app_dynpro=>mc_commands-save TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_commands-print TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_commands-find TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_commands-find_more TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_commands-first_page TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_commands-previous_page TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_commands-next_page TO mt_excluded.
    APPEND zcl_app_dynpro=>mc_commands-last_page TO mt_excluded.
  ENDMETHOD.

  METHOD get_toolbar.
    rs_result = ms_buttons.
  ENDMETHOD.

  METHOD hide_button.
    CHECK iv_button IS NOT INITIAL.

    IF line_exists( mt_allowed[ table_line = iv_button ] ).
      DELETE mt_allowed WHERE table_line = iv_button.
      APPEND iv_button TO mt_excluded.
    ENDIF.
  ENDMETHOD.

  METHOD show_button.
    CHECK iv_button IS NOT INITIAL.

    IF NOT line_exists( mt_allowed[ table_line = iv_button ] ).
      APPEND iv_button TO mt_allowed.
      DELETE mt_excluded WHERE table_line EQ iv_button.
    ENDIF.
  ENDMETHOD.

  METHOD show_gui_status.
    IF iv_modal = abap_true.
      SET PF-STATUS 'MODAL' OF PROGRAM mc_function_group EXCLUDING mt_excluded.
      RETURN.
    ENDIF.

    SET PF-STATUS 'DIALOG' OF PROGRAM mc_function_group EXCLUDING mt_excluded.
  ENDMETHOD.

  METHOD show_title.
    SET TITLEBAR 'TITLE' OF PROGRAM mc_function_group WITH iv_text1 iv_text2 iv_text3 iv_text4.
  ENDMETHOD.
ENDCLASS.
