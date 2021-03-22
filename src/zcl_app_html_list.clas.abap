CLASS zcl_app_html_list DEFINITION
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
      constructor
        IMPORTING
          iv_name TYPE string OPTIONAL.

ENDCLASS.



CLASS zcl_app_html_list IMPLEMENTATION.
  METHOD constructor.
    super->constructor( zif_app_html=>tags-list ).
  ENDMETHOD.

  METHOD parse.

  ENDMETHOD.
ENDCLASS.
