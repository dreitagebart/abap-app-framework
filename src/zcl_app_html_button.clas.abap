CLASS zcl_app_html_button DEFINITION
  PUBLIC
  INHERITING FROM zca_app_html
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_app_html.

  PUBLIC SECTION.
    METHODS:
      label
        IMPORTING
          iv_label TYPE string.

  PROTECTED SECTION.
    METHODS:
      parse REDEFINITION.

  PRIVATE SECTION.
    DATA: mv_name  TYPE string,
          mv_label TYPE string.

    METHODS:
      constructor
        IMPORTING
          iv_name TYPE string.

ENDCLASS.



CLASS zcl_app_html_button IMPLEMENTATION.
  METHOD parse.
    APPEND VALUE #( html = |<button name="{ mv_name }" onclick="onClick(this)">{ mv_label }</button>| ) TO rt_result.
  ENDMETHOD.

  METHOD constructor.
    super->constructor( zif_app_html=>tags-button ).

    mv_name = iv_name.
  ENDMETHOD.

  METHOD label.
    mv_label = iv_label.
  ENDMETHOD.
ENDCLASS.
