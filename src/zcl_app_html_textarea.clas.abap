CLASS zcl_app_html_textarea DEFINITION
  PUBLIC
  INHERITING FROM zca_app_html
  FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_app_html.

  PUBLIC SECTION.
    METHODS:
      placeholder
        IMPORTING
          iv_placeholder TYPE string,
      value
        IMPORTING
          iv_value TYPE string.

  PROTECTED SECTION.
    METHODS:
      parse REDEFINITION.

  PRIVATE SECTION.
    DATA: mv_name        TYPE string,
          mv_placeholder TYPE string,
          mv_value       TYPE string.

    METHODS:
      constructor
        IMPORTING
          iv_name TYPE string.

ENDCLASS.



CLASS zcl_app_html_textarea IMPLEMENTATION.


  METHOD constructor.
    super->constructor( zif_app_html=>tags-textarea ).

    mv_name = iv_name.
  ENDMETHOD.


  METHOD parse.
    APPEND VALUE #( html = |<textarea id="{ mv_name }" name="{ mv_name }" placeholder="{ mv_placeholder }" onkeydown="onKeyDown(this)" value="{ mv_value }"></textarea>| ) TO rt_result.
  ENDMETHOD.


  METHOD placeholder.
    mv_placeholder = iv_placeholder.
  ENDMETHOD.


  METHOD value.
    mv_value = iv_value.
  ENDMETHOD.
ENDCLASS.
