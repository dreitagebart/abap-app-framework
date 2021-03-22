CLASS zcl_app_html_paragraph DEFINITION
  PUBLIC
  INHERITING FROM zca_app_html
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.


  PROTECTED SECTION.
    METHODS:
      parse REDEFINITION.

  PRIVATE SECTION.
    METHODS:
      constructor.

ENDCLASS.



CLASS zcl_app_html_paragraph IMPLEMENTATION.
  METHOD constructor.
    super->constructor( zif_app_html=>tags-paragraph ).
  ENDMETHOD.

  METHOD parse.

  ENDMETHOD.
ENDCLASS.
