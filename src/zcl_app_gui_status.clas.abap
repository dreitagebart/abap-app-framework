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
             f26 TYPE rsfunc_txt,
             f27 TYPE rsfunc_txt,
             f28 TYPE rsfunc_txt,
             f29 TYPE rsfunc_txt,
             f30 TYPE rsfunc_txt,
             f31 TYPE rsfunc_txt,
             f32 TYPE rsfunc_txt,
             f33 TYPE rsfunc_txt,
             f34 TYPE rsfunc_txt,
             f35 TYPE rsfunc_txt,
           END OF ts_button,

           BEGIN OF ts_allowed,
             function TYPE syucomm,
           END OF ts_allowed,

           tt_exclude TYPE TABLE OF syucomm,
           tt_allowed TYPE TABLE OF ts_allowed.

    CONSTANTS: mc_function_group TYPE string VALUE 'SAPLZAPP_GUI',
               b_01              TYPE sy-ucomm VALUE 'F01',
               b_02              TYPE sy-ucomm VALUE 'F02',
               b_03              TYPE sy-ucomm VALUE 'F03',
               b_04              TYPE sy-ucomm VALUE 'F04',
               b_05              TYPE sy-ucomm VALUE 'F05',
               b_06              TYPE sy-ucomm VALUE 'F06',
               b_07              TYPE sy-ucomm VALUE 'F07',
               b_08              TYPE sy-ucomm VALUE 'F08',
               b_09              TYPE sy-ucomm VALUE 'F09',
               b_10              TYPE sy-ucomm VALUE 'F10',
               b_11              TYPE sy-ucomm VALUE 'F11',
               b_12              TYPE sy-ucomm VALUE 'F12',
               b_13              TYPE sy-ucomm VALUE 'F13',
               b_14              TYPE sy-ucomm VALUE 'F14',
               b_15              TYPE sy-ucomm VALUE 'F15',
               b_16              TYPE sy-ucomm VALUE 'F16',
               b_17              TYPE sy-ucomm VALUE 'F17',
               b_18              TYPE sy-ucomm VALUE 'F18',
               b_19              TYPE sy-ucomm VALUE 'F19',
               b_20              TYPE sy-ucomm VALUE 'F20',
               b_21              TYPE sy-ucomm VALUE 'F21',
               b_22              TYPE sy-ucomm VALUE 'F22',
               b_23              TYPE sy-ucomm VALUE 'F23',
               b_24              TYPE sy-ucomm VALUE 'F24',
               b_25              TYPE sy-ucomm VALUE 'F25',
               b_26              TYPE sy-ucomm VALUE 'F26',
               b_27              TYPE sy-ucomm VALUE 'F27',
               b_28              TYPE sy-ucomm VALUE 'F28',
               b_29              TYPE sy-ucomm VALUE 'F29',
               b_30              TYPE sy-ucomm VALUE 'F30',
               b_31              TYPE sy-ucomm VALUE 'F31',
               b_32              TYPE sy-ucomm VALUE 'F32',
               b_33              TYPE sy-ucomm VALUE 'F33',
               b_34              TYPE sy-ucomm VALUE 'F34',
               b_35              TYPE sy-ucomm VALUE 'F35'.

    METHODS:
      constructor,
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
        RETURNING VALUE(rs_result) TYPE ts_button,
      add_separator
        IMPORTING
          iv_button TYPE syucomm,
      show_title
        IMPORTING
          iv_text1 TYPE string
          iv_text2 TYPE string OPTIONAL
          iv_text3 TYPE string OPTIONAL
          iv_text4 TYPE string OPTIONAL,
      show_gui_status.

  PROTECTED SECTION.
    DATA: mt_allowed TYPE tt_allowed.

  PRIVATE SECTION.
    DATA: mv_dynamic  TYPE abap_bool,
          mt_excluded TYPE tt_exclude,
          ms_buttons  TYPE ts_button.

ENDCLASS.



CLASS zcl_app_gui_status IMPLEMENTATION.
  METHOD add_button.
    DATA button TYPE smp_dyntxt.

    FIELD-SYMBOLS: <bt> TYPE rsfunc_txt.

    CHECK iv_button IS NOT INITIAL.

    IF iv_text IS INITIAL AND iv_icon IS INITIAL.
      RAISE icon_and_text_empty.
      RETURN.
    ENDIF.

    button-icon_id   = iv_icon.
    button-icon_text = iv_text.
    button-text      = iv_text.
    button-quickinfo = iv_quickinfo.

    ASSIGN COMPONENT iv_button OF STRUCTURE ms_buttons TO <bt>.

    IF <bt> IS ASSIGNED.
      IF <bt> IS INITIAL.
        <bt> = button.
        IF iv_allowed EQ abap_true.
          show_button( iv_button = iv_button ).
        ENDIF.
      ELSE.
        RAISE button_already_filled.
      ENDIF.
    ELSE.
      RAISE button_does_not_exist.
    ENDIF.
  ENDMETHOD.

  METHOD add_separator.
    add_button(
        EXPORTING
          iv_button              = iv_button
          iv_text                = |{ cl_abap_char_utilities=>minchar }|
*        iv_icon                = iv_icon
*        iv_qinfo               = iv_qinfo
           iv_allowed             = abap_true
        EXCEPTIONS
          button_already_filled  = 1
          button_does_not_exist  = 2
          icon_and_text_empty    = 3
          OTHERS                 = 4
      ).

    IF sy-subrc <> 0.
*     MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.

  METHOD if_os_clone~clone.
    SYSTEM-CALL OBJMGR CLONE me TO result.
  ENDMETHOD.

  METHOD constructor.
    DATA: ls_excluded_buttons LIKE LINE OF mt_excluded.

    REFRESH mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_01 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_02 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_03 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_04 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_05 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_06 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_07 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_08 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_09 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_10 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_11 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_12 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_13 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_14 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_15 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_16 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_17 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_18 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_19 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_20 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_21 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_22 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_23 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_24 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_25 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_26 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_27 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_28 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_29 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_30 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_31 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_32 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_33 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_34 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( b_35 ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( 'SAVE' ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( 'FIND' ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( 'FIND_MORE' ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( 'ALL_UP' ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( 'ALL_DOWN' ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( 'ONE_UP' ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( 'ONE_DOWN' ).
    APPEND ls_excluded_buttons TO mt_excluded.
    CLEAR: ls_excluded_buttons.
    ls_excluded_buttons = ( 'PRINT' ).
    APPEND ls_excluded_buttons TO mt_excluded.
  ENDMETHOD.

  METHOD get_toolbar.
    rs_result = ms_buttons.
  ENDMETHOD.

  METHOD hide_button.
    FIELD-SYMBOLS: <allowed_buttons> LIKE LINE OF mt_allowed.

    CHECK iv_button IS NOT INITIAL.

    READ TABLE mt_allowed ASSIGNING <allowed_buttons> WITH KEY function = iv_button.
    IF sy-subrc EQ 0.
      DELETE mt_allowed WHERE function = iv_button.
      APPEND iv_button TO mt_excluded.
    ENDIF.
  ENDMETHOD.

  METHOD show_button.
    DATA: allowed TYPE ts_allowed.

    FIELD-SYMBOLS: <allowed_buttons> LIKE LINE OF mt_allowed.

    CHECK iv_button IS NOT INITIAL.


    READ TABLE mt_allowed ASSIGNING <allowed_buttons> WITH KEY function = iv_button.
    IF sy-subrc NE 0.
      CLEAR allowed.

      allowed-function = iv_button.

      APPEND allowed TO mt_allowed.
      DELETE mt_excluded WHERE table_line EQ iv_button.
    ENDIF.
  ENDMETHOD.

  METHOD show_gui_status.
    SET PF-STATUS 'DIALOG' OF PROGRAM mc_function_group EXCLUDING mt_excluded.
  ENDMETHOD.

  METHOD show_title.
    SET TITLEBAR 'TITLE' OF PROGRAM mc_function_group WITH iv_text1 iv_text2 iv_text3 iv_text4.
  ENDMETHOD.
ENDCLASS.
