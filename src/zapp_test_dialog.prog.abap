*&---------------------------------------------------------------------*
*& Program zapp_test_dialog
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM zapp_test_dialog.

DATA go_app TYPE REF TO zcl_app_test_dialog.

MODULE pbo OUTPUT.
  BREAK developer.
  go_app = CAST #( zcl_app_test_dialog=>get( ) ).

  go_app->pbo( ).
ENDMODULE.

MODULE pai INPUT.
  go_app->pai( ).
ENDMODULE.
