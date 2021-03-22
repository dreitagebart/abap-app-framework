*&---------------------------------------------------------------------*
*& Report ZAPP_TEST_HTML
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zapp_test_html.

CLASS lcl_app DEFINITION CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS:
      constructor,
      pai,
      pbo,
      run.

  PROTECTED SECTION.

  PRIVATE SECTION.
    TYPES: BEGIN OF ts_html,
             html TYPE text1024,
           END OF ts_html,

           tt_html TYPE TABLE OF ts_html.

    DATA: mo_html TYPE REF TO zcl_app_html.

    METHODS:
      handle_click FOR EVENT on_click OF zcl_app_html
        IMPORTING
          iv_name,
      handle_change FOR EVENT on_change OF zcl_app_html
        IMPORTING
          iv_name
          iv_value,
      handle_keydown FOR EVENT on_key_down OF zcl_app_html
        IMPORTING
          iv_name
          iv_key
          iv_value.

ENDCLASS.

DATA go_app TYPE REF TO lcl_app.

INITIALIZATION.
  go_app = NEW lcl_app( ).

START-OF-SELECTION.
  go_app->run( ).

CLASS lcl_app IMPLEMENTATION.
  METHOD run.
    CALL SCREEN 1000.
  ENDMETHOD.

  METHOD handle_change.
    BREAK developer.
  ENDMETHOD.

  METHOD handle_click.
    BREAK developer.
  ENDMETHOD.

  METHOD handle_keydown.
    BREAK developer.
  ENDMETHOD.

  METHOD constructor.
    mo_html = zcl_app_html=>factory( ).

    mo_html->button( 'Test' )->label( 'I do not want to buy this carpet' ).

    mo_html->break( ).

    mo_html->textinput( 'TextInput' )->placeholder( 'I do not want to buy this carpet' ).

    mo_html->break( ).

    mo_html->textarea( 'TextArea' )->placeholder( 'I do not want to' ).

    mo_html->output( ).

    SET HANDLER handle_change FOR mo_html.
    SET HANDLER handle_keydown FOR mo_html.
    SET HANDLER handle_click FOR mo_html.
  ENDMETHOD.

  METHOD pbo.
    SET PF-STATUS '1000'.
    SET TITLEBAR '1000'.
  ENDMETHOD.

  METHOD pai.
    CASE sy-ucomm.
      WHEN 'BACK'
        OR 'EXIT'
        OR 'CANCEL'.
        LEAVE PROGRAM.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

*&---------------------------------------------------------------------*
*& Module PBO OUTPUT
*&---------------------------------------------------------------------*
MODULE pbo OUTPUT.
  go_app->pbo( ).
ENDMODULE.

*&---------------------------------------------------------------------*
*& Module PAI INPUT
*&---------------------------------------------------------------------*
MODULE pai INPUT.
  go_app->pai( ).
ENDMODULE.
