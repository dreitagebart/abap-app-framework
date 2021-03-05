*&---------------------------------------------------------------------*
*& Report zapp_test_report
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zapp_test_report.

DATA go_app TYPE REF TO zcl_app_test_report.

SELECTION-SCREEN BEGIN OF BLOCK sel WITH FRAME TITLE gv_sel.
PARAMETERS: p_test  TYPE abap_bool AS CHECKBOX,
            p_matnr TYPE matnr.

SELECT-OPTIONS: s_matnr FOR go_app->ms_selopts-s_matnr.
SELECTION-SCREEN END OF BLOCK sel.

INITIALIZATION.
  go_app = CAST #( zcl_app_test_report=>get( ) ).

AT SELECTION-SCREEN OUTPUT.
  go_app->pbo( ).

AT SELECTION-SCREEN.
  go_app->pai( ).

START-OF-SELECTION.
  go_app->start_of_selection( ).
