CLASS ltcl_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      first_test FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.
  METHOD first_test.
    BREAK developer.
    DATA(lo_html) = zcl_app_html=>factory( ).

    lo_html->button( 'Test' ).
  ENDMETHOD.
ENDCLASS.
