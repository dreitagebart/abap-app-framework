CLASS zcl_app_container_document DEFINITION
  PUBLIC
  INHERITING FROM zca_app_container
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
      create
        IMPORTING
                  iv_name          TYPE string
                  iv_side          TYPE int4 DEFAULT mc_sides-custom
        RETURNING VALUE(ro_result) TYPE REF TO zcl_app_container_document.

    METHODS:
      create_instance REDEFINITION,
      register_events REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          iv_name TYPE string
          iv_side TYPE int4.

    DATA: mo_document TYPE REF TO cl_dd_document.

ENDCLASS.



CLASS zcl_app_container_document IMPLEMENTATION.
  METHOD constructor.
    super->constructor(
      iv_name = iv_name
      iv_side = iv_side
    ).
  ENDMETHOD.

  METHOD create.
    ro_result = NEW zcl_app_container_document(
      iv_name = iv_name
      iv_side = iv_side
    ).
  ENDMETHOD.

  METHOD create_instance.
    mo_document = NEW cl_dd_document(
*                style            =
*                background_color =
*                bds_stylesheet   =
*                no_margins       =
                  ).

    register_events( ).
  ENDMETHOD.

  METHOD register_events.

  ENDMETHOD.
ENDCLASS.
