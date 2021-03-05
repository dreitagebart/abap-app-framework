CLASS zcl_app_dynpro DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zcl_app_report
                 zcl_app_dialog.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_screen  TYPE sydynnr
          iv_program TYPE syrepid.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mv_screen  TYPE sydynnr,
          mv_program TYPE syrepid.

ENDCLASS.



CLASS zcl_app_dynpro IMPLEMENTATION.
  METHOD constructor.
    mv_screen = iv_screen.
    mv_program = iv_program.
  ENDMETHOD.
ENDCLASS.
