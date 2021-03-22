CLASS zcl_app_html_form DEFINITION
  PUBLIC
  INHERITING FROM zca_app_html
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor.

  PROTECTED SECTION.
    METHODS:
      parse REDEFINITION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_app_html_form IMPLEMENTATION.
  METHOD constructor.
    super->constructor( zif_app_html=>tags-form ).
  ENDMETHOD.

  METHOD parse.

  ENDMETHOD.
ENDCLASS.
