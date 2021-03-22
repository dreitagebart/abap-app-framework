CLASS zcl_app_html_table DEFINITION
  PUBLIC
  INHERITING FROM zca_app_html
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_app_html.

  PUBLIC SECTION.
    METHODS:
      row
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_html_table_row.

  PROTECTED SECTION.
    METHODS:
      parse REDEFINITION.

  PRIVATE SECTION.
    DATA: mt_children TYPE TABLE OF REF TO zca_app_html.

    METHODS:
      constructor.

ENDCLASS.



CLASS zcl_app_html_table IMPLEMENTATION.
  METHOD constructor.
    super->constructor( zif_app_html=>tags-table ).
  ENDMETHOD.

  METHOD parse.

  ENDMETHOD.

  METHOD row.
    ro_result = NEW zcl_app_html_table_row( ).

    APPEND ro_result TO mt_children.
  ENDMETHOD.
ENDCLASS.
