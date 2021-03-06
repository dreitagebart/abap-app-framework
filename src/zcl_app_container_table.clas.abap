CLASS zcl_app_container_table DEFINITION
  PUBLIC
  INHERITING FROM zca_app_container
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_name TYPE string
          iv_side TYPE i DEFAULT mc_sides-custom,
      create REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_app_container_table IMPLEMENTATION.
  METHOD create.

  ENDMETHOD.

  METHOD constructor.
    super->constructor(
      iv_name = iv_name
      iv_side = iv_side
    ).
  ENDMETHOD.
ENDCLASS.
