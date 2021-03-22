CLASS zca_app_html DEFINITION
  ABSTRACT
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_tag TYPE string.

  PROTECTED SECTION.
    TYPES: BEGIN OF ts_output,
             html TYPE text1024,
           END OF ts_output,

           BEGIN OF ts_html,
             tag  TYPE string,
             html TYPE REF TO zca_app_html,
           END OF ts_html,

           tt_output TYPE TABLE OF ts_output WITH DEFAULT KEY.

    METHODS:
      parse ABSTRACT
        RETURNING VALUE(rt_result) TYPE tt_output.

  PRIVATE SECTION.
    DATA: mv_tag TYPE string.

ENDCLASS.



CLASS zca_app_html IMPLEMENTATION.
  METHOD constructor.
    mv_tag = iv_tag.
  ENDMETHOD.
ENDCLASS.
