*&---------------------------------------------------------------------*
*& Report zapp_test_report
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zapp_test_report.

INCLUDE zapp_gui_connector.

DATA go_app TYPE REF TO zcl_app_test_report.

SELECTION-SCREEN BEGIN OF BLOCK sel WITH FRAME TITLE gv_sel.
SELECT-OPTIONS: s_carrid FOR go_app->ms_selopts-sflight-carrid DEFAULT 'LH',
                s_connid FOR go_app->ms_selopts-sflight-connid,
                s_pltype FOR go_app->ms_selopts-sflight-planetype.
SELECTION-SCREEN END OF BLOCK sel.

INITIALIZATION.
  go_app = CAST #( zcl_app_test_report=>get( ) ).

AT SELECTION-SCREEN OUTPUT.
  go_app->pbo( ).

AT SELECTION-SCREEN.
  go_app->pai( ).

START-OF-SELECTION.
  go_app->start_of_selection( ).
