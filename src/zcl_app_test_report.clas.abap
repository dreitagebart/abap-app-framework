CLASS zcl_app_test_report DEFINITION
  PUBLIC
  INHERITING FROM zcl_app_report
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA: BEGIN OF ms_selopts,
            s_matnr TYPE matnr,
          END OF ms_selopts.

    METHODS:
      on_init REDEFINITION,
      on_pai REDEFINITION,
      on_pbo REDEFINITION,
      setup_output REDEFINITION,
      setup_selscreen REDEFINITION,
      selection_get_data REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_app_test_report IMPLEMENTATION.
  METHOD on_init.

  ENDMETHOD.

  METHOD on_pai.

  ENDMETHOD.

  METHOD on_pbo.

  ENDMETHOD.

  METHOD selection_get_data.

  ENDMETHOD.

  METHOD setup_output.

  ENDMETHOD.

  METHOD setup_selscreen.

  ENDMETHOD.
ENDCLASS.
