FUNCTION Z_APP_DISPLAY_OUTPUT.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IO_APP) TYPE REF TO  ZCL_APP_REPORT
*"----------------------------------------------------------------------
  go_app = io_app.

  CALL SCREEN 2000.
ENDFUNCTION.
