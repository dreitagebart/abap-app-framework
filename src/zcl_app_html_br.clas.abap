CLASS zcl_app_html_br DEFINITION
  PUBLIC
  INHERITING FROM zca_app_html
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_app_html.

  PUBLIC SECTION.

  PROTECTED SECTION.
    METHODS:
      parse REDEFINITION.

  PRIVATE SECTION.
    METHODS:
      constructor.

ENDCLASS.



CLASS zcl_app_html_br IMPLEMENTATION.
  METHOD parse.
    APPEND VALUE #( html = '<br />' ) TO rt_result.
  ENDMETHOD.

  METHOD constructor.
    super->constructor( zif_app_html=>tags-break_line ).
  ENDMETHOD.
ENDCLASS.
