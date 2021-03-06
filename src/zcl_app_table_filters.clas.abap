CLASS zcl_app_table_filters DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          io_filters TYPE REF TO cl_salv_filters.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: mo_filters TYPE REF TO cl_salv_filters.

ENDCLASS.



CLASS zcl_app_table_filters IMPLEMENTATION.
  METHOD constructor.
    mo_filters = io_filters.
  ENDMETHOD.
ENDCLASS.
