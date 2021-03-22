CLASS zcl_app_html_table_row DEFINITION
  INHERITING FROM zca_app_html
  PUBLIC
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_app_html_table.

  PUBLIC SECTION.

  PROTECTED SECTION.
    METHODS:
      parse REDEFINITION.

  PRIVATE SECTION.
    METHODS:
      constructor.

ENDCLASS.



CLASS zcl_app_html_table_row IMPLEMENTATION.
  METHOD parse.

  ENDMETHOD.

  METHOD constructor.
    super->constructor( zif_app_html=>tags-table_row ).
  ENDMETHOD.
ENDCLASS.
