CLASS zcl_app_dynpro DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zcl_app_report
                 zcl_app_dialog.

  PUBLIC SECTION.
    TYPES: BEGIN OF ts_f4_value,
             value TYPE string,
           END OF ts_f4_value,

           tt_f4_value TYPE TABLE OF ts_f4_value WITH KEY value.

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
      get_f4_help_multi
        IMPORTING
                  iv_field         TYPE string
                  iv_column        TYPE string
                  iv_title         TYPE string
                  it_table         TYPE STANDARD TABLE
        RETURNING VALUE(rt_result) TYPE tt_f4_value
        RAISING   zcx_app,
      get_f4_help
        IMPORTING
                  iv_field         TYPE string
                  iv_column        TYPE string
                  iv_title         TYPE string
                  it_table         TYPE STANDARD TABLE
        RETURNING VALUE(rv_result) TYPE string
        RAISING   zcx_app,
      get_field_value
        IMPORTING
                  iv_field         TYPE string
        RETURNING VALUE(rv_result) TYPE string,
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
    DATA: lt_screen_flow TYPE TABLE OF d022s,
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
    IF mv_is_selscreen = abap_false.
      mo_gui->show_gui_status( mv_is_modal ).
    ENDIF.
  ENDMETHOD.

  METHOD show_title.
    mo_gui->show_title( mv_title ).
  ENDMETHOD.

  METHOD get_f4_help_multi.
    DATA: lv_reset  TYPE abap_bool,
          lt_return TYPE TABLE OF ddshretval.

    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
      EXPORTING
*       ddic_structure  = space
        retfield        = CONV fieldname( iv_column )
*       pvalkey         = space
        dynpprog        = mv_program
        dynpnr          = mv_screen
        dynprofield     = CONV dynfnam( iv_field )
*       stepl           = 0
        window_title    = CONV text100( iv_title )
*       value           = space
        value_org       = 'S'
        multiple_choice = abap_true
*       display         = space
*       callback_program = space
*       callback_form   = space
*       callback_method =
*       mark_tab        =
      IMPORTING
        user_reset      = lv_reset
      TABLES
        value_tab       = it_table
*       field_tab       =
        return_tab      = lt_return
*       dynpfld_mapping =
      EXCEPTIONS
        parameter_error = 1
        no_values_found = 2
        OTHERS          = 3.

    IF lv_reset = abap_true.
      RAISE EXCEPTION TYPE zcx_app
        MESSAGE e023.
    ENDIF.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_app
        EXPORTING
          textid = VALUE #( msgid = sy-msgid
                            msgno = sy-msgno ).
    ENDIF.

    LOOP AT lt_return REFERENCE INTO DATA(lr_return).
      APPEND VALUE #( value = lr_return->fieldval ) TO rt_result.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_f4_help.
    DATA: lv_reset  TYPE abap_bool,
          lt_return TYPE TABLE OF ddshretval.

    CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
      EXPORTING
*       ddic_structure  = space
        retfield        = CONV fieldname( iv_column )
*       pvalkey         = space
        dynpprog        = mv_program
        dynpnr          = mv_screen
        dynprofield     = CONV dynfnam( iv_field )
*       stepl           = 0
        window_title    = CONV text100( iv_title )
*       value           = space
        value_org       = 'S'
        multiple_choice = abap_false
*       display         = space
*       callback_program = space
*       callback_form   = space
*       callback_method =
*       mark_tab        =
      IMPORTING
        user_reset      = lv_reset
      TABLES
        value_tab       = it_table
*       field_tab       =
        return_tab      = lt_return
*       dynpfld_mapping =
      EXCEPTIONS
        parameter_error = 1
        no_values_found = 2
        OTHERS          = 3.

    IF lv_reset = abap_true.
      RAISE EXCEPTION TYPE zcx_app
        MESSAGE e023.
    ENDIF.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_app
        MESSAGE ID sy-msgid
        TYPE 'E'
        NUMBER sy-msgno
        WITH
        sy-msgv1
        sy-msgv2
        sy-msgv3
        sy-msgv4.
    ENDIF.

    TRY.
        rv_result = lt_return[ 1 ]-fieldval.
      CATCH cx_sy_itab_line_not_found.
        RAISE EXCEPTION TYPE zcx_app
          MESSAGE e022.
    ENDTRY.
  ENDMETHOD.

  METHOD get_field_value.
    DATA(lt_fields) = VALUE dynpread_tabtype( ( fieldname = iv_field ) ).

    CALL FUNCTION 'DYNP_VALUES_READ'
      EXPORTING
        dyname               = mv_program
        dynumb               = mv_screen
        translate_to_upper   = abap_true
*       request              = space
*       perform_conversion_exits       = space
*       perform_input_conversion       = space
*       determine_loop_index = space
*       start_search_in_current_screen = space
*       start_search_in_main_screen    = space
*       start_search_in_stacked_screen = space
*       start_search_on_scr_stackpos   = space
*       search_own_subscreens_first    = space
*       searchpath_of_subscreen_areas  = space
      TABLES
        dynpfields           = lt_fields
      EXCEPTIONS
        invalid_abapworkarea = 1
        invalid_dynprofield  = 2
        invalid_dynproname   = 3
        invalid_dynpronummer = 4
        invalid_request      = 5
        no_fielddescription  = 6
        invalid_parameter    = 7
        undefind_error       = 8
        double_conversion    = 9
        stepl_not_found      = 10
        OTHERS               = 11.

    TRY.
        rv_result = lt_fields[ fieldname = iv_field ]-fieldvalue.
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
