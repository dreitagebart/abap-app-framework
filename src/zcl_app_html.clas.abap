CLASS zcl_app_html DEFINITION
  INHERITING FROM zca_app_html
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    EVENTS: on_click
              EXPORTING
                VALUE(iv_name) TYPE string,
            on_change
              EXPORTING
                VALUE(iv_name) TYPE string
                VALUE(iv_value) TYPE string,
            on_key_down
              EXPORTING
                VALUE(iv_name) TYPE string
                VALUE(iv_key) TYPE string
                VALUE(iv_value) TYPE string.

    CLASS-METHODS:
      factory
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_html.

    METHODS:
      form
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_html_form,
      output,
      p
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_html_p,
      br
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_html_br,
      list
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_html_list,
      textinput
        IMPORTING
                  iv_name          TYPE string
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_html_textinput,
      textarea
        IMPORTING
                  iv_name          TYPE string
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_html_textarea,
      button
        IMPORTING
                  iv_name          TYPE string
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_html_button,
      table
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_html_table,
      register_stylesheet
        IMPORTING
          iv_name TYPE string
          iv_url  TYPE string.

  PROTECTED SECTION.
    METHODS:
      parse REDEFINITION.

  PRIVATE SECTION.
    DATA: mo_viewer TYPE REF TO cl_gui_html_viewer,
          mt_output TYPE tt_output,
          mt_html   TYPE TABLE OF REF TO zca_app_html.

    METHODS:
      constructor,
      on_event FOR EVENT sapevent OF cl_gui_html_viewer
        IMPORTING
          action
          frame
          getdata
          postdata
          query_table.

ENDCLASS.



CLASS zcl_app_html IMPLEMENTATION.


  METHOD br.
    ro_result = NEW zcl_app_html_br( ).

    APPEND ro_result TO mt_html.
  ENDMETHOD.


  METHOD button.
    ro_result = NEW zcl_app_html_button( iv_name ).

    APPEND ro_result TO mt_html.
  ENDMETHOD.


  METHOD constructor.
    super->constructor( zif_app_html=>tags-html ).
  ENDMETHOD.


  METHOD factory.
    ro_result = NEW zcl_app_html( ).
  ENDMETHOD.


  METHOD form.
    ro_result = NEW zcl_app_html_form( ).

    APPEND ro_result TO mt_html.
  ENDMETHOD.


  METHOD p.
    ro_result = NEW zcl_app_html_p( ).

    APPEND ro_result TO mt_html.
  ENDMETHOD.

  METHOD list.
    ro_result = NEW zcl_app_html_list( ).

    APPEND ro_result TO mt_html.
  ENDMETHOD.


  METHOD on_event.
    SPLIT getdata AT '&' INTO TABLE DATA(lt_params).

    CASE action.
      WHEN zif_app_html=>events-on_change.
        RAISE EVENT on_change
          EXPORTING
            iv_name  = lt_params[ 1 ]
            iv_value = lt_params[ 2 ].
      WHEN zif_app_html=>events-on_click.
        RAISE EVENT on_click
          EXPORTING
            iv_name = lt_params[ 1 ].
      WHEN zif_app_html=>events-on_key_down.
        RAISE EVENT on_key_down
          EXPORTING
            iv_name  = lt_params[ 1 ]
            iv_key   = lt_params[ 2 ]
            iv_value = lt_params[ 3 ].
    ENDCASE.
  ENDMETHOD.


  METHOD output.
    DATA: lv_url    TYPE text1024,
          lt_events TYPE cntl_simple_events.

    APPEND VALUE #( html = |<html>| ) TO mt_output.
    APPEND VALUE #( html = |<body>| ) TO mt_output.
    APPEND VALUE #( html = |<script type="text/javascript">| ) TO mt_output.
    APPEND VALUE #( html = |function onKeyDown(element) \{| ) TO mt_output.
    APPEND VALUE #( html = |location.href = "SAPEVENT:{ zif_app_html=>events-on_key_down }?" + element.name + "&" + window.event.key + "&" + element.value + window.event.key + "&dummy";| ) TO mt_output.
    APPEND VALUE #( html = |\}| ) TO mt_output.
    APPEND VALUE #( html = |function onClick(element) \{| ) TO mt_output.
    APPEND VALUE #( html = |location.href = "SAPEVENT:{ zif_app_html=>events-on_click }?" + element.name + "&dummy";| ) TO mt_output.
    APPEND VALUE #( html = |\}| ) TO mt_output.
    APPEND VALUE #( html = |function onChange(element) \{| ) TO mt_output.
    APPEND VALUE #( html = |location.href = "SAPEVENT:{ zif_app_html=>events-on_change }?" + element.name + "&" + window.event.value + "&dummy";| ) TO mt_output.
    APPEND VALUE #( html = |\}| ) TO mt_output.
    APPEND VALUE #( html = |</script>| ) TO mt_output.

    LOOP AT mt_html REFERENCE INTO DATA(lr_html).
      LOOP AT lr_html->*->parse( ) REFERENCE INTO DATA(lr_output).
        APPEND lr_output->html TO mt_output.
      ENDLOOP.
    ENDLOOP.

    APPEND VALUE #( html = |</body>| ) TO mt_output.
    APPEND VALUE #( html = |</html>| ) TO mt_output.

    APPEND VALUE #( appl_event = abap_true
                    eventid    = cl_gui_html_viewer=>m_id_sapevent ) TO lt_events.

    mo_viewer = NEW cl_gui_html_viewer(
*      shellstyle               =
      parent                   = cl_gui_container=>default_screen
*      lifetime                 = lifetime_default
*      saphtmlp                 =
*      uiflag                   =
*      end_session_with_browser = 0
*      name                     =
*      saphttp                  =
*      query_table_disabled     = ''
    ).

    mo_viewer->set_registered_events( lt_events ).

    SET HANDLER on_event FOR mo_viewer.

    mo_viewer->load_data(
      IMPORTING
        assigned_url           = lv_url
      CHANGING
        data_table             = mt_output
    ).

    mo_viewer->show_url( lv_url ).
  ENDMETHOD.


  METHOD parse.

  ENDMETHOD.


  METHOD register_stylesheet.

  ENDMETHOD.


  METHOD table.
    ro_result = NEW zcl_app_html_table( ).

    APPEND ro_result TO mt_html.
  ENDMETHOD.


  METHOD textarea.
    ro_result = NEW zcl_app_html_textarea( iv_name ).

    APPEND ro_result TO mt_html.
  ENDMETHOD.


  METHOD textinput.
    ro_result = NEW zcl_app_html_textinput( iv_name ).

    APPEND ro_result TO mt_html.
  ENDMETHOD.
ENDCLASS.
