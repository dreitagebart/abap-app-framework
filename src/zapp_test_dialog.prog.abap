*&---------------------------------------------------------------------*
*& Program zapp_test_dialog
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM zapp_test_dialog.

INCLUDE zapp_gui_connector.

DATA go_app TYPE REF TO zcl_app_test_dialog.

MODULE pbo OUTPUT.
  go_app = CAST #( zcl_app_test_dialog=>get( ) ).

  go_app->pbo( ).
ENDMODULE.

MODULE pai INPUT.
  go_app->pai( ).
ENDMODULE.
