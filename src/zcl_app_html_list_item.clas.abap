CLASS zcl_app_html_list_item DEFINITION
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



CLASS zcl_app_html_list_item IMPLEMENTATION.
  METHOD parse.

  ENDMETHOD.

  METHOD constructor.
    super->constructor( zif_app_html=>tags-list_item ).
  ENDMETHOD.
ENDCLASS.
